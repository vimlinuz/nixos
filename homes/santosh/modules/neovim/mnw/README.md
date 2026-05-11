This directory contains modular configuration for Neovim, managed using Nix to install plugins and [mnw](https://github.com/Gerg-L/mnw) to wrap them.

---

## Acknowledgments

This configuration draws inspiration and help from:

- [nix-community/nixvim](https://github.com/nix-community/nixvim)
- [NobbZ/nobbz-vim](https://github.com/NobbZ/nobbz-vim)
- [sachinchaudhary1808/nvim](https://github.com/sachinchaudhary1808/nvim)

---

```
.
├── lua
│   ├── core
│   │   ├── autocommand.lua
│   │   ├── colorscheme.lua
│   │   ├── diagnostics.lua
│   │   ├── keymaps.lua
│   │   └── opts.lua
│   ├── init.lua
│   ├── lazy
│   │   └── bigfile.lua
│   ├── plugins
│   │   ├── alpla.lua
│   │   ├── blink-cmp.lua
│   │   ├── cmp.lua
│   │   ├── comment.lua
│   │   ├── copilot.lua
│   │   ├── git.lua
│   │   ├── harpoon.lua
│   │   ├── lsp.lua
│   │   ├── lspsaga.lua
│   │   ├── lualine.lua
│   │   ├── misc.lua
│   │   ├── noice.lua
│   │   ├── notify.lua
│   │   ├── null-ls.lua
│   │   ├── oil.lua
│   │   ├── telescope.lua
│   │   ├── treesitter.lua
│   │   ├── ufo.lua
│   │   └── which-key.lua
│   └── utils
│       ├── jutsu.lua
│       └── term.lua
├── nvim.nix
└── README.md
```

---

## File Overview

- **init.lua** - Entry point; requires all core and plugin modules.
- **nvim.nix** - Nix module that wraps Neovim with mnw, declares plugins and LSP servers.

### lua/core/

- All the core configurations,opts, keymaps and autocommands.

### lua/plugins/

- All the plugin configurations.
- misc.lua contains plugins that are just required

### lua/lazy/

- Lazily-loaded plugins by the use of [lz.n](https://github.com/lumen-oss/lz.n)

### lua/utils/

- Utility modules (currently commented out in init.lua).

---
