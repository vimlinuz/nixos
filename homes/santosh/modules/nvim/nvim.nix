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
      ];

      dev.myconfig = {
        pure = ./.;
        impure = toString ./.;
      };
    };
  };
}
