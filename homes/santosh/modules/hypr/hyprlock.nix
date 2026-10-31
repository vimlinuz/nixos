{ config, ... }:
let
  currentWallpaper = "${config.home.homeDirectory}/.current_wallpaper";
in
{
  programs.hyprlock = {
    enable = true;

    settings = {
      background = {
        path = currentWallpaper;
        blur_passes = 2;
        contrast = 0.8916;
        brightness = 0.35;
        vibrancy = 0.1696;
        vibrancy_darkness = 0.0;
      };

      "input-field" = [
        {
          monitor = "eDP-1";
          size = "320, 60";
          outline_thickness = 2;
          dots_size = 0.2;
          dots_spacing = 0.2;
          dots_center = true;
          outer_color = "rgba(18, 18, 18, 18)";
          inner_color = "rgba(18,18,18,0.5)";
          font_color = "rgba(181, 181, 181,1)";
          fade_on_empty = true;
          placeholder_text = "";
          fail_text = "󰞇";
          hide_input = false;
          position = "0, -310";
          halign = "center";
          valign = "center";
        }
      ];

      label = [
        {
          text = ''cmd[update:1000] echo -e "$(date +"%I")"'';
          color = "rgba(255, 255, 255, 1)";
          shadow_size = 3;
          shadow_color = "rgb(0,0,0)";
          shadow_boost = 1.2;
          font_size = 180;
          font_family = "Anton";
          position = "0, -150";
          halign = "center";
          valign = "top";
        }
        {
          text = ''cmd[update:1000] echo -e "$(date +"%M")"'';
          color = "rgba(255, 255, 255, 1)";
          font_size = 180;
          font_family = "Anton";
          position = "0, -400";
          halign = "center";
          valign = "top";
        }
        {
          monitor = "eDP-1";
          text = ''cmd[update:1000] echo -e "$(date +"%d, %b %A")"'';
          color = "rgba(255, 255, 255, 1)";
          font_size = 13;
          font_family = "Anton";
          position = "0, -550";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "eDP-1";
          text = ''cmd[update:1000] echo -e "$(date +"%d, %b %A")"'';
          color = "rgba(255, 255, 255, 1)";
          font_size = 20;
          font_family = "Anton";
          position = "10, -480";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
