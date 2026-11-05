<h1 align="center">
  <img src=".github/assets/nix-snowflake-colours.svg" width="128px" height="128px" />
  <br>
  nixos
</h1>

<div align="center">
  <h1> Personal NixOS & Home Manager Configuration.</h1> <br/>
</div>

> [!CAUTION]
> This repository contains my personal NixOS and Home Manager configuration.  
> **Do not use, fork, or adapt this configuration unless you fully understand every part of it.**  
> It is tailored for my hardware, workflow, and preferences, and is not intended for external use or collaboration.

---

## Overview

This repository manages my entire NixOS system and user environment using Nix flakes and Home Manager.  
It provides a reproducible, declarative setup for my daily development and desktop needs.

---

## Features

- **NixOS System Configuration:** Full system-level setup, hardware-specific
- **Home Manager Integration:** User-level dotfiles and app configs, managed via flakes
- **Modern Desktop:** Niri (Wayland), custom theming, multi-monitor support
- **Development Environment:** Neovim (mnw), dev tools, shells, and utilities
- **Modular Structure:** Organized for easy personal maintenance and extension

---

## Repository Structure

```
.
├── .github/
│   └── assets/
├── .githooks/
│   └── pre-commit
├── docs/
│   └── power-button-shutdown.md
├── .editorconfig
├── treefmt.nix
├── flake.nix
├── flake.lock
├── overlay.nix
├── hosts/
│   └── helios/
│       ├── configuration.nix
│       ├── hardware-configuration.nix
│       └── modules/
├── homes/
│   └── santosh/
│       ├── home.nix
│       ├── config/
│       │   ├── kitty/
│       │   └── niri/
│       ├── modules/
│       │   ├── bars/
│       │   ├── browsers/
│       │   ├── editors/
│       │   ├── pkgs/
│       │   ├── scripts/
│       │   ├── shell/
│       │   ├── starship/
│       │   ├── terminals/
│       │   ├── tmux/
│       │   └── vesktop/
│       └── scripts/
├── secrets/
├── LICENSE
└── README.md
```

---

## Architecture Notes

- **Flake-based:** Locked dependencies for reproducible builds
- **Home Manager:** Integrated into system config for unified rebuilds
- **Modular Design:** Clean separation for system, user, and host-specific configs

---

## Formatting

The whole repository is formatted with [treefmt](https://numtide.github.io/treefmt)
through `treefmt.nix`. Nix, Lua, shell, Markdown, CSS, YAML, and TOML use
two-space indentation with spaces instead of tabs.

```sh
nix fmt                      # format the whole repository
nix flake check              # verify formatting without writing changes
nix fmt -- path/to/file      # format specific paths
```

### Pre-commit hook

A Git pre-commit hook formats staged files before each commit. Enable it once
per clone:

```sh
git config core.hooksPath .githooks
```

Jujutsu does not run Git hooks. When committing with `jj`, run the configured
alias first:

```sh
jj fmt                       # runs `nix fmt`
jj new                       # or `jj commit`
```

---

## Contributing

> **Note:**  
> This is a personal configuration repository for NixOS and Home Manager.  
> Contributions, issues, or pull requests are **not** accepted as this repository is entirely tailored to my specific hardware, workflow, and preferences.

---

**Thinking of using NixOS or Home Manager?**  
I strongly recommend you build your own configuration from scratch, tailored to your hardware and workflow.  
Here are some excellent resources to help you get started:

- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [NixOS Wiki](https://nixos.wiki/)
- [Home Manager Manual](https://nix-community.github.io/home-manager/)
- [Awesome Nix](https://github.com/nix-community/awesome-nix)
- [Home Manager Options](https://home-manager-options.extranix.com/)
