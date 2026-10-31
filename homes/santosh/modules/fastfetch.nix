{ config, ... }:
{
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        source = "${config.home.homeDirectory}/nixos/homes/santosh/assets/nixos.png";
        height = 15;
        width = 40;
        padding = {
          right = 2;
          top = 1;
        };
        color = {
          "1" = "blue";
          "2" = "white";
        };
      };

      display = {
        size = {
          binaryPrefix = "si";
          ndigits = 2;
        };
        color = {
          keys = "blue";
          output = "white";
        };
        separator = " ❯ ";
        key.width = 12;
      };

      modules = [
        {
          type = "title";
          color = {
            user = "blue";
            at = "white";
            host = "white";
          };
        }
        "break"

        # {
        #   type = "datetime";
        #   key = "󰃭 Date";
        #   format = "{1}/{3}/{11}";
        # }
        # {
        #   type = "datetime";
        #   key = " Time";
        #   format = "{15}:{17} {21}";
        # }
        {
          type = "uptime";
          key = "󰅐 Uptime";
        }
        "break"

        # {
        #   type = "os";
        #   key = " OS";
        # }
        # {
        #   type = "host";
        #   key = "󰌢 Host";
        # }
        {
          type = "kernel";
          key = " Kernel";
        }
        {
          type = "packages";
          key = "󰏖 Packages";
        }
        # {
        #   type = "shell";
        #   key = "󰆍 Shell";
        # }
        {
          type = "display";
          key = "󰍹 Display";
        }
        {
          type = "de";
          key = "󰧨 DE";
        }
        {
          type = "wm";
          key = "󰨇 WM";
        }
        {
          type = "wmtheme";
          key = "󰉼 WM Theme";
        }
        {
          type = "theme";
          key = "󰉼 Theme";
        }
        {
          type = "icons";
          key = "󰀻 Icons";
        }
        {
          type = "terminal";
          key = " Terminal";
        }
        # {
        #   type = "terminalfont";
        #   key = "󰛖 Term Font";
        # }
        "break"

        {
          type = "cpu";
          key = "󰻠 CPU";
          showPeCoreCount = true;
        }
        {
          type = "gpu";
          key = "󰢮 GPU";
        }
        {
          type = "memory";
          key = " Memory";
        }
        {
          type = "swap";
          key = "󰓡 Swap";
        }
        {
          type = "disk";
          key = " Storage";
          folders = "/";
        }
        "break"

        {
          type = "player";
          key = "󰎆 Now Playing";
        }
        {
          type = "media";
          key = "󰝚 Media";
        }
      ];
    };
  };
}
