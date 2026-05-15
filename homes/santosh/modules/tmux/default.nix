{ pkgs, ... }:
let
  colors = import ./modules/colors.nix;
in
{
  programs.tmux = {
    enable = true;
    mouse = true;
    prefix = "C-a";
    # shell = "${pkgs.fish}/bin/fish";
    # shell = "${pkgs.nushell}/bin/nu";
    # terminal = "screen-256color";
    terminal = "xterm-256color";
    escapeTime = 0;
    baseIndex = 1;
    plugins = import ./modules/plugins.nix { inherit pkgs colors; };

    extraConfig = import ./modules/config.nix { inherit colors; };
  };
}
