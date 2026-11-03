{ config, lib, ... }:
{
  options = {
    lualine.enable = lib.mkEnableOption "Enable lualine plugin for nixvim";
  };
  config = lib.mkIf config.lualine.enable {
    programs.nixvim.plugins.lualine = {
      enable = true;
      settings = {
        options = {
          icons_enabled = true;
          theme = "auto";
          section_separators = {
            left = "";
            right = "";
          };
          component_separators = {
            left = " ";
            right = " ";
          };
          disabled_filetypes = {
            statusline = [
              "alpha"
              "neo-tree"
            ];
            winbar = [ ];
          };
          always_divide_middle = true;
        };

        sections = {
          lualine_a = [
            {
              __raw = ''
                function()
                  return '󰫍'
                end
              '';

              padding = {
                left = 1;
                right = 0;
              };
            }
          ];

          lualine_b = [ "branch" ];

          lualine_c = [
            {
              __unkeyed-1 = "filename";
              file_status = true; # shows readonly, modified status
              path = 0; # 0 = just filename, 1 = relative path, 2 = absolute path
            }
          ];

          lualine_x = [
            # Diagnostics
            {
              __unkeyed-1 = "diagnostics";
              sources = [ "nvim_diagnostic" ];
              sections = [
                "error"
                "warn"
              ];
              symbols = {
                error = " ";
                warn = " ";
                info = " ";
                hint = "";
              };
              colored = false;
              update_in_insert = false;
              always_visible = false;
              cond.__raw = ''
                function()
                  return vim.fn.winwidth(0) > 100
                end
              '';
            }

            # Git diff
            {
              __unkeyed-1 = "diff";
              colored = false;
              symbols = {
                added = " ";
                modified = " ";
                removed = " ";
              };
              cond.__raw = ''
                function()
                  return vim.fn.winwidth(0) > 100
                end
              '';
            }

            # Encoding (hidden on small windows)
            {
              __unkeyed-1 = "encoding";
              cond.__raw = ''
                function()
                  return vim.fn.winwidth(0) > 100
                end
              '';
            }

            # Filetype (hidden on small windows)
            {
              __unkeyed-1 = "filetype";
              cond.__raw = ''
                function()
                  return vim.fn.winwidth(0) > 100
                end
              '';
            }
          ];

          lualine_y = [
            "location"
            "progress"
          ];
          lualine_z = [
            {
              __raw = ''
                function()
                  return ' '
                end
              '';
            }
          ];
        };

        inactive_sections = {
          lualine_a = [ ];
          lualine_b = [ ];
          lualine_c = [
            {
              __unkeyed-1 = "filename";
              path = 1; # relative path for inactive windows
            }
          ];
          lualine_x = [
            {
              __unkeyed-1 = "location";
              padding = 0;
            }
          ];
          lualine_y = [ ];
          lualine_z = [ ];
        };

        tabline = { };
        extensions = [ "fugitive" ];
      };
    };
  };
}
