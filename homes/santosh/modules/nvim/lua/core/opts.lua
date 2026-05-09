do
  local nixvim_options = {
    autoindent = true,
    backspace = "indent,eol,start",
    backup = false,
    breakindent = true,
    clipboard = "unnamedplus",
    cmdheight = 1,
    completeopt = "menuone,noselect",
    conceallevel = 0,
    cursorcolumn = false,
    cursorline = false,
    expandtab = true,
    fileencoding = "utf-8",
    fillchars = {
      eob = " ",
      fold = "─",
      foldclose = "▸",
      foldinner = " ",
      foldopen = "▾",
      foldsep = "│",
      horiz = "─",
      horizdown = "│",
      horizup = "│",
      verthoriz = "│",
      vertleft = "│",
      vertright = "│",
      wbr = "─",
    },
    foldcolumn = "auto",
    foldenable = true,
    foldlevel = 99,
    foldlevelstart = 99,
    guicursor = "",
    hlsearch = false,
    ignorecase = true,
    incsearch = true,
    laststatus = 0,
    linebreak = true,
    mouse = "a",
    number = true,
    numberwidth = 4,
    pumheight = 10,
    relativenumber = true,
    scrolloff = 10,
    shiftwidth = 4,
    showmode = false,
    showtabline = 0,
    sidescrolloff = 8,
    signcolumn = "yes",
    smartcase = true,
    smartindent = false,
    softtabstop = 4,
    splitbelow = true,
    splitright = true,
    swapfile = false,
    tabstop = 4,
    termguicolors = true,
    timeoutlen = 300,
    undofile = true,
    updatetime = 50,
    whichwrap = "bs<>[]hl",
    wrap = false,
    writebackup = false,
  }

  for k, v in pairs(nixvim_options) do
    vim.opt[k] = v
  end
end
-- Don't give |ins-completion-menu| messages (default: does not include 'c')
vim.opt.shortmess:append("c")

-- Hyphenated words recognized by searches (default: does not include '-')
vim.opt.iskeyword:append("-")

-- Don't insert the current comment leader automatically for auto-wrapping comments using 'textwidth',
-- hitting <Enter> in insert mode, or hitting 'o' or 'O' in normal mode. (default: 'croql')
vim.opt.formatoptions:remove({ "c", "r", "o" })

-- Separate Vim plugins from Neovim in case Vim still in use (default: includes this path if Vim is installed)
vim.opt.runtimepath:remove("/usr/share/vim/vimfiles")

-- Netrw configuration
-- Disables the netrw banner; use <C-i> to toggle it back
vim.g.netrw_banner = 0

-- Prevents netrw from changing the working directory
vim.g.netrw_keepdir = 1

-- Command to use for copying files in netrw (default: 'cp -r')
vim.g.netrw_localcopydircmd = "cp -r"
