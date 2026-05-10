<h1 id="header" align="center">
  <img src="../../../../.github/assets/nixvim_logo.svg" alt="neovim-flake Logo"  width="128px" height="128px" />

  <br>
    nixvim
</h1>

This directory contains modular configuration for Neovim, managed using Nix and [nixvim](https://github.com/nix-community/nixvim).

---

## Directory Structure

```
.
├── core
│   ├── autocommands.nix
│   ├── autocompletion.nix
│   ├── code-runner.nix
│   ├── keymaps.nix
│   ├── lsp.nix
│   └── opts.nix
├── nixvim.nix
├── plugins
│   ├── alpha.nix
│   ├── colorschemes.nix
│   ├── comment.nix
│   ├── copilot.nix
│   ├── gitsigns.nix
│   ├── harpoon.nix
│   ├── indent-blankline.nix
│   ├── lualine.nix
│   ├── misc.nix
│   ├── none-ls.nix
│   ├── surround.nix
│   ├── telescope.nix
│   └── treesitter.nix
└── readme.md
```

---

## Module Overview

- **core/**
  - `autocommands.nix`: Custom Neovim autocommands.
  - `autocompletion.nix`: Completion and snippet engine configuration.
  - `code-runner.nix`: Code execution helpers.
  - `keymaps.nix`: Keybinding definitions.
  - `lsp.nix`: Language Server Protocol (LSP) setup.
  - `opts.nix`: General Neovim options.

- **plugins/**
  - Individual plugin configurations (UI, Git, commenting, etc).

- **nixvim.nix**
  - Entrypoint for importing and composing all modules.

---
