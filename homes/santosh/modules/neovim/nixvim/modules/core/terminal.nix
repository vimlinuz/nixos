{ config, lib, ... }:
{
  options = {
    terminal.enable = lib.mkEnableOption "Enable/disable custom terminal setup";
  };

  config = lib.mkIf config.terminal.enable {
    programs.nixvim.extraConfigLua = ''
              local run = {}

          function run.open_float_term(cmd)
              -- Default to shell if no command provided
              -- here in my case the cmd is nill so vim.o.shell is the one that I use
              cmd = cmd or vim.o.shell

              -- Create a new buffer and stores the ID to the variable buf
              local buf = vim.api.nvim_create_buf(false, true)
              -- here in place of the listed it is false so it will not be listed in the :ls and :buffers
              -- vim.api.nvim_create_buf(listed, scratch)

              -- Set window size and position (centered)
              local width = math.floor(vim.o.columns * 0.8)
              local height = math.floor(vim.o.lines * 0.8)
              local col = math.floor((vim.o.columns - width) / 2)
              local row = math.floor((vim.o.lines - height) / 2)

              -- Window appearance options
              local opts = {
                  relative = 'editor',
                  width = width,
                  height = height,
                  col = col,
                  row = row,
                  style = 'minimal',
                  border = 'rounded',
              }
          -- Open the window
              local win = vim.api.nvim_open_win(buf, true, opts)

              -- Or we can do this directly
              -- local win = vim.api.nvim_open_win(buf, true, {
                      --   relative = 'editor',
                      --   width = width,
                      --   height = height,
                      --   col = col,
                      --   row = row,
                      --   style = 'minimal',
                      --   border = 'rounded',
                      -- })

              -- Start terminal in the buffer with the specified command
              vim.fn.termopen(cmd)

              -- Executes the Vim command :startinsert
              -- which will put the neovim into insert mode, which is the natural for interacting
              -- with the terminal buffers
              vim.cmd 'startinsert'

              -- Close window when leaving the buffer
              vim.api.nvim_create_autocmd('BufLeave', {
                      buffer = buf,
                      callback = function()
                      vim.api.nvim_win_close(win, true)
                      end,
                      once = true,
                      })
          end

              -- Create a command to open terminal with arguments
              function run.create_terminal_command()
              vim.api.nvim_create_user_command('Terminal', function(opts)
                      local cmd = opts.args ~= "" and opts.args or vim.o.shell
                      run.open_float_term(cmd)
                      end, { nargs = '?', desc = 'Open floating terminal with optional command' })
              end

              -- Set up keymappings and commands
              function run.setup()
              -- Basic terminal
              -- vim.keymap.set('n', '<Leader>f', run.open_float_term, { noremap = true, silent = true })

              -- vim.keymap.set('n', '<Leader>f', function()
              --         run.open_float_term 'code-runner'
              --         end, { noremap = true, silent = true, desc = 'Run the code-runner script' })

              -- When silent is set to false,
              -- it means that Neovim will show output on the command line when the keybinding is triggered.

                  -- Some useful predefined terminals
                  -- vim.keymap.set('n', '<Leader>fg', function()
                          --   run.open_float_term 'lazygit'
                          -- end, { noremap = true, silent = true, desc = 'Open LazyGit in floating terminal' })
                  --
                  -- vim.keymap.set('n', '<Leader>fn', function()
                          --   run.open_float_term 'node'
                          -- end, { noremap = true, silent = true, desc = 'Open Node.js in floating terminal' })
                  --
                  -- vim.keymap.set('n', '<Leader>fp', function()
                          --   run.open_float_term 'python'
                          -- end, { noremap = true, silent = true, desc = 'Open Python in floating terminal' })
                  --
                  -- Create command for use with arguments
                  run.create_terminal_command()
                  end

      run.setup()
    '';
  };
}
