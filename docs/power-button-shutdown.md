# Power button powers off instead of hibernating

Debugging notes for `helios` (Lenovo IdeaPad 82H8).

- **Date:** 2026-10-25 (initial diagnosis), 2026-11-01 (root cause confirmed)
- **System:** NixOS 26.11, kernel `6.18.59`, systemd `262`, niri `26.04`
- **Symptom:** pressing the power button immediately powers the machine off,
  regardless of `services.logind.settings.Login.HandlePowerKey`.

---

## TL;DR

The kernel module `tiny_power_button` (new in kernel 6.18, built with
`CONFIG_ACPI_TINY_POWER_BUTTON_SIGNAL=38`) grabs the ACPI power button and
sends `SIGRTMIN+4` (systemd's "poweroff now" signal) straight to PID 1.
This bypasses logind completely, so `HandlePowerKey = "hibernate"` (or
`"ignore"`) is never executed.

Fix: blacklist the module and let the normal `acpi-button` driver deliver
the key to logind.

```nix
boot.blacklistedKernelModules = [ "tiny_power_button" ];
```

---

## 1. First suspicion: logind config (was fine)

`/etc/systemd/logind.conf` is generated from
`hosts/helios/modules/logind.nix` and contained:

```ini
HandlePowerKey=hibernate
HandlePowerKeyLongPress=poweroff
PowerKeyIgnoreInhibited=no
HandleLidSwitch=suspend-then-hibernate
```

The settings were being applied correctly — the D-Bus properties on
`org.freedesktop.login1.Manager` matched the file. So logind was configured
as intended and it still powered off.

Useful checks:

```bash
grep -n 'HandlePowerKey\|HandleLidSwitch' /etc/systemd/logind.conf
busctl get-property org.freedesktop.login1 /org/freedesktop/login1 \
  org.freedesktop.login1.Manager HandlePowerKey HandlePowerKeyLongPress
```

## 2. Second suspicion: niri inhibitor (real, but secondary)

niri takes a `block` inhibitor on `handle-power-key` and has its own default
action for the key (`Action::Suspend`, i.e. plain suspend):

```bash
systemd-inhibit --list
# WHO   ... WHAT             WHY                  MODE
# niri  ... handle-power-key Power key handling   block
```

Because of that inhibitor, logind's `HandlePowerKey` action would be skipped
even without any kernel involvement, and niri would request `Suspend` over
D-Bus. This can be disabled in niri's config with `disable-power-key-handling`
(`homes/santosh/config/niri/config.kdl`), but it is **not** what causes the
immediate poweroff.

This also explains the occasional journal line
`suspend requested from client PID ... ('niri')`, which loses the race against
the already-queued poweroff transaction.

## 3. The real cause: `SIGRTMIN+4` sent to PID 1

Every press produces this, with no sender PID (kernel-originated):

```
systemd[1]: Received SIGRTMIN+4.
systemd-logind: Power key pressed short.
systemd[1]: Activating special unit System Power Off...
```

`SIGRTMIN+4` is systemd's poweroff signal (`SIGRTMIN+5` reboot, `+6` halt,
`+7` kexec). Some kernel code is calling `kill_cad_pid(38, 1)` on the press.

Inspect the suspicious module:

```bash
$ cat /sys/module/tiny_power_button/parameters/power_signal
38

$ modinfo tiny_power_button
description: ACPI Tiny Power Button Driver
author:      Josh Triplett
alias:       acpi*:LNXPWRBN:*
alias:       acpi*:PNP0C0C:*
parm:        power_signal:Power button sends this signal to init (int)

$ zcat /proc/config.gz | grep -i TINY_POWER
CONFIG_ACPI_TINY_POWER_BUTTON=m
CONFIG_ACPI_TINY_POWER_BUTTON_SIGNAL=38
```

Driver source (`drivers/acpi/tiny-power-button.c`):

```c
static int power_signal __read_mostly = CONFIG_ACPI_TINY_POWER_BUTTON_SIGNAL;
module_param(power_signal, int, 0644);

static void acpi_tiny_power_button_notify(acpi_handle handle, u32 event, void *data)
{
        kill_cad_pid(power_signal, 1);   /* signal PID 1 */
}
```

It is auto-loaded by udev from the ACPI modalias and is bound to the power
button device:

```bash
$ readlink -f /sys/bus/acpi/devices/PNP0C0C:00/driver
/sys/bus/acpi/drivers/tiny-power-button
```

Meanwhile the normal `acpi-button` driver still creates the input device
(`/proc/bus/input/devices` → `Power Button`, `event7`), which is why logind
logs `Power key pressed short.` — it sees the key, obeys `HandlePowerKey`,
and is irrelevant, because the signal to PID 1 already queued the poweroff.

## 4. Fix

Applied in `hosts/helios/configuration.nix` inside `boot = { ... }`:

```nix
# Kernel 6.18 enables the ACPI "tiny" power button driver, which grabs
# the power button and sends SIGRTMIN+4 (= systemd poweroff) straight to
# PID 1, bypassing logind.  Blacklist it so the normal ACPI button driver
# delivers the key to logind and HandlePowerKey is honoured.
blacklistedKernelModules = [ "tiny_power_button" ];
```

Apply immediately without rebooting (the module is not held, so it unloads):

```bash
sudo modprobe -r tiny_power_button

# if it reports "Module ... is in use", unbind first:
echo PNP0C0C:00 | sudo tee /sys/bus/acpi/drivers/tiny-power-button/unbind
sudo modprobe -r tiny_power_button
```

Make it persistent:

```bash
sudo nixos-rebuild switch --flake /home/santosh/nixos#helios
```

Verification after rebuild/reboot:

```bash
lsmod | grep tiny_power_button    # no output
grep -A4 'Name="Power Button"' /proc/bus/input/devices  # event device still present
```

With `HandlePowerKey = "ignore"` a short press then does nothing;
`HandlePowerKeyLongPress = "poweroff"` still gives a safety fallback.

Revert by removing the `blacklistedKernelModules` line.

## 5. Hibernation is still not configured

Even with the module blacklisted, `HandlePowerKey = "hibernate"` will not
resume properly on this machine yet:

```bash
cat /proc/cmdline        # no resume=
cat /sys/power/resume    # 0:0
```

Swap (`/dev/nvme0n1p3`, UUID `aca30817-a70f-413c-8ee7-d06297c7e303`) is 17 G
against 15 G RAM, so it is large enough. To make hibernate work:

```nix
# hosts/helios/hardware-configuration.nix or configuration.nix
boot.resumeDevice = "/dev/disk/by-uuid/aca30817-a70f-413c-8ee7-d06297c7e303";
```

and set `HandlePowerKey = "hibernate"` again in
`hosts/helios/modules/logind.nix`. Without `resume=`, hibernation degrades to
plain suspend and the session is lost on wake.

Optionally, to stop niri from requesting its own `Suspend` action, add
`disable-power-key-handling` to `homes/santosh/config/niri/config.kdl`.

---

## Appendix: quick reference

| Item          | Value                                                      |
| ------------- | ---------------------------------------------------------- |
| Signal        | `38` = `SIGRTMIN+4` = systemd poweroff                     |
| Module        | `tiny_power_button` (`drivers/acpi/tiny-power-button.c`)   |
| Kconfig       | `CONFIG_ACPI_TINY_POWER_BUTTON=m`, `..._SIGNAL=38`         |
| ACPI device   | `PNP0C0C:00` (aliases `PNP0C0C`, `LNXPWRBN`)               |
| Runtime param | `/sys/module/tiny_power_button/parameters/power_signal`    |
| logind config | `hosts/helios/modules/logind.nix`                          |
| Fix           | `boot.blacklistedKernelModules = [ "tiny_power_button" ];` |

Other ways to neutralise it (not used here):

- `boot.extraModprobeConfig = "options tiny_power_button power_signal=0";`
  — keeps the module loaded but makes it `kill(1, 0)`, i.e. a no-op. Fragile
  and non-obvious; blacklisting is clearer. Reverting the module option to
  `38` (or upgrading kernels) can silently bring the poweroff back.
- Rebuild the kernel with `CONFIG_ACPI_TINY_POWER_BUTTON=n` via
  `boot.kernelPatches` / `structuredExtraConfig` — heaviest option.
