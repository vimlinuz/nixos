{
  pkgs,
  ...
}:
{
  programs.mnw = {
    enable = true;
    initLua = ''
      require("init")
    '';
    plugins = {
      start = [
        pkgs.vimPlugins.oil-nvim
        pkgs.vimPlugins.alpha-nvim
        pkgs.vimPlugins.vague-nvim
        pkgs.vimPlugins.comment-nvim
        pkgs.vimPlugins.harpoon2
        pkgs.vimPlugins.telescope-nvim
        pkgs.vimPlugins.which-key-nvim
        pkgs.vimPlugins.vim-tpipeline
        pkgs.vimPlugins.lualine-nvim
        pkgs.vimPlugins.surround-nvim
        pkgs.vimPlugins.snacks-nvim
        pkgs.vimPlugins.nvim-notify
        pkgs.vimPlugins.markdown-preview-nvim
        pkgs.vimPlugins.undotree
        pkgs.vimPlugins.vim-fugitive
        pkgs.vimPlugins.gitsigns-nvim
        pkgs.vimPlugins.vim-rhubarb
        pkgs.vimPlugins.auto-pairs
        pkgs.vimPlugins.todo-comments-nvim
        pkgs.vimPlugins.colorizer
        pkgs.vimPlugins.cord-nvim
        pkgs.vimPlugins.nvim-web-devicons
        pkgs.vimPlugins.lspsaga-nvim
        pkgs.vimPlugins.lspkind-nvim
        pkgs.vimPlugins.nvim-cmp
        pkgs.vimPlugins.luasnip
        pkgs.vimPlugins.lsp-format-nvim
        pkgs.vimPlugins.nvim-ufo
        pkgs.vimPlugins.null-ls-nvim
        pkgs.vimPlugins.cmp-git
        pkgs.vimPlugins.black-metal-theme-neovim
        pkgs.vimPlugins.indent-blankline-nvim
        pkgs.vimPlugins.noice-nvim
        pkgs.vimPlugins.catppuccin-nvim
        pkgs.vimPlugins.copilot-cmp
        pkgs.vimPlugins.copilot-lua
        pkgs.vimPlugins.cmp-calc
        pkgs.vimPlugins.cmp-buffer
        pkgs.vimPlugins.cmp-cmdline
        pkgs.vimPlugins.cmp-dotenv
        pkgs.vimPlugins.cmp-nvim-lsp
        pkgs.vimPlugins.cmp-async-path
        pkgs.vimPlugins.cmp-conventionalcommits
        pkgs.vimPlugins.cmp-emoji

        pkgs.vimPlugins.nvim-treesitter
        pkgs.vimPlugins.nvim-treesitter-context
        pkgs.vimPlugins.telescope-fzf-native-nvim
      ];

      dev.myconfig = {
        pure = ./.;
        impure = toString ./.;
      };
    };
  };
}
