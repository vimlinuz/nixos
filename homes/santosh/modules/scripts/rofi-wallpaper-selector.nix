{
  pkgs,
  config,
  inputs,
  ...
}:
let
  currentDesktop = builtins.getEnv "XDG_CURRENT_DESKTOP";
  theme = "${config.home.homeDirectory}/.config/rofi/themes/wallpaper-selector.rasi";
  WALLPAPER_DIR = "${inputs.wall-archive}/wallpapers";

  rofi-wallpaper-selector = pkgs.writeShellScriptBin "rofi-wallpaper-selector" ''
    #!/usr/bin/env bash

    if [${currentDesktop} == "hyprland"]; then
    HYPRLAND=true
    else
    HYPRLAND=false
    fi

    if $HYPRLAND && ! pgrep hyprpaper >/dev/null; then
    hyprpaper &
    sleep 1
    fi

    WALLPAPER=$( for a in "${WALLPAPER_DIR}"/*; do
    # echo -en "$a\0icon\x1f$a\n"
    echo -en "$(basename "$a")\0icon\x1f$a\n"
    done | rofi -i -dmenu -p "wallpaper selector" -theme ${theme}
    )

    if [ -z "$WALLPAPER" ]; then
    # notify-send "Wallpaper-selector" "No wallpaper selected, exiting..."
    exit 1
    fi

    NEW_WALLPAPER="${WALLPAPER_DIR}"/$WALLPAPER

    if $HYPRLAND; then
    hyprctl hyprpaper reload ,"$NEW_WALLPAPER"
    else
    pkill swaybg
    swaybg -m fill -o*  -i "$NEW_WALLPAPER" &
    fi

    # notify-send "Wallpaper-selector" "Wallpaper changed to $WALLPAPER"
    ln -sf "$NEW_WALLPAPER" ${config.home.homeDirectory}/.current_wallpaper
  '';
in
{
  home.packages = [ rofi-wallpaper-selector ];
}
