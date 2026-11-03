{ config, lib, ... }:
{
  options = {
    misc.enable = lib.mkEnableOption "Enable miscellaneous plugins for nixvim";
  };
  config = lib.mkIf config.misc.enable {
    programs.nixvim.plugins = {
      # automatically save files
      auto-save = {
        enable = false;
      };
      # neotest for running tests
      neotest = {
        enable = false;
      };
      # Mmarkdown-preview in browser
      markdown-preview = {
        enable = true;
      };
      # icons
      web-devicons = {
        enable = true;
      };
      # Markdown renderer
      render-markdown = {
        enable = true;
      };

      # Undotree by jiaoshijie
      undotree = {
        enable = true;
      };

      # Tmux & split window navigation
      tmux-navigator = {
        enable = true;
      };

      # Powerful Git integration for Vim
      fugitive = {
        enable = true;
      };

      # To make the  GBrowse work of the fugitive
      rhubarb = {
        enable = true;
      };

      # Autoclose parentheses, brackets, quotes, etc.
      nvim-autopairs = {
        enable = true;
      };

      # Highlight todo, notes, etc in comments
      todo-comments = {
        enable = true;
        settings = {
          signs = false;
        };
      };

      # Sets up nvim lsp for the rust_analyzer automatically
      rustaceanvim = {
        enable = false;
      };

      # High-performance color highlighter
      colorizer = {
        enable = true;
      };
    };
  };
}
