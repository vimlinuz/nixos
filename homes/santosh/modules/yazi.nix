{ pkgs, ... }:
{
  programs.yazi = {
    enable = true;
    shellWrapperName = "yy";
    enableBashIntegration = true;
    enableNushellIntegration = true;
    extraPackages = with pkgs; [
      glow
      ouch
    ];
    theme = {
      mgr = {
        cwd = {
          fg = "#7aa2f7";
        };
      };

      find = {
        keyword = {
          fg = "#f7768e";
          bold = true;
          italic = true;
          underline = true;
        };
        position = {
          fg = "#bb9af7";
          bg = "reset";
          bold = true;
          italic = true;
        };
      };
      # Marker
      marker = {
        copied = {
          fg = "#9ece6a";
          bg = "#9ece6a";
        };
        cut = {
          fg = "#e0af68";
          bg = "#f7768e";
        };
        marked = {
          fg = "#7aa2f7";
          bg = "#7dcfff";
        };
        selected = {
          fg = "#e0af68";
          bg = "#e0af68";
        };
      };

      # Count
      count = {
        copied = {
          fg = "#1a1b26";
          bg = "#9ece6a";
        };
        cut = {
          fg = "#1a1b26";
          bg = "#e0af68";
        };
        selected = {
          fg = "#1a1b26";
          bg = "#7aa2f7";
        };
      };

      # Border
      border = {
        symbol = "│";
        style = {
          fg = "#414868";
        };
      };

      tabs = {

        active = {
          fg = "#292e42";
          bg = "#7aa2f7";
          bold = true;
        };
        inactive = {
          fg = "#7aa2f7";
          bg = "#292e42";
        };
      };

      mode = {
        normal_main = {
          fg = "#292e42";
          bg = "#7aa2f7";
          bold = true;
        };
        normal_alt = {
          fg = "#7aa2f7";
          bg = "#292e42";
        };
      };

      select = {
        main = {
          fg = "#292e42";
          bg = "#9ece6a";
          bold = true;
        };
        alt = {
          fg = "#7aa2f7";
          bg = "#292e42";
        };
      };

      unset = {
        main = {
          fg = "#292e42";
          bg = "#bb9af7";
          bold = true;
        };
        alt = {
          fg = "#7aa2f7";
          bg = "#292e42";
        };
      };

      status = {
        overall = {
          fg = "#7aa2f7";
        };
        sep_left = {
          open = "";
          close = "";
        };
        sep_right = {
          open = "";
          close = "";
        };

      };

      progress = {
        # Progress
        label = {
          fg = "#292e42";
          bold = true;
        };
        normal = {
          fg = "#7aa2f7";
          bg = "#292e42";
        };
        error = {
          fg = "#f7768e";
          bg = "#292e42";
        };
      };

      perm = {
        # Permissions
        sep = {
          fg = "#7aa2f7";
        };
        type = {
          fg = "#9ece6a";
        };
        read = {
          fg = "#e0af68";
        };
        write = {
          fg = "#f7768e";
        };
        exec = {
          fg = "#bb9af7";
        };
      };

      pick = {
        border = {
          fg = "#7aa2f7";
        };
        active = {
          fg = "#bb9af7";
          bold = true;
        };
        inactive = { };

      };

      input = {
        border = {
          fg = "#7aa2f7";
        };
        title = { };
        value = { };
        selected = {
          reversed = true;
        };
      };
      cmp = {
        border = {
          fg = "#7aa2f7";
        };
      };

      tasks = {
        border = {
          fg = "#7aa2f7";
        };
        title = { };
        hovered = {
          fg = "#bb9af7";
          underline = true;
        };

      };

      which = {

        mask = {
          bg = "#414868";
        };
        cand = {
          fg = "#9ece6a";
        };
        rest = {
          fg = "#a9b1d6";
        };
        desc = {
          fg = "#bb9af7";
        };
        separator = "  ";
      };
      separator.style = {
        fg = "#626880";
      };

      help = {

        on = {
          fg = "#9ece6a";
        };
        run = {
          fg = "#bb9af7";
        };
        hovered = {
          reversed = true;
          bold = true;
        };
        footer = {
          fg = "#1a1b26";
          bg = "#a9b1d6";
        };

      };

      # : }}}

      # : Spotter {{{

      spot = {

        border = {
          fg = "#7aa2f7";
        };
        title = {
          fg = "#7aa2f7";
        };
        tbl_col = {
          fg = "#9ece6a";
        };
        tbl_cell = {
          fg = "#bb9af7";
          bg = "#292e42";
        };
      };

      # : }}}

      # : Notify {{{

      notify = {

        title_info = {
          fg = "#9ece6a";
        };
        title_warn = {
          fg = "#f7768e";
        };
        title_error = {
          fg = "#e0af68";
        };
      };

      # : }}}

      # : File-specific styles {{{

      filetype = {

        rules = [
          # Images
          {
            mime = "image/*";
            fg = "#e0af68";
          }

          # Media
          {
            mime = "video/*";
            fg = "#f7768e";
          }
          {
            mime = "audio/*";
            fg = "#f7768e";
          }

          # Archives
          {
            mime = "application/zip";
            fg = "#bb9af7";
          }
          {
            mime = "application/x-tar";
            fg = "#bb9af7";
          }
          {
            mime = "application/x-bzip*";
            fg = "#bb9af7";
          }
          {
            mime = "application/x-bzip2";
            fg = "#bb9af7";
          }
          {
            mime = "application/x-7z-compressed";
            fg = "#bb9af7";
          }
          {
            mime = "application/x-rar";
            fg = "#bb9af7";
          }
          {
            mime = "application/x-xz";
            fg = "#bb9af7";
          }

          # Documents
          {
            mime = "application/doc";
            fg = "#9ece6a";
          }
          {
            mime = "application/epub+zip";
            fg = "#9ece6a";
          }
          {
            mime = "application/pdf";
            fg = "#9ece6a";
          }
          {
            mime = "application/rtf";
            fg = "#9ece6a";
          }
          {
            mime = "application/vnd.*";
            fg = "#9ece6a";
          }

          # Special files
          {
            mime = "*";
            is = "orphan";
            fg = "#f29cb4";
            bg = "#93000a";
          }
          {
            mime = "application/*exec*";
            fg = "#f7768e";
          }

          # Fallback
          {
            url = "*";
            fg = "#c6d0f5";
          }
          {
            url = "*/";
            fg = "#7aa2f7";
          }
        ];

      };

    };

  };
}
