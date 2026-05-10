{ config, lib, ... }:
{
  options = {
    keymaps.enable = lib.mkEnableOption "Enable/disable custom keymaps";
  };
  config = lib.mkIf config.keymaps.enable {
    programs.nixvim = {
      # local and globals leader keys
      globals.mapleader = " ";
      globals.maplocalleader = " ";
    };

    programs.nixvim.keymaps = [
      # keymaps for quick fix like
      # next quickfix item
      {
        key = "]q";
        mode = [ "n" ];
        action = "<cmd>cnext<CR>zz";
        options.desc = "Go to next quickfix item";

      }
      # previous quickfix item
      {
        key = "[q";
        mode = [ "n" ];
        action = "<cmd>cprev<CR>zz";
        options.desc = "Go to previous quickfix item";
      }
      # next location list item
      {
        key = "]Q";
        mode = [ "n" ];
        action = "<cmd>lnext<CR>zz";
        options.desc = "Go to next location list item";
      }
      # previous location list item
      {
        key = "[Q";
        mode = [ "n" ];
        action = "<cmd>lprev<CR>zz";
        options.desc = "Go to previous location list item";
      }
      # Noice dismiss all notifications
      {
        key = "<leader>nd";
        mode = [ "n" ];
        action = "<CMD>NoiceDismiss<CR>";
        options.desc = "Dismiss all Noice notifications";
      }
      # key maps for copilot chats
      {
        key = "<leader>cR";
        mode = [ "n" ];
        action = "<CMD>CopilotChatReset<CR>";
        options.desc = "Reset Copilot Chat";
      }
      {
        key = "<leader>ct";
        mode = [
          "n"
          "v"
        ];
        action = "<CMD>CopilotChatToggle<CR>";
        options.desc = "Toggle Copilot Chat Window";
      }
      {
        key = "<leader>cs";
        mode = [
          "n"
          "v"
        ];
        action = "<CMD>CopilotChatStop<CR>";
        options.desc = "Stop current Copilot output";
      }
      {
        key = "<leader>cr";
        mode = [ "v" ];
        action = "<CMD>CopilotChatReview<CR>";
        options.desc = "Review the selected code";
      }
      {
        key = "<leader>ce";
        mode = [ "v" ];
        action = "<CMD>CopilotChatExplain<CR>";
        options.desc = "Give an explanation for the selected code";
      }
      {
        key = "<leader>cd";
        mode = [ "v" ];
        action = "<CMD>CopilotChatDocs<CR>";
        options.desc = "Add documentation for the selection";
      }
      {
        key = "<leader>cp";
        mode = [ "v" ];
        action = "<CMD>CopilotChatTests<CR>";
        options.desc = "Add tests for my code";
      }
      # using the api of terminal that I wrote
      # {
      #   key = "<leader>t";
      #   action = "<cmd>Terminal<CR>";
      #   mode = [ "n" ];
      #   options = {
      #     silent = true;
      #     noremap = true;
      #     desc = "Opern floating terminal";
      #   };
      # }
      {
        key = "<leader>t";
        action = "<cmd>Terminal code-runner<CR>";
        mode = [ "n" ];
        options = {
          silent = true;
          noremap = true;
          desc = "Run the code-runner script";
        };
      }
      {
        key = "<leader>ao";
        action = "<cmd>Terminal opencode .<CR>";
        mode = [ "n" ];
        options = {
          silent = true;
          noremap = true;
          desc = "Open code";
        };
      }
      # keep last yanked when pasting over some thing
      {
        action = ''"_dP'';
        key = "p";
        mode = [ "v" ];
        options = {
          silent = true;
          noremap = true;
        };
      }
      # stay in indent mode
      {
        action = ">gv";
        key = "<C-l>";
        mode = [ "v" ];
        options = {
          silent = true;
          noremap = true;
          desc = "> without loosing indent mode";
        };
      }
      {
        action = "<gv";
        key = "<C-h>";
        mode = [ "v" ];
        options = {
          silent = true;
          noremap = true;
          desc = "< without loosing indent mode";
        };
      }
      # move selected line up and down
      {
        action = ":m '>+1<CR>gv";
        key = "<C-j>";
        mode = [ "v" ];
        options = {
          silent = true;
          noremap = true;
          desc = "Move selected line down";
        };
      }
      # move selected line up and down
      {
        action = ":m '<-2<CR>gv";
        key = "<C-k>";
        mode = [ "v" ];
        options = {
          silent = true;
          noremap = true;
          desc = "Move selected line up";
        };
      }

      # toggle line wrapping
      {
        action = "<cmd>set wrap!<CR>";
        key = "<leader>lw";
        mode = [ "n" ];
        options = {
          silent = true;
          noremap = true;
          desc = "Toggle line wrapping";
        };
      }
      # find and center
      {
        action = "nzzzv";
        key = "n";
        mode = [ "n" ];
        options = {
          silent = true;
          noremap = true;
          desc = "Find n with cursor in center";
        };
      }
      {
        action = "nzzzv";
        key = "N";
        mode = [ "n" ];
        options = {
          silent = true;
          noremap = true;
          desc = "Find N with cursor in center";
        };

      }
      # join line with out moving cursor
      {
        action = "mzJ`z";
        key = "J";
        mode = [ "n" ];
        options = {
          silent = true;
          noremap = true;
          desc = "Join line with out moving cursor";
        };

      }
      # resize with arrow
      {
        action = "<cmd>resize +2<CR>";
        key = "<Up>";
        mode = [ "n" ];
        options = {
          silent = true;
          noremap = true;
          desc = "Horizontal resize +2";
        };
      }
      {
        action = "<cmd>resize -2<CR>";
        key = "<Down>";
        mode = [ "n" ];
        options = {
          silent = true;
          noremap = true;
          desc = "Horizontal resize -2";
        };
      }
      {
        action = "<cmd>vertical resize -2<CR>";
        key = "<Left>";
        mode = [ "n" ];
        options = {
          silent = true;
          noremap = true;
          desc = "Vertical resize -2";
        };
      }
      {
        action = "<cmd>vertical resize +2<CR>";
        key = "<Right>";
        mode = [ "n" ];
        options = {
          silent = true;
          noremap = true;
          desc = "Vertical resize +2";
        };
      }
      # Vertical scroll and center cursor
      {
        action = "<C-u>zz";
        key = "<C-u>";
        mode = [ "n" ];
        options = {
          silent = true;
          desc = "<C-u> with with cursor in center";
        };
      }
      {
        action = "<C-d>zz";
        key = "<C-d>";
        mode = [ "n" ];
        options = {
          silent = true;
          desc = "<C-d> with with cursor in center";
        };
      }
      # save file without auto-formatting
      {
        action = "<cmd>noautocmd w<CR>";
        key = "<leader>sn";
        mode = [ "n" ];
        options = {
          noremap = true;
          silent = true;
          desc = "save file without auto-formatting";
        };
      }
      # delete single character without copying into register
      {
        action = ''"_x'';
        key = "x";
        mode = [ "n" ];
        options = {
          noremap = true;
          silent = true;
          desc = "Delete single character with out copying into register";
        };
      }
      # keymaps for fugutive
      {
        action = "<cmd>diffget //2<CR>";
        key = "gh";
        mode = [
          "n"
          "v"
        ];
        options = {
          noremap = true;
          silent = true;
          desc = "Git Hunks: get left side of diff";
        };
      }
      {
        action = "<cmd>diffget //3<CR>";
        key = "gl";
        mode = [
          "n"
          "v"
        ];
        options = {
          noremap = true;
          silent = true;
          desc = "Git Hunks: get right side of diff";
        };
      }
      {
        action = "<cmd>GBrowse<CR>";
        key = "<leader>go";
        mode = [ "n" ];
        options = {
          noremap = true;
          silent = true;
          desc = "Git Browse";
        };
      }
      {
        action = "<cmd>Git<CR>";
        key = "<leader>gs";
        mode = [ "n" ];
        options = {
          noremap = true;
          silent = true;
          desc = "Git Status";
        };
      }
      {
        action = "<cmd>Git commit<CR>";
        key = "<leader>gc";
        mode = [ "n" ];
        options = {
          noremap = true;
          silent = true;
          desc = "Git Commit";
        };
      }
      {
        action = "<cmd>Git add .<CR>";
        key = "<leader>ga";
        mode = [ "n" ];
        options = {
          noremap = true;
          silent = true;
          desc = "Git Add All changes";
        };
      }
      {
        action = "<cmd>Gwrite<CR>";
        key = "<leader>gw";
        mode = [ "n" ];
        options = {
          noremap = true;
          silent = true;
          desc = "Git Write";
        };
      }
      {
        action = "<cmd>Gvdiffsplit!<CR>";
        key = "<leader>gd";
        mode = [ "n" ];
        options = {
          noremap = true;
          silent = true;
          desc = "Git Diff";
        };
      }
      {
        action = "<cmd>Gclog<CR>";
        key = "<leader>gl";
        mode = [ "n" ];
        options = {
          noremap = true;
          silent = true;
          desc = "Git Log";
        };
      }
      {
        action = "<cmd>Git blame<CR>";
        key = "<leader>gb";
        mode = [ "n" ];
        options = {
          noremap = true;
          silent = true;
          desc = "Git Blame";
        };
      }
      {
        action = "<cmd>Git push<CR>";
        key = "<leader>gp";
        mode = [ "n" ];
        options = {
          noremap = true;
          silent = true;
          desc = "Git Push";
        };
      }
      {
        action = "<cmd>Git fetch<CR>";
        key = "<leader>gf";
        mode = [ "n" ];
        options = {
          noremap = true;
          silent = true;
          desc = "git Fetch";
        };
      }
      {
        action = "<cmd>Gread<CR>";
        key = "<leader>gr";
        mode = [ "n" ];
        options = {
          noremap = true;
          silent = true;
          desc = "Git: restore buffer to HEAD";
        };
      }
      # key maps for undoo tree
      {
        action = "<cmd>UndotreeToggle<CR>";
        key = "<leader>u";
        mode = [ "n" ];
        options = {
          desc = "Toggle undo tree";
        };
      }
      # key map for treesitter-context
      {
        action.__raw = ''
          require('treesitter-context').go_to_context
        '';
        key = "[c";
        mode = [ "n" ];
        options = {
          desc = "Go to context";
          silent = true;
        };
      }
      # splits managements
      {
        action = "<cmd>vsplit<CR>";
        key = "<leader>v";
        mode = [ "n" ];
        options = {
          desc = "Split window vertically";
          silent = true;
        };
      }
      {
        action = "<cmd>split<CR>";
        key = "<leader>o";
        mode = [ "n" ];
        options = {
          desc = "Split window vertically";
          silent = true;
        };
      }
      {
        action = "<cmd>close<CR>";
        key = "<leader>q";
        mode = [ "n" ];
        options = {
          desc = "Close current split";
          silent = true;
        };
      }
      {
        action = "<cmd>only<CR>";
        key = "<leader>x";
        mode = [ "n" ];
        options = {
          desc = "Close all other splits";
          silent = true;
        };
      }

      # telescope key maps
      {
        action = "<cmd>Telescope colorscheme<CR>";
        key = "<leader>sc";
        mode = [ "n" ];
        options = {
          desc = "search colorscheme";
        };
      }
      {
        action = "<cmd>Telescope git_branches<CR>";
        key = "<leader>sb";
        mode = [ "n" ];
        options = {
          desc = "search git branches";
        };
      }
      {
        action = "<cmd>Telescope find_files<CR>";
        key = "<leader>sf";
        mode = [ "n" ];
        options = {
          desc = "Search files";
        };
      }
      # these two keymaps are for searching in current buffer Open files
      {
        action = "<cmd>Telescope current_buffer_fuzzy_find<CR>";
        key = "<leader>/";
        mode = [ "n" ];
        options = {
          desc = "[/] Fuzzily search in current buffer";
        };
      }
      {
        action.__raw = ''
          function()
              local builtin = require('telescope.builtin')
              builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                  winblend = 0,
                  previewer = true,
              })
          end'';
        key = "<leader>?";
        mode = [ "n" ];
        options = {
          desc = "[?] Fuzzily search in current buffer small window";
        };
      }
      {
        action.__raw = ''
          function()
          local builtin = require('telescope.builtin')
                 builtin.live_grep {
                  grep_open_files = true,
                  prompt_title = 'Live Grep in Open Files',
                }
              end'';
        key = "<leader>s/";
        mode = [ "n" ];
        options = {
          desc = "[S]earch [/] in Open Files";
        };
      }
      {
        action = "<cmd>Telescope help_tags<CR>";
        key = "<leader>sh";
        mode = [ "n" ];
        options = {
          desc = "Help_tags";
        };
      }
      {
        action = "<cmd>Telescope live_grep<CR>";
        key = "<leader>sg";
        mode = [ "n" ];
        options = {
          desc = "Search using live grep";
        };
      }
      {
        action = "<cmd>Telescope buffers<CR>";
        key = "<leader><leader>";
        mode = [ "n" ];
        options = {
          desc = "List buffers";
        };
      }
      {
        action = "<cmd>Telescope<CR>";
        key = "<leader>st";
        mode = [ "n" ];
        options = {
          desc = " help tags";
        };
      }
      {
        action = "<cmd>Telescope lsp_type_definitions<CR>";
        key = "<leader>sd";
        mode = [ "n" ];
        options = {
          desc = "Search LSP Definitions";
        };
      }
      {
        action = "<cmd>Telescope lsp_references<CR>";
        key = "<leader>sr";
        mode = [ "n" ];
        options = {
          desc = "Search LSP references";
        };
      }
      {
        action = "<cmd>Telescope lsp_document_symbols<CR>";
        key = "<leader>ss";
        mode = [ "n" ];
        options = {
          desc = "Search document symbols";
        };
      }
      # toggle oil
      {
        action.__raw = ''
          function()
          if vim.bo.filetype == 'oil' then
              vim.cmd('bdelete')
          else
              vim.cmd('Oil')
                  end
          end
        '';
        key = "<leader>e";
        mode = [ "n" ];
        options = {
          noremap = true;
          silent = true;
          desc = "toggle oil";
        };
      }

      # # toggle netrw
      # {
      #   action.__raw = ''
      #     function()
      #     if vim.bo.filetype == 'netrw' then
      #         vim.cmd('bdelete')
      #     else
      #         vim.cmd('Explore')
      #             end
      #             end
      #   '';
      #   key = "<leader>e";
      #   mode = [ "n" ];
      #   options = {
      #     noremap = true;
      #     silent = true;
      #     desc = "toggle netrw";
      #   };
      # }

      # comment.nvim key maps
      # Normal mode - toggle selected lines
      # Note: <C-_> maps to Ctrl+/ due to terminal key code handling
      {
        key = "<C-_>";
        action.__raw = "require('Comment.api').toggle.linewise.current";
        mode = "n";
        options = {
          noremap = true;
          silent = true;
          desc = "Toggle line wise comment in normal mode";
        };
      }
      {
        key = "<C-c>";
        action.__raw = "require('Comment.api').toggle.linewise.current";
        mode = "n";
        options = {
          noremap = true;
          silent = true;
          desc = "Toggle line wise comment in normal mode";
        };
      }
      {
        key = "<C-/>";
        action.__raw = "require('Comment.api').toggle.linewise.current";
        mode = "n";
        options = {
          noremap = true;
          silent = true;
          desc = "Toggle line wise comment in normal mode";
        };
      }

      # Visual mode - toggle selected lines
      {
        key = "<C-_>";
        action = "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>";
        mode = "v";
        options = {
          noremap = true;
          silent = true;
          desc = "Toggle line wise comment in visual mode";
        };
      }
      {
        key = "<C-c>";
        action = "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>";
        mode = "v";
        options = {
          noremap = true;
          silent = true;
          desc = "Toggle line wise comment in visual mode";
        };
      }
      {
        key = "<C-/>";
        action = "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>";
        mode = "v";
        options = {
          noremap = true;
          silent = true;
          desc = "Toggle line wise comment in visual mode";
        };
      }

      # harpoon key maps
      {
        mode = "n";
        key = "<leader>H";
        action.__raw = "function() require'harpoon'.ui:toggle_quick_menu(require'harpoon':list()) end";
        options = {
          desc = "Toogle harpoon ui";
        };
      }
      {
        mode = "n";
        key = "<leader>h";
        action.__raw = "function() require'harpoon':list():add() end";
        options = {
          desc = "Add current buffer in harpoons list";
        };
      }

      {
        mode = "n";
        key = "<leader>d";
        action.__raw = "function() require'harpoon':list():select(1) end";
        options = {
          desc = "Select 1 ih list of harpoon";
        };
      }
      {
        mode = "n";
        key = "<leader>f";
        action.__raw = "function() require'harpoon':list():select(2) end";
        options = {
          desc = "Select 2 in list of harpoon";
        };
      }
      {
        mode = "n";
        key = "<leader>j";
        action.__raw = "function() require'harpoon':list():select(3) end";
        options = {
          desc = "Select 3 in list of harpoon";
        };
      }
      {
        mode = "n";
        key = "<leader>k";
        action.__raw = "function() require'harpoon':list():select(4) end";
        options = {
          desc = "Select 4 in list of harpoon";
        };
      }
      {
        mode = "n";
        key = "<leader>>";
        action.__raw = "function() require('harpoon'):list():next() end";
        options = {
          desc = "Next harpoon buffer";
        };
      }
      {
        mode = "n";
        key = "<leader><";
        action.__raw = "function() require('harpoon'):list():prev() end";
        options = {
          desc = "Previous harpoon buffer";
        };
      }
      # key maps for lsp saga
      # Pops up a floating window showing the definition
      {
        action = "<cmd>Lspsaga peek_definition<CR>";
        key = "<leader>cd";
        mode = [ "n" ];
        options = {
          desc = "Code Definition";
        };
      }
      {
        #action = "<cmd>Telescope lsp_incoming_calls<CR>";
        action = "<cmd>Lspsaga incoming_calls<CR>";
        key = "<leader>ci";
        mode = [ "n" ];
        options = {
          desc = "Code Incoming Calls";
        };
      }
      {
        #action = "<cmd>Telescope lsp_outgoing_calls<CR>";
        action = "<cmd>Lspsaga outgoing_calls<CR>";
        key = "<leader>co";
        mode = [ "n" ];
        options = {
          desc = "Code Outgoing Calls";
        };
      }
      {
        action = "<cmd>Lspsaga outline<CR>";
        key = "<leader>cs";
        mode = [ "n" ];
        options = {
          desc = "Code Symbols Outline";
        };
      }
    ];

    # lsp with lsp saga key maps
    programs.nixvim.lsp.keymaps =

      [
        {
          key = "gd";
          lspBufAction = "definition";
          options = {
            desc = "Go to defination";
          };
        }
        {
          key = "gD";
          lspBufAction = "references";
          options = {
            desc = "References";
          };
        }
        {
          key = "gt";
          lspBufAction = "type_definition";
          options = {
            desc = "Type defination";
          };
        }
        {
          key = "gi";
          lspBufAction = "implementation";
          options = {
            desc = "Got to implementation";
          };
        }
        # {
        #   key = "K";
        #   lspBufAction = "hover";
        # }
        {
          action = "<CMD>Lspsaga hover_doc<Enter>";
          key = "K";
          options = {
            desc = "Hover docs";
          };
        }
        {
          action = "<CMD>Lspsaga rename<Enter>";
          key = "<leader>rn";
          options = {
            desc = "Rename the variable";
          };
        }
        {
          action = "<CMD>Lspsaga code_action<Enter>";
          key = "<leader>ca";
          options = {
            desc = "Code action";
          };
        }
        {
          action = "<CMD>Lspsaga diagnostic_jump_next<Enter>";
          key = "]d";
          options = {
            desc = "Jump to next diagnostic ";
          };
        }
        {
          action = "<CMD>Lspsaga diagnostic_jump_prev<Enter>";
          key = "[d";
          options = {
            desc = "Jump to previous diagnostic ";
          };
        }
      ];
  };
}
