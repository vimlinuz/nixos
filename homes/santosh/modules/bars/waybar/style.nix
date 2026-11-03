''
  * {
      border: none;
      border-radius: 0;
      font-family: "JetBrains Mono Nerd Font", "Fira Code Nerd Font", monospace;
      font-size: 11px;
      min-height: 0;
  }

  window#waybar {
      background: rgba(0, 0, 0, 0.6);
      /* more transparent */
      /* background: rgba(0, 0, 0, 0.3); */
      color: #b8b5c7;
      transition-property: background-color;
      transition-duration: .5s;
      border-radius: 8px;
      margin: 0;
      padding: 0;
  }

  window#waybar.hidden {
      opacity: 0.2;
  }

  /* Workspaces */
  #workspaces {
      background: rgba(82, 79, 103, 0.2);
      border-radius: 6px;
      margin: 2px;
      padding: 0 3px;
  }

  #workspaces button {
      padding: 0 6px;
      background: transparent;
      color: #b8b5c7;
      border-radius: 4px;
      transition: all 0.3s ease;
      font-weight: bold;
  }

  #workspaces button:hover {
      background: rgba(82, 79, 103, 0.3);
      color: #d4d1e0;
  }

  #workspaces button.active {
      background: rgba(82, 79, 103, 0.5);
      color: #ffffff;
      font-weight: bold;
  }

  #workspaces button.urgent {
      background: rgba(255, 0, 0, 0.3);
      color: #ff8a80;
  }

  /* Window title */
  #window {
      background: rgba(82, 79, 103, 0.2);
      border-radius: 6px;
      margin: 2px;
      padding: 0 10px;
      color: #b8b5c7;
      font-weight: normal;
  }

  /* Clock */
  #clock {
      background: rgba(82, 79, 103, 0.2);
      border-radius: 6px;
      margin: 2px;
      padding: 0 10px;
      color: #ffffff;
      font-weight: bold;
  }

  #clock:hover {
      background: rgba(82, 79, 103, 0.3);
  }

  #cava {
      background: rgba(82, 79, 103, 0.2);
      border-radius: 6px;
      margin: 2px;
      padding: 0 10px;
      color: #b8b5c7;
      transition: all 0.3s ease;
  }

  #cava:hover {
      background: rgba(82, 79, 103, 0.3);
  }

  #cava.silent {
      background: rgba(82, 79, 103, 0.15);
      color: #6e6a86;
  }

  /* Network */
  #network {
      background: rgba(82, 79, 103, 0.2);
      border-radius: 6px;
      margin: 2px;
      padding: 0 10px;
      color: #b8b5c7;
      font-size: 13px;
      /* Slightly larger for better icon visibility */
      transition: all 0.3s ease;
  }

  #network:hover {
      background: rgba(82, 79, 103, 0.3);
  }

  #network.disconnected {
      background: rgba(255, 0, 0, 0.2);
      color: #ff8a80;
  }

  #gamemode {
      background: rgba(82, 79, 103, 0.2);
      border-radius: 6px;
      margin: 2px;
      padding: 0 10px;
      color: #b8b5c7;
      font-size: 13px;
      /* Slightly larger for better icon visibility */
      transition: all 0.3s ease;
  }

  #gamemode:hover {
      background: rgba(82, 79, 103, 0.3);
  }

  #gamemode.running {
      background: rgba(0, 255, 0, 0.2);
      color: #66ff66;
  }

  #privacy {
      background: rgba(82, 79, 103, 0.2);
      border-radius: 6px;
      margin: 2px;
      padding: 0 8px;
  }

  #bluetooth {
      background: rgba(82, 79, 103, 0.2);
      border-radius: 6px;
      margin: 2px;
      padding: 0 10px;
      color: #b8b5c7;
      font-size: 13px;
      /* Slightly larger for better icon visibility */
      transition: all 0.3s ease;
  }

  #bluetooth:hover {
      background: rgba(82, 79, 103, 0.3);
  }

  #bluetooth.disabled {
      background: rgba(255, 0, 0, 0.2);
      color: #ff8a80;
  }

  /* Custom notification */
  #custom-notification {
      background: rgba(82, 79, 103, 0.2);
      border-radius: 6px;
      margin: 2px;
      padding: 0 10px;
      color: #b8b5c7;
      font-size: 13px;
  }

  #custom-notification:hover {
      background: rgba(82, 79, 103, 0.3);
  }

  /* Battery */
  #battery {
      background: rgba(82, 79, 103, 0.2);
      border-radius: 6px;
      margin: 2px;
      padding: 0 10px;
      color: #b8b5c7;
      font-size: 13px;
      /* Slightly larger for better icon visibility */
      transition: all 0.3s ease;
  }

  #battery:hover {
      background: rgba(82, 79, 103, 0.3);
      transition: all 0.3s ease;
  }

  #battery.charging {
      background: rgba(0, 255, 0, 0.2);
      color: #66ff66;
  }

  #battery.warning:not(.charging) {
      background: rgba(255, 165, 0, 0.2);
      color: #ffcc66;
  }

  #battery.critical:not(.charging) {
      background: rgba(255, 0, 0, 0.2);
      color: #ff6666;
      animation: blink 0.5s linear infinite alternate;
  }

  @keyframes blink {
      to {
          background: rgba(255, 0, 0, 0.4);
      }
  }

  /* Audio */
  #pulseaudio {
      background: rgba(82, 79, 103, 0.2);
      border-radius: 6px;
      margin: 2px;
      padding: 0 10px;
      color: #b8b5c7;
      font-size: 13px;
      /* Slightly larger for better icon visibility */
      transition: all 0.3s ease;
  }

  #pulseaudio:hover {
      background: rgba(82, 79, 103, 0.3);
  }

  #pulseaudio.muted {
      background: rgba(255, 0, 0, 0.2);
      color: #ff6666;
  }

  /* Microphone module base styling - matching your audio theme */
  #pulseaudio.microphone {
      background: rgba(82, 79, 103, 0.2);
      border-radius: 6px;
      margin: 2px;
      padding: 0 10px;
      color: #b8b5c7;
      font-size: 13px;
  }

  /* Animation for volume changes */
  #pulseaudio.microphone {
      animation: pulse 0.3s ease-in-out;
  }

  #pulseaudio.microphone.source-muted {
      background: rgba(255, 0, 0, 0.2);
      color: #ff6666;
  }


  #backlight {
      background: rgba(82, 79, 103, 0.2);
      border-radius: 6px;
      margin: 2px;
      padding: 0 10px;
      color: #b8b5c7;
      font-size: 13px;
      transition: all 0.3s ease;
  }

  /* System tray */
  #tray {
      background: rgba(82, 79, 103, 0.2);
      border-radius: 6px;
      margin: 2px;
      padding: 0 8px;
  }
  #tray>.passive {
      -gtk-icon-effect: dim;
  }

  #tray>.needs-attention {
      -gtk-icon-effect: highlight;
      background: rgba(255, 215, 0, 0.2);
  }

  #custom-expand-icon {
      margin-right: 18px;
      transition: all 0.3s ease;
      background: rgba(82, 79, 103, 0.2);
      border-radius: 6px;
      margin: 2px;
      padding: 0 10px;
      color: #b8b5c7;
      font-size: 13px;
  }


  /* Tooltip */
  tooltip {
      background: rgba(0, 0, 0, 0.8);
      border-radius: 6px;
      border: 1px solid rgba(82, 79, 103, 0.5);
      color: #b8b5c7;
  }

  tooltip label {
      color: #b8b5c7;
  }
''
