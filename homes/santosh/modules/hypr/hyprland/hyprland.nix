{ pkgs, ... }:
{
  imports = [
    ./modules/monitors.nix
    ./modules/decoration.nix
    ./modules/animations.nix
    ./modules/autostart.nix
    ./modules/keymaps.nix
    ./modules/inputs.nix
  ];
  wayland.windowManager.hyprland = {
    # If you are enabling hyprland then you want the following thing to be done
    # (optional) enable hyprilde and change the idle timeout of logind to avoid
    # add the hyprland modules in the waybar config
    enable = true;

    package = pkgs.hyprland;

    plugins = [
      pkgs.hyprlandPlugins.hyprscrolling
    ];

    # withUWSM = true;
    # xwayland.enable = true;
    # systemd.enable = true;
    settings = {
      # #######################################################################################
      # HYPRLAND CONFIGURATION
      # This configuration is based on the example from the Hyprland wiki
      # https://wiki.hyprland.org/Configuring/
      #
      # Please note not all available settings / options are set here.
      # For a full list, see the wiki
      # #######################################################################################

      ###################
      ### MY PROGRAMS ###
      ###################

      # See https://wiki.hyprland.org/Configuring/Keywords/
      # Set programs that you use
      "$terminal" = "kitty";
      # "$terminal" = "alacritty";  # Alternative terminal
      "$fileManager" = "thunar";
      # "$menu" = "wofi --show drun";  # Alternative launcher
      "$menu" = "rofi -i -show drun";
      # "$browser" = "zen-browser";  # Alternative browser
      "$browser" = "firefox";

      #############################
      ### ENVIRONMENT VARIABLES ###
      #############################

      # See https://wiki.hyprland.org/Configuring/Environment-variables/
      # Uncomment and modify as needed:
      # env = [
      #   "XCURSOR_SIZE,20"
      #   "XCURSOR_THEME,Night Diamond(Red)"
      #   "HYPRCURSOR_SIZE,20"
      #   "HYPRCURSOR_THEME,rose-pine-hyprcursor"
      # ];

      #######################
      ####### PLUGINS  ######
      #######################
      #See https://wiki.hypr.land/Plugins/Using-Plugins/
      plugin = {
        # See https://github.com/hyprwm/hyprland-plugins/tree/main/hyprscrolling
        hyprscrolling = {
          fullscreen_on_one_column = true;
          column_width = 0.5;
          focus_fit_method = 1;
          follow_focus = true;
        };
      };

      #####################
      ### LOOK AND FEEL ###
      #####################

      # Refer to https://wiki.hyprland.org/Configuring/Variables/
      # https://wiki.hyprland.org/Configuring/Variables/#general
      general = {
        gaps_in = 5;
        gaps_out = 8;
        border_size = 1;

        # https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
        # rose-pine
        # "col.active_border" = "rgba(33ccffee) rgba(ff0088ee) 45deg";
        # "col.inactive_border" = "rgba(222222aa)";

        # vague
        "col.active_border" = "rgba(64,64,64,1) rgba(96,96,96,1) 45deg";
        "col.inactive_border" = "rgba(32,32,32,1)";

        # Set to true enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false;

        # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
        allow_tearing = false;

        # layout = "dwindle";
        layout = "scrolling";
      };

      # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
      dwindle = {
        pseudotile = true; # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = true; # You probably want this
      };

      # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
      master = {
        new_status = "master";
      };

      # https://wiki.hyprland.org/Configuring/Variables/#misc
      misc = {
        force_default_wallpaper = -1; # Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo = false; # If true disables the random hyprland logo / anime girl background. :(
      };

      ##############################
      ### WINDOWS AND WORKSPACES ###
      ##############################

      # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
      # See https://wiki.hyprland.org/Configuring/Workspace-Rules/ for workspace rules

      # Example windowrule v1
      # windowrulev = [
      # "float,class:^(kitty)$"
      # ];

      layerrule = [
        "animation slide,rofi"
      ];

      windowrulev2 = [
        # Example window rules - v2 uncomment and modify as needed:
        # "float,class:^(kitty)$,title:^(kitty)$"

        # "Smart gaps" / "No gaps when only" window rules - uncomment to enable:
        # "bordersize 0,floating:0,onworkspace:w[tv1]"
        # "rounding 0,floating:0,onworkspace:w[tv1]"
        # "bordersize 0,floating:0,onworkspace:f[1]"
        # "rounding 0,floating:0,onworkspace:f[1]"

        # Ignore maximize requests from apps. You'll probably like this.
        "suppressevent maximize,class:.*"

        # Fix some dragging issues with XWayland
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      ];
    };
  };
}
