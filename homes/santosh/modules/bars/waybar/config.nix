{
  lib,
  osConfig,
  ...
}:
let
  inherit (lib) optionalString;
  sys = osConfig.hardware;
in
{
  mainBar = {
    layers = "top";
    position = "top";
    height = 24;
    spacing = 2;
    margin-bottom = 0;
    margin-top = 4;
    margin-left = 8;
    margin-right = 8;

    modules-left = [
      # "hyprland/workspaces"
      # "hyprland/window"
      "niri/workspaces"
      "niri/window"
      "cava"
    ];

    modules-center = [
      "clock"
      # "privacy"
    ];

    modules-right = [
      "group/tray-expander"
      "network"
      "gamemode"
      (optionalString (sys.bluetooth.enable or false) "bluetooth")
      "backlight"
      "pulseaudio"
      "pulseaudio#microphone"
      "battery"
      "custom/notification"
    ];

    "cava" = {
      # "cava_config" = "$XDG_CONFIG_HOME/cava/cava.conf";
      framerate = 60;
      autosens = 1;
      # sensitivity = 100;
      bars = 30;
      lower_cutoff_freq = 30;
      higher_cutoff_freq = 12000;
      method = "pulse";
      source = "auto";
      stereo = true;
      reverse = false;
      bar_delimiter = 0;
      monstercat = true;
      waves = true;
      noise_reduction = 0.85;
      input_delay = 2;
      hide_on_silence = true;
      sleep_timer = 5;
      format-icons = [
        "▁"
        "▂"
        "▃"
        "▄"
        "▅"
        "▆"
        "▇"
        "█"
      ];
      actions = {
        on-click-right = "mode";
      };
    };

    "hyprland/workspaces" = {
      disable-scroll = true;
      all-outputs = true;
      format = "{icon}";
      format-icons = {
        "1" = " ";
        "2" = "󰈹 ";
        "3" = "3";
        "4" = "4";
        "5" = "5";
        "6" = "6";
        "7" = "7";
        "8" = "8";
        "9" = "9";
        "10" = "";
      };
      persistent-workspaces = {
        "*" = 5;
      };
    };

    "niri/workspaces" = {
      all-outputs = true;
      format = "{icon}";
      current-only = false;
      format-icons = {
        "1" = " ";
        "2" = "󰈹 ";
        "3" = "3";
        "4" = "4";
        "5" = "5";
        "6" = "6";
        "7" = "7";
        "8" = "8";
        "9" = "9";
        "10" = "";
      };
    };

    # Window title
    "hyprland/window" = {
      format = "{}";
      max-length = 30;
      separate-outputs = true;
    };

    "niri/window" = {
      format = "{}";
      max-length = 30;
      separate-outputs = true;
    };

    clock = {
      timezone = "Asia/Kathmandu";
      format = "{:%I:%M %p}";
      format-alt = "{:%A, %B %d, %Y}";
      tooltip-format = ''
        <big>{:%Y %B}</big>
        <tt><small>{calendar}</small></tt>'';
      calendar = {
        mode = "year";
        mode-mon-col = 3;
        weeks-pos = "right";
        on-scroll = 1;
        on-click-right = "mode";
        format = {
          months = "<span color='#ffead3'><b>{}</b></span>";
          days = "<span color='#ecc6d9'>{}</span>";
          weeks = "<span color='#99ffdd'><b>W{}</b></span>";
          weekdays = "<span color='#ffcc66'><b>{}</b></span>";
          today = "<span color='#ff6699'><b><u>{}</u></b></span>";
        };
      };
      actions = {
        on-click-right = "mode";
        on-click-forward = "tz_up";
        on-click-backward = "tz_down";
        on-scroll-up = "shift_up";
        on-scroll-down = "shift_down";
      };
    };

    privacy = {
      icon-spacing = 10;
      icon-size = 13;
      transition-duration = 300;
      modules = [
        {
          type = "screenshare";
          tooltip = true;
          tooltip-icon-size = 20;
        }
        {
          type = "audio-out";
          tooltip = true;
          tooltip-icon-size = 20;
        }
        {
          type = "audio-in";
          tooltip = true;
          tooltip-icon-size = 20;
        }
      ];
    };

    network = {
      format-wifi = "  {signalStrength}%  ↓↑ {bandwidthTotalBytes}";
      format-ethernet = "󰈀  {signalStrength}%";
      format-disconnected = "󰤮 ";
      tooltip-format = "{ifname} via {gwaddr}";
      tooltip-format-wifi = ''
        {essid} ({signalStrength}%) 󰤨
        ↑{bandwidthUpBytes} ↓{bandwidthDownBytes}
        {frequency}MHz'';
      tooltip-format-ethernet = ''
        {ifname} 󰈀
        IP: {ipaddr}'';
      tooltip-format-disconnected = "Disconnected";
      min-length = 20;
      max-length = 20;
      on-click = "nm-connection-editor";
      interval = 5;
    };

    gamemode = {
      format = "{glyph}";
      format-alt = "{glyph} {count}";
      glyph = " ";
      hide-not-running = false;
      use-icon = true;
      icon-name = "input-gaming-symbolic";
      icon-spacing = 4;
      icon-size = 20;
      tooltip = true;
      tooltip-format = "Games running: {count}";
    };

    "bluetooth" = {
      format-off = "󰂲";
      format-on = "";
      format-disabled = "󰂲";
      format-connected = " {device_alias}";
      format-connected-battery = " {device_alias} {device_battery_percentage}%";
      tooltip-format = ''
        {controller_alias}	{controller_address}

        {num_connections} connected'';
      tooltip-format-connected = ''
        {controller_alias}	{controller_address}

        {num_connections} connected

        {device_enumerate}'';
      tooltip-format-enumerate-connected = "{device_alias}	{device_address}";
      tooltip-format-enumerate-connected-battery = "{device_alias}	{device_address}	{device_battery_percentage}%";
      on-click = "blueman-manager";
    };

    # Custom notification module
    "custom/notification" = {
      tooltip = false;
      format = "";
      format-icons = {
        notification = "<span foreground='red'><sup></sup></span>";
        none = "";
        dnd-notification = "<span foreground='red'><sup></sup></span>";
        dnd-none = "";
        inhibited-notification = "<span foreground='red'><sup></sup></span>";
        inhibited-none = "";
        dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
        dnd-inhibited-none = "";
      };
      return-type = "json";
      exec-if = "which swaync-client";
      exec = "swaync-client -swb";
      on-click = "swaync-client -t -sw";
      on-click-right = "swaync-client -d -sw";
      escape = true;
    };

    # Battery - Added brightness control on scroll
    battery = {
      states = {
        good = 95;
        warning = 30;
        critical = 20;
      };
      format = "{icon} {capacity}%";
      format-charging = "󱐋{capacity}%";
      format-plugged = "󱟢{capacity}%";
      format-alt = "{icon} {time}";
      format-icons = [
        "󰁺"
        "󰁻"
        "󰁼"
        "󰁽"
        "󰁾"
        "󰁿"
        "󰂀"
        "󰂁"
        "󰂂"
        "󰁹"
      ];
      # on-scroll-up = "brightnessctl set +5%";
      # on-scroll-down = "brightnessctl set 5%-";
      tooltip-format = ''
        Battery: {capacity}%
        {timeTo}
        Power: {power}W'';
      interval = 60;
      max-length = 25;
    };

    # Audio - Added proper sound icons
    pulseaudio = {
      format = "{icon} {volume}%";
      format-muted = "󰝟 {volume}%";
      format-icons = {
        headphone = "󰋋";
        hands-free = "󰏴";
        headset = "󰋎";
        phone = "󰏲";
        portable = "󰦧";
        car = "󰄋";
        default = [
          "󰕿"
          "󰖀"
          "󰕾"
        ];
      };
      on-click = "pavucontrol";
      on-click-right = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
      on-scroll-up = "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+";
      on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
      tooltip-format = ''
        Volume: {volume}%
        Device: {desc}
        Scroll to adjust volume'';
      max-length = 20;
      smooth-scrolling-threshold = 1.0;
    };

    "pulseaudio#microphone" = {
      format = "{format_source}";
      format-source = "󰍬 {volume}%";
      format-source-muted = "󰍭";
      on-click = "pavucontrol --tab=4";
      on-click-right = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle ";
      on-scroll-up = "wpctl set-volume -l 1 @DEFAULT_SOURCE@ .05+";
      on-scroll-down = "wpctl set-volume @DEFAULT_SOURCE@ .05-";
      scroll-step = 5;
      smooth-scrolling-threshold = 1;
      tooltip = true;
      tooltip-format = ''
        Microphone: {volume}%{format_source}
        Scroll to adjust microphone volume'';
    };

    backlight = {
      device = "intel_backlight";
      format = " {percent}%";
      on-scroll-up = "brightnessctl s 5%+";
      on-scroll-down = "brightnessctl s 5%-";
      smooth-scrolling-threshold = 1.0;
      tooltip-format = ''
        Brightness: {percent}%
        Scroll to adjust brightness'';
    };

    # System tray
    "group/tray-expander" = {
      orientation = "inherit";
      drawer = {
        transition-duration = 600;
        children-class = "tray-group-item";
      };
      modules = [
        "custom/expand-icon"
        "tray"
      ];
    };

    "custom/expand-icon" = {
      format = "";
      tooltip = false;
    };

    tray = {
      icon-size = 14;
      spacing = 8;
      expand = false;
      # icons = {
      #   "nm-applet" = "${config.home.homeDirectory}/nixos/homes/santosh/assets/signal.png";
      #   "discord" = "${config.home.homeDirectory}/nixos/homes/santosh/assets/discord.png";
      # };
    };
  };
}
