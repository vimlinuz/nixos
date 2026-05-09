rec {
  imports = import ./modules/default.nix;

  # ╭───────────────────────────────────────────────╮
  # │ UI and Appearance Plugins                     │
  # ╰───────────────────────────────────────────────╯
  alpha.enable = true;
  colorschemes.enable = true;
  indent-blankline.enable = true;
  lualine.enable = true;
  notify.enable = true;
  snacks.enable = true;
  vim-tpipeline.enable = true;

  # ╭───────────────────────────────────────────────╮
  # │ AI and Automation Plugins                     │
  # ╰───────────────────────────────────────────────╯
  avante.enable = true;
  copilot-lua.enable = true;
  copilot-chat.enable = copilot-lua.enable;
  justu.enable = true;

  # ╭───────────────────────────────────────────────╮
  # │ Git and Navigation Plugins                    │
  # ╰───────────────────────────────────────────────╯
  cord.enable = true;
  gitsigns.enable = true;
  harpoon.enable = true;

  # ╭───────────────────────────────────────────────╮
  # │ Essential Functional Plugins                  │
  # ╰───────────────────────────────────────────────╯
  ufo.enable = true;

  # ╭───────────────────────────────────────────────╮
  # │ Core Functionality Plugins                    │
  # ╰───────────────────────────────────────────────╯
  autocommands.enable = true;
  lsp.enable = true;
  autocompletion.enable = true;
  comment.enable = true;
  misc.enable = true;
  formatter.enable = true;
  noice.enable = true;
  oil.enable = true;
  surround.enable = true;
  telescope.enable = true;
  treesitter.enable = true;
  which-key.enable = true;
  terminal.enable = true;
  opts.enable = true;
  keymaps.enable = true;

  programs.nixvim = {
    nixpkgs.useGlobalPackages = true;
    enable = false;
    editorconfig = {
      enable = true;
    };
  };
}
