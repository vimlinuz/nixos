{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "niri msg action power-on-monitors";

        ignore_dbus_inhibit = false;
        ignore_systemd_inhibit = false;
        ignore_wayland_inhibit = false;
      };

      listener = [
        {
          timeout = 180;
          on-timeout = "notify-send -t 3000 'Zzz...' 'You seem away, dimming the screen.'";
        }
        {
          timeout = 185;
          on-timeout = "niri msg action power-off-monitors";
          on-resume = "niri msg action power-on-monitors && notify-send -t 2000 'Awake!' 'Good to see you again.'";
        }
        {
          timeout = 300;
          on-timeout = "loginctl lock-session";
        }
        # {
        #   timeout = 900;
        #   on-timeout = "systemctl suspend-then-hibernate";
        # }
        {
          timeout = 1200;
          on-timeout = "systemctl hibernate";
        }
      ];
    };
  };
}

# {
#   services.hypridle = {
#     enable = false;
#     settings = {
#       general = {
#         lock_cmd = "pidof hyprlock || hyprlock";
#         before_sleep_cmd = "hyprlock";
#         after_sleep_cmd = "hyprctl dispatch dpms on";
#         ignore_dbus_inhibit = false;
#         ignore_systemd_inhibit = false;
#       };
#
#       listener = [
#
#         # Below tow blocks are for hyprland
#         # {
#         #   timeout = 180;
#         #   on-timeout = "notify-send -t 4500 'Zzz!'";
#         # }
#         # {
#         #   timeout = 185;
#         #   on-timeout = "hyprctl dispatch dpms off";
#         #   on-resume = "hyprctl dispatch dpms on && notify-send -t 2000 'Awake!'";
#         # }
#       ];
#     };
#   };
# }
