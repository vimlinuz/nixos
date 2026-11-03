{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    opts.enable = lib.mkEnableOption "Custom Neovim options";
  };
  config = lib.mkIf config.opts.enable {
    programs.nixvim.opts = {
      # Set the default shell to use (default: '/bin/sh')
      # shell = "${pkgs.nushell}/bin/nu";

      # Disable GUI cursor styling (default: '')
      guicursor = "";
      # Make line numbers default (default: false)
      number = true;
      # Set relative numbered lines (default: false)
      relativenumber = true;
      # Sync clipboard between OS and Neovim (default: '')
      clipboard = "unnamedplus";
      # Display lines as one long line (default: true)
      wrap = false;
      # Companion to wrap, don't split words (default: false)
      linebreak = true;
      # Enable mouse mode (default: '')
      mouse = "a";
      # Copy indent from current line when starting new one (default: true)
      autoindent = true;
      # Case-insensitive searching UNLESS \C or capital in search (default: false)
      ignorecase = true;
      # Smart case (default: false)
      smartcase = true;
      # The number of spaces inserted for each indentation (default: 8)
      shiftwidth = 4;
      # Insert n spaces for a tab (default: 8)
      tabstop = 4;
      # Number of spaces that a tab counts for while performing editing operations (default: 0)
      softtabstop = 4;
      # Convert tabs to spaces (default: false)
      expandtab = true;
      # Minimal number of screen lines to keep above and below the cursor (default: 0)
      scrolloff = 10;
      # Minimal number of screen columns either side of cursor if wrap is `false` (default: 0)
      sidescrolloff = 8;
      # Highlight the column of the cursor (default: false)
      cursorcolumn = false;
      # Highlight the current line (default: false)
      cursorline = false;
      # Force all horizontal splits to go below current window (default: false)
      splitbelow = true;
      # Force all vertical splits to go to the right of current window (default: false)
      splitright = true;
      # Set highlight on search (default: true)
      hlsearch = false;
      # Show partial matches for a search pattern (default: false)
      incsearch = true;
      # We don't need to see things like -- INSERT -- anymore (default: true)
      showmode = false;
      # Set termguicolors to enable highlight groups (default: false)
      termguicolors = true;
      # Which "horizontal" keys are allowed to travel to prev/next line (default: 'b,s')
      whichwrap = "bs<>[]hl";
      # Set number column width to 4 (default: 4)
      numberwidth = 4;
      # Creates a swapfile (default: true)
      swapfile = false;
      # Make indenting smarter again (default: false)
      # this is handled by treesitter
      smartindent = false;
      # '2' Always show tabs, '1' show if more than one tab, '0' never show (default: 1)
      showtabline = 0;
      # Allow backspace on (default: 'indent,eol,start')
      backspace = "indent,eol,start";
      # Pop up menu height (default: 0)
      pumheight = 10;
      # So that `` is visible in markdown files (default: 1)
      conceallevel = 0;
      # Keep signcolumn on by default (default: 'auto')
      signcolumn = "yes";
      # The encoding written to a file (default: 'utf-8')
      fileencoding = "utf-8";
      # More space in the Neovim command line for displaying messages (default: 1)
      cmdheight = 1;
      # Enable break indent (default: false)
      breakindent = true;
      # Decrease update time (default: 4000)
      updatetime = 50;
      # Time to wait for a mapped sequence to complete (in milliseconds) (default: 1000)
      timeoutlen = 300;
      # Creates a backup file (default: false)
      backup = false;
      # If a file is being edited by another program it is not allowed to be edited (default: true)
      writebackup = false;
      # Save undo history (default: false)
      undofile = true;
      # Set completeopt to have a better completion experience (default: 'menu,preview')
      completeopt = "menuone,noselect";
      # Controls the visibility of the status line (0 = never, 1 = only if more than one window is open, 2 = always)
      laststatus = 0;
      # Highlight columns at 80 chars (default: '')
      # colorcolumn = "80";

      # Set default fold level to 99 (default: 0)
      foldlevelstart = 99;

      # Set fold method to 'expr' for treesitter based folding (default: 'manual')
      foldlevel = 99;

      # this will disable folding entirely
      foldenable = true;

      # Set the width of the fold column (default: 0)
      foldcolumn = "auto";

      # # Set fold method to 'expr' for treesitter based folding (default: 'manual')
      # foldmethod = "expr";
      #
      # # Set the fold expression to use treesitter (default: '')
      # foldexpr = "nvim_treesitter#foldexpr()";

      fillchars = {
        # Hide end of buffer ~ characters (default: true)
        eob = " ";
        fold = "─";
        # fold = "";

        foldopen = "▾";
        # foldopen = "";

        foldclose = "▸";
        # foldclose = "";

        # fold separator
        foldsep = "│";

        # fillchars for open folds
        foldinner = " ";

        wbr = "─";
        # msgsep = "─";
        horiz = "─";
        horizup = "│";
        horizdown = "│";
        vertright = "│";
        vertleft = "│";
        verthoriz = "│";
      };

    };

    # Additional options that need special handling in NixVim
    programs.nixvim.extraConfigLua = ''
      -- Don't give |ins-completion-menu| messages (default: does not include 'c')
      vim.opt.shortmess:append('c')

      -- Hyphenated words recognized by searches (default: does not include '-')
      vim.opt.iskeyword:append('-')

      -- Don't insert the current comment leader automatically for auto-wrapping comments using 'textwidth',
      -- hitting <Enter> in insert mode, or hitting 'o' or 'O' in normal mode. (default: 'croql')
      vim.opt.formatoptions:remove({ 'c', 'r', 'o' })

      -- Separate Vim plugins from Neovim in case Vim still in use (default: includes this path if Vim is installed)
      vim.opt.runtimepath:remove('/usr/share/vim/vimfiles')

      -- Netrw configuration
      -- Disables the netrw banner; use <C-i> to toggle it back
      vim.g.netrw_banner = 0

      -- Prevents netrw from changing the working directory
      vim.g.netrw_keepdir = 1

      -- Command to use for copying files in netrw (default: 'cp -r')
      vim.g.netrw_localcopydircmd = 'cp -r'
    '';
  };
}
