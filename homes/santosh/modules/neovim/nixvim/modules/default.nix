[
  # ╭───────────────────────────────────────────────╮
  # │ Core Configuration Modules (Always Enabled)   │
  # ╰───────────────────────────────────────────────╯
  ./core/keymaps.nix
  ./core/lsp.nix
  ./core/autocompletion.nix
  ./core/terminal.nix
  ./core/opts.nix
  ./core/autocommands.nix
  ./core/justu.nix

  # ╭───────────────────────────────────────────────╮
  # │ Essential Functional Plugins                  │
  # ╰───────────────────────────────────────────────╯
  ./plugins/harpoon.nix
  ./plugins/surround.nix
  ./plugins/formatter.nix
  ./plugins/comment.nix
  ./plugins/misc.nix
  ./plugins/treesitter.nix
  ./plugins/telescope.nix
  ./plugins/ufo.nix

  # ╭───────────────────────────────────────────────╮
  # │ UI Plugins                                    │
  # ╰───────────────────────────────────────────────╯
  ./plugins/gitsigns.nix
  ./plugins/colorschemes.nix
  ./plugins/snacks.nix
  ./plugins/vim-tpipeline.nix

  # ╭───────────────────────────────────────────────╮
  # │ Full mode: all overwhelming plugins           │
  # ╰───────────────────────────────────────────────╯
  ./plugins/lualine.nix
  ./plugins/which-key.nix
  ./plugins/oil.nix
  ./plugins/alpha.nix
  ./plugins/indent-blankline.nix
  ./plugins/notify.nix
  ./plugins/cord.nix
  ./plugins/noice.nix
  # ╭───────────────────────────────────────────────╮
  # │ Ai Plugins                                    │
  # ╰───────────────────────────────────────────────╯
  ./plugins/copilot.nix
  ./plugins/avante.nix
  ./plugins/copilot-chat.nix
]
