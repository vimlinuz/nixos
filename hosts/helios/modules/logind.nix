{
  config,
  lib,
  ...
}:
{
  options = {
    logind.enable = lib.mkEnableOption "Enable systemd logind settings";
  };
  config = lib.mkIf config.logind.enable {
    #Configure systemd logind settings
    services.logind = {
      settings.Login = {

        # when the lid is closed
        HandleLidSwitch = "suspend-then-hibernate";
        # when multiple displays are connected
        lidSwitchDocked = "ignore";
        # when on external power
        HandleLidSwitchExternalPower = "lock";

        # idle settings
        IdleAction = "suspend-then-hibernate";
        IdleActionSec = "600"; # 10 minutes

        # power button settings
        HandlePowerKey = "suspend-then-hibernate";
        HandlePowerKeyLongPress = "poweroff";

        PowerKeyIgnoreInhibited = "no";
        LidSwitchIgnoreInhibited = "yes";

        # waits before executing actions
        HoldoffTimeoutSec = "30";
      };
    };
  };
}
