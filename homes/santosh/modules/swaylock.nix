{ config, ... }:
let
  currentWallpaper = "${config.home.homeDirectory}/.current_wallpaper";
in
{
  programs.swaylock = {
    enable = true;
    settings = {
      color = "000000";
      font-size = 15;
      indicator-idle-visible = false;
      image = currentWallpaper;
      scalling = "fill";
      indicator-radius = 100;
      line-color = "ffffff";
      show-failed-attempts = true;
    };
  };
}
