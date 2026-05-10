{
  config,
  lib,
  ...
}:
{
  options = {
    autocompletion.enable = lib.mkEnableOption "Enable/disable custom autocompletion setup";
  };
  config = lib.mkIf config.autocompletion.enable {
    programs.nixvim.plugins.cmp-latex-symbols = {
      enable = true;
    };
    programs.nixvim.plugins.cmp-fish = {
      enable = false;
    };
    programs.nixvim.plugins.cmp-git = {
      enable = true;
    };
    programs.nixvim.plugins.cmp-spell = {
      enable = true;
    };
    programs.nixvim.plugins.cmp-emoji = {
      enable = true;
    };
    programs.nixvim.plugins.cmp-calc = {
      enable = true;
    };
    programs.nixvim.plugins.cmp-cmdline = {
      enable = true;
    };
    programs.nixvim.plugins.cmp-async-path = {
      enable = true;
    };
    programs.nixvim.plugins.cmp-nvim-lsp-document-symbol = {
      enable = true;
    };
    programs.nixvim.plugins.cmp-nvim-lsp-signature-help = {
      enable = true;
    };
    programs.nixvim.plugins.copilot-cmp = {
      enable = false;
    };

    programs.nixvim.plugins.lspkind = {
      enable = true;
      # enabling this will give the two icons side by side which looks cluttered
      cmp.enable = false;
      settings = {
        cmp = {
          max_width = 10;
        };
        mode = "symbol_text";
        symbol_map = {
          Copilot = "";
        };
        maxwidth = 50;
        ellipsis_char = "...";
      };
    };
    programs.nixvim.plugins = {
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          sources = [
            { name = "calc"; }
            { name = "nvim_lsp"; }
            { name = "buffer"; }
            { name = "luasnip"; }
            { name = "nvim_lsp_signature_help"; }
            { name = "spell"; }
            { name = "async_path"; }
            { name = "emoji"; }
            # { name = "fish"; }
            { name = "git"; }
            { name = "latex_symbols"; }
            { name = "nvim_lsp_document_symbols"; }
            # { name = "copilot"; }
          ];
          snippet = {
            expand = "function(args) require('luasnip').lsp_expand(args.body) end";
          };
          window = {
            documentation = {
              border = [
                "╭"
                "─"
                "╮"
                "│"
                "╯"
                "─"
                "╰"
                "│"
              ];
              winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:CursorLine,Search:None";
              # max_width = 50;
              # max_height = 20;
            };
            completion = {
              # border = [
              #   "╭"
              #   "─"
              #   "╮"
              #   "│"
              #   "╯"
              #   "─"
              #   "╰"
              #   "│"
              # ];
              winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:CurSearch,Search:None";
              scrollbar = false;
              # max_width = 50;
              # max_height = 20;
            };
          };

          mapping = {
            "<C-l>" =
              "cmp.mapping(function(fallback) local luasnip = require('luasnip') if luasnip.expand_or_locally_jumpable() then luasnip.expand_or_jump() else fallback() end end, {'i', 's'})";
            "<C-h>" =
              "cmp.mapping(function(fallback) local luasnip = require('luasnip') if luasnip.locally_jumpable(-1) then luasnip.jump(-1) else fallback() end end, {'i', 's'})";
            "<C-n>" = "cmp.mapping.select_next_item()";
            "<C-p>" = "cmp.mapping.select_prev_item()";
            "<C-y>" = "cmp.mapping.confirm({ select = true })";

            "<C-Space>" = "cmp.mapping.complete()";

            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-e>" = "cmp.mapping.close()";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";

            # here this one is for response of pressing the enter
            # "<CR>" = "cmp.mapping.confirm({ select = true })";
            # "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            # "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
          };
        };
        cmdline = {
          "/" = {
            mapping = {
              __raw = "cmp.mapping.preset.cmdline()";
            };
            sources = [ { name = "buffer"; } ];
          };
          ":" = {
            mapping = {
              __raw = "cmp.mapping.preset.cmdline()";
            };
            sources = [
              { name = "async_path"; }
              { name = "cmdline"; }
            ];
          };
        };
      };

      cmp-nvim-lsp.enable = true;
      cmp-buffer.enable = true;
      cmp_luasnip.enable = true;
      luasnip.enable = true;
    };
  };
}
