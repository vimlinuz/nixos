{
  pkgs,
  lib,
  osConfig,
  ...
}:
let
  waybar_config = import ./config.nix { inherit pkgs lib osConfig; };
  waybar_style = import ./style.nix;
in
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = waybar_config;
    style = waybar_style;
  };
}
