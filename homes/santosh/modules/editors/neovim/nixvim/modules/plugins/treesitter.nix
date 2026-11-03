{ config, lib, ... }:
{
  options = {
    treesitter.enable = lib.mkEnableOption "Enable treesitter and related plugins";
  };
  config = lib.mkIf config.treesitter.enable {
    programs.nixvim.plugins.treesitter = {
      enable = true;
      folding = {
        enable = false;
      };
      settings = {
        indent.enable = true;
        highlight.enable = true;
      };
    };

    programs.nixvim.plugins.treesitter-context = {
      enable = true;
      settings = {
        enable = true;
        max_lines = 5;
        min_window_height = 0;
        line_numbers = true;
        multiline_threshold = 20;
        # Which context lines to discard if max_lines is exceeded.
        trim_scope = "outer";
        mode = "cursor";
        # separator = "-";
        zindex = 90;
      };
    };

    programs.nixvim.plugins.treesitter-textobjects = {
      enable = true;
      settings = {
        select = {
          enable = true;
          lookahead = true;

          keymaps = {
            "af" = "@function.outer";
            "if" = "@function.inner";
            "ac" = "@class.outer";
            "ic" = {
              query = "@class.inner";
              desc = "Select inner class";
            };
            "as" = {
              query = "@local.scope";
              queryGroup = "locals";
              desc = "Select language scope";
            };
            "aa" = "@parameter.outer";
            "ia" = "@parameter.inner";
            "il" = "@loop.inner";
            "al" = "@loop.outer";
          };

          selectionModes = {
            "@parameter.outer" = "v";
            "@function.outer" = "V";
            "@class.outer" = "<c-v>";
          };

          includeSurroundingWhitespace = true;
        };
      };
    };
  };
}
