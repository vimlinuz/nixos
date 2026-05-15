{ pkgs, ... }:
{
  programs.alacritty = {
    enable = true;

    settings = {
      env = {
        TERM = "xterm-256color";
        LANG = "en_US.UTF-8";
        LC_ALL = "en_US.UTF-8";
      };
      # terminal = {
      #   shell = "${pkgs.nushell}/bin/nu";
      # };
      window = {
        padding = {
          x = 2;
          y = 2;
        };
        dynamic_padding = true;
        decorations = "full";
        opacity = 0.8;
        blur = true;
      };

      scrolling = {
        history = 10000;
        multiplier = 3;
      };

      font = {
        normal = {
          family = "JetBrainsMono Nerd Font";
          style = "Regular";
        };
        bold = {
          family = "JetBrainsMono Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "JetBrainsMono Nerd Font";
          style = "Italic";
        };
        bold_italic = {
          family = "JetBrainsMono Nerd Font";
          style = "Bold Italic";
        };
        size = 11.25;
        offset = {
          x = 0;
          y = 0;
        };
        glyph_offset = {
          x = 0;
          y = 0;
        };
        builtin_box_drawing = true;
      };
      colors = import ./colorscheme/catppuccin.nix;
    };
  };
}
