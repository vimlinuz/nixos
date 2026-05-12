{ pkgs, ... }:
{
  programs.foot = {
    enable = true;
    server.enable = false;

    settings = {
      main = {
        term = "xterm-256color";
        font = "JetBrainsMono Nerd Font:size=11.25";
        dpi-aware = "yes";
        shell = "${pkgs.nushell}/bin/nu";
      };

      cursor = {
        style = "beam";
        blink = "no";
      };

      bell = {
        urgent = "no";
        notify = "no";
        visual = "no";
      };
      colors-dark = {
        background = "000000";
        alpha = 0.8;
      };

      mouse = {
        hide-when-typing = "yes";
      };
    };
  };
}
