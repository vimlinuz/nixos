{
  services.swaync = {
    enable = true;
    settings = {
      positionX = "right";
      positionY = "top";
      layer = "overlay";
      control-center-layer = "top";
      layer-shell = true;
      cssPriority = "user";
      control-center-margin-top = 20;
      control-center-margin-bottom = 60;
      control-center-margin-right = 10;
      control-center-margin-left = 20;
      notification-2fa-action = true;
      notification-inline-replies = true;
      notification-icon-size = 72;
      notification-body-image-height = 120;
      notification-body-image-width = 240;
    };
    style = ''
       * {
         font-family: "JetBrains Mono Nerd Font", "Fira Code Nerd Font", monospace;
         font-size: 12px;
         font-weight: 400;
       }

       .control-center {
         background: rgba(0, 0, 0, 0.8);
         border-radius: 20px;
         border: 1px solid rgba(64,64,64,1) rgba(96,96,96,1) 45deg;
         box-shadow: 0 4px 16px rgba(0, 0, 0, 0.4);
         color: #b8b5c7;
         width: 300px;
         max-height: 600px;
       }

      .notification {
      padding: 12px;
        background: rgba(0, 0, 0, 0.8);
        border-radius: 20px;
        border: 1px solid rgba(64,64,64,1) rgba(96,96,96,1) 45deg;
        box-shadow: 0 4px 16px rgba(0, 0, 0, 0.4);
        color: #b8b5c7;
        min-width: 300px;
        min-height: 80px;
        max-width: 400px;
      }

       .control-center-list {
         background: transparent;
         border-radius: 6px;
         border: none;
         margin: 4px;
       }

       .control-center-list-placeholder {
         opacity: 0.4;
         font-style: italic;
         font-weight: 300;
         color: #b8b5c7;
       }

       .summary {
         font-size: 14px;
         font-weight: bold;
         color: #ffffff;
         text-shadow: none;
         margin-bottom: 2px;
         background: transparent;
       }

       .time {
         font-size: 10px;
         font-weight: normal;
         color: #b8b5c7;
         margin-bottom: 4px;
         font-style: italic;
         opacity: 0.7;
       }

       .body {
         font-size: 13px;
         font-weight: normal;
         background: transparent;
         color: #b8b5c7;
         line-height: 1.3;
         margin-top: 4px;
       }

       tooltip {
         background: rgba(0, 0, 0, 0.8);
         border-radius: 6px;
         border: 1px solid rgba(82, 79, 103, 0.5);
         color: #b8b5c7;
       }

       tooltip label {
         color: #b8b5c7;
       }
    '';
  };
}
