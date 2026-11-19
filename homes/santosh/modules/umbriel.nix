{
  programs.umbriel = {
    enable = true;
    settings = {
      general = {
        mod_key = "Alt";
        show_cheatsheet = false;
        focus_on_activate = true;
        xwayland = true;
      };

      events = {
        lid_close = "noctalia msg session lock-and-suspend";
        lid_open = "notify-send -t 10000 'Awake!' 'Good to see you again.'";
      };

      input = {
        keyboard = {
          layout = "us";
          repeat_rate = 35;
          repeat_delay = 200;
        };

        touchpad = {
          tap = true;
          natural_scroll = true;
          disable_while_typing = true;
          accel_profile = "adaptive";
          sensitivity = 0.4;
        };

        mouse = {
          sensitivity = 0.2;
        };

        focus = {
          follows_mouse = "sloppy";
          follows_mouse_max_scroll = 0.0;
        };

        cursor = {
          hide_when_typing = true;
          hide_timeout_ms = 1000;
        };
      };

      output.eDP-1 = {
        mode = "1920x1080@60.001";
        scale = 1;
        transform = "normal";
        position = [
          0
          0
        ];
      };

      layout = {
        mode = "scrolling";
        gap = 2;
        extent_presets = [
          0.33333
          0.5
          0.66667
        ]; # niri: preset-column-widths
        struts = {
          left = 0;
          right = 1;
        };
        scrolling = {
          center_underfull_strip = true; # niri: always-center-single-column true
          center_focused = "never"; # niri: center-focused-column "never"
        };
      };

      appearance = {
        prefer_no_csd = true; # niri: prefer-no-csd
        border_width = 1; # niri: focus-ring width 1 (niri border is off)
        outer_border_width = 0;
        corner_radius = 0; # niri: geometry-corner-radius 0
        shadow = {
          enabled = true;
          softness = 30;
          offset_x = 0;
          offset_y = 5;
        };
        blur.enabled = true;
        title_bar.mode = "off";
      };

      colors = {
        border = {
          focused = "#404040";
          unfocused = "#202020";
        };
        shadow = "#50505066";
      };

      overview = {
        zoom = 0.4;
        workspace_wallpaper = true;
      };

      animation = {
        windows_move.curve = "spring:1,800";
        workspaces.curve = "spring:1,1000";
        overview.curve = "spring:0.85,800";
        layers = {
          enabled = true;
          curve = "spring:0.65,923";
        };
      };

      # niri modules/binds.kdl translated to Umbriel actions.
      keybinds = {
        # Monitor transforms (runtime override + reload, niri used `niri msg output ...`).
        "Mod+Slash" =
          "spawn umbriel config set 'output.\"eDP-1\".transform' \"'90'\" && umbriel msg config-reload";
        "Mod+Shift+Slash" =
          "spawn umbriel config set 'output.\"eDP-1\".transform' \"'normal'\" && umbriel msg config-reload";

        # Apps and shell.
        "Mod+Return" = {
          action = "spawn foot";
          repeat = false;
        };
        "Mod+Space" = {
          action = "spawn noctalia msg panel-toggle launcher";
          repeat = false;
        };
        "Super+L" = {
          action = "spawn noctalia msg session lock";
          repeat = false;
        };
        "Mod+B" = {
          action = "spawn zen-beta";
          repeat = false;
        };

        "XF86AudioRaiseVolume" = {
          action = "spawn noctalia msg volume-up";
          allow_when_locked = true;
        };
        "XF86AudioLowerVolume" = {
          action = "spawn noctalia msg volume-down";
          allow_when_locked = true;
        };
        "XF86AudioMute" = {
          action = "spawn noctalia msg volume-mute";
          allow_when_locked = true;
          repeat = false;
        };
        "XF86MonBrightnessUp" = {
          action = "spawn noctalia msg brightness-up";
          allow_when_locked = true;
        };
        "XF86MonBrightnessDown" = {
          action = "spawn noctalia msg brightness-down";
          allow_when_locked = true;
        };
        "XF86AudioMicMute" = {
          action = "spawn wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
          allow_when_locked = true;
          repeat = false;
        };
        "XF86AudioPlay" = {
          action = "spawn playerctl play-pause";
          allow_when_locked = true;
          repeat = false;
        };
        "XF86AudioStop" = {
          action = "spawn playerctl stop";
          allow_when_locked = true;
          repeat = false;
        };
        "XF86AudioPrev" = {
          action = "spawn playerctl previous";
          allow_when_locked = true;
        };
        "XF86AudioNext" = {
          action = "spawn playerctl next";
          allow_when_locked = true;
        };
        "Super+Alt+S" = {
          action = "spawn pkill orca || exec orca";
          allow_when_locked = true;
          repeat = false;
        };

        # Windows and columns.
        "Mod+E" = {
          action = "overview-toggle";
          repeat = false;
        };
        "Mod+Q" = {
          action = "window-close";
          repeat = false;
        };
        "Mod+Left" = "window-focus-left";
        "Mod+Down" = "window-focus-down";
        "Mod+Up" = "window-focus-up";
        "Mod+Right" = "window-focus-right";
        "Mod+H" = "window-focus-left";
        "Mod+L" = "window-focus-right";
        "Mod+Ctrl+Left" = "column-move-left";
        "Mod+Ctrl+Down" = "window-move-down";
        "Mod+Ctrl+Up" = "window-move-up";
        "Mod+Ctrl+Right" = "column-move-right";
        "Mod+Ctrl+H" = "column-move-left";
        "Mod+Ctrl+J" = "window-move-down";
        "Mod+Ctrl+K" = "window-move-up";
        "Mod+Ctrl+L" = "column-move-right";
        "Mod+Home" = "column-focus-first";
        "Mod+End" = "column-focus-last";
        "Mod+Ctrl+Home" = "column-move-to-first";
        "Mod+Ctrl+End" = "column-move-to-last";

        # Outputs.
        "Mod+Shift+Left" = "output-focus-left";
        "Mod+Shift+Down" = "output-focus-down";
        "Mod+Shift+Up" = "output-focus-up";
        "Mod+Shift+Right" = "output-focus-right";
        "Mod+Shift+H" = "output-focus-left";
        "Mod+Shift+J" = "output-focus-down";
        "Mod+Shift+K" = "output-focus-up";
        "Mod+Shift+L" = "output-focus-right";
        "Mod+Shift+Ctrl+Left" = "column-move-to-output-left";
        "Mod+Shift+Ctrl+Down" = "column-move-to-output-down";
        "Mod+Shift+Ctrl+Up" = "column-move-to-output-up";
        "Mod+Shift+Ctrl+Right" = "column-move-to-output-right";
        "Mod+Shift+Ctrl+H" = "column-move-to-output-left";
        "Mod+Shift+Ctrl+J" = "column-move-to-output-down";
        "Mod+Shift+Ctrl+K" = "column-move-to-output-up";
        "Mod+Shift+Ctrl+L" = "column-move-to-output-right";

        # Workspaces.
        "Mod+Page_Down" = "workspace-next";
        "Mod+Page_Up" = "workspace-previous";
        "Mod+J" = "workspace-next";
        "Mod+K" = "workspace-previous";
        "Mod+Ctrl+Page_Down" = "column-move-to-workspace-next";
        "Mod+Ctrl+Page_Up" = "column-move-to-workspace-previous";
        "Mod+Ctrl+U" = "column-move-to-workspace-next";
        "Mod+Ctrl+I" = "column-move-to-workspace-previous";
        "Mod+Shift+Page_Down" = "workspace-move-down";
        "Mod+Shift+Page_Up" = "workspace-move-up";
        "Mod+Shift+U" = "workspace-move-down";
        "Mod+Shift+I" = "workspace-move-up";
        "Mod+1" = "workspace-switch 1";
        "Mod+2" = "workspace-switch 2";
        "Mod+3" = "workspace-switch 3";
        "Mod+4" = "workspace-switch 4";
        "Mod+5" = "workspace-switch 5";
        "Mod+6" = "workspace-switch 6";
        "Mod+7" = "workspace-switch 7";
        "Mod+8" = "workspace-switch 8";
        "Mod+9" = "workspace-switch 9";
        "Mod+Shift+1" = "column-move-to-workspace 1";
        "Mod+Shift+2" = "column-move-to-workspace 2";
        "Mod+Shift+3" = "column-move-to-workspace 3";
        "Mod+Shift+4" = "column-move-to-workspace 4";
        "Mod+Shift+5" = "column-move-to-workspace 5";
        "Mod+Shift+6" = "column-move-to-workspace 6";
        "Mod+Shift+7" = "column-move-to-workspace 7";
        "Mod+Shift+8" = "column-move-to-workspace 8";
        "Mod+Shift+9" = "column-move-to-workspace 9";

        # Wheel navigation (niri cooldown-ms=150 for workspace steps).
        "Mod+WheelDown" = {
          action = "workspace-next";
          cooldown_ms = 150;
        };
        "Mod+WheelUp" = {
          action = "workspace-previous";
          cooldown_ms = 150;
        };
        "Mod+Ctrl+WheelDown" = {
          action = "column-move-to-workspace-next";
          cooldown_ms = 150;
        };
        "Mod+Ctrl+WheelUp" = {
          action = "column-move-to-workspace-previous";
          cooldown_ms = 150;
        };
        "Mod+WheelRight" = "window-focus-right";
        "Mod+WheelLeft" = "window-focus-left";
        "Mod+Ctrl+WheelRight" = "column-move-right";
        "Mod+Ctrl+WheelLeft" = "column-move-left";
        "Mod+Shift+WheelDown" = "window-focus-right";
        "Mod+Shift+WheelUp" = "window-focus-left";
        "Mod+Ctrl+Shift+WheelDown" = "column-move-right";
        "Mod+Ctrl+Shift+WheelUp" = "column-move-left";

        # Column/window arrangements.
        "Mod+Comma" = "window-consume-or-expel-left";
        "Mod+Period" = "window-consume-or-expel-right";
        "Mod+R" = "window-cycle-primary-extent";
        "Mod+Shift+R" = "window-cycle-secondary-extent";
        "Mod+Ctrl+R" = "window-set-secondary-extent 1.0"; # niri: reset-window-height
        "Mod+F" = "window-toggle-maximize";
        "Mod+Shift+F" = "window-toggle-fullscreen";
        "Mod+Ctrl+F" = "window-set-primary-extent 1.0"; # niri: expand-column-to-available-width
        "Mod+C" = "column-center";
        "Mod+Minus" = "window-modify-primary-extent -0.1";
        "Mod+Equal" = "window-modify-primary-extent +0.1";
        "Mod+Shift+Minus" = "window-modify-secondary-extent -0.1";
        "Mod+Shift+Equal" = "window-modify-secondary-extent +0.1";
        "Mod+V" = "window-toggle-floating";
        "Mod+Shift+V" = "window-focus-switch-floating";

        # Screenshots (routed through Noctalia like the rest of the shell).
        "Shift+Print" = {
          action = "spawn noctalia msg screenshot-region";
          repeat = false;
        };
        "Print" = {
          action = "spawn noctalia msg screenshot-fullscreen";
          repeat = false;
        };
        "Mod+Print" = {
          action = "spawn noctalia msg screenshot-window";
          repeat = false;
        };

        # System.
        "Mod+Escape" = {
          action = "shortcuts-inhibit-toggle";
          allow_when_inhibited = true;
          repeat = false;
        };
        "Mod+Shift+E" = "session-quit";
        "Ctrl+Alt+Delete" = "session-quit";
        "Mod+Shift+P" = "dpms-off";
        "Mod+P" = {
          action = "spawn wl-mirror eDP-1";
          repeat = false;
        };
      };

      window_rule = [
        {
          blur = true;
        }
        {
          match.app_id = "discord";
          block_capture = true;
        }
        {
          match.is_focused = true;
          opacity = 1.0;
        }
        {
          match.is_focused = false;
          opacity = 0.9;
        }
        {
          match = {
            app_id = "firefox$";
            title = "^Picture-in-Picture$";
          };
          default_floating = true;
        }
        {
          match.app_id = "dev.noctalia.Noctalia";
          default_floating = true;
          default_floating_size_px = {
            width = 1080;
            height = 920;
          };
        }
      ];
    };
  };
}
