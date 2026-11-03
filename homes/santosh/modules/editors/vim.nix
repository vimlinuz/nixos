{ pkgs, ... }:
{
  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      vim-lsp
      vim-lsp-settings
      fzf-vim
      vim-commentary
      vim-surround
      vim-fugitive
      vim-rhubarb
      indentLine
      vim-unimpaired
      falcon
      vim-tmux-navigator
    ];
    extraConfig = ''
      " --- [why noshelltemp](https://github.com/vim/vim/issues/20123) ---
      set noshelltemp
      set noswapfile
      set expandtab
      set whichwrap=bs<>[]hl
      set nobackup nowritebackup
      set noundofile
      set nowritebackup
      set updatetime=50
      set timeoutlen=300
      set ignorecase
      set smartcase
      set number
      set relativenumber
      set termguicolors
      set expandtab
      set splitbelow
      set splitright
      set softtabstop=4
      set smartindent
      set signcolumn=yes
      set scrolloff=10
      set numberwidth=4
      set linebreak
      set laststatus=0
      set fileencoding=utf-8
      set autoindent
      set incsearch
      set breakindent
      set mouse=a
      set clipboard=unnamedplus
      syntax on
      set autoindent
      colorscheme falcon

      let mapleader = " "
      " --- fzf vim keybindings to mimic telescope ---
      nnoremap <leader>sf :Files<CR>
      nnoremap <leader><leader> :Buffers<CR>
      nnoremap <leader>sg :Rg<space>
      nnoremap <leader>sc :Colors<CR>

      " --- Lsp config ---
      nnoremap [d :LspPreviousError<CR>
      nnoremap ]d :LspNextError<CR>
      nnoremap K :LspHover<CR>
      nnoremap <leader>ss :LspDocumentSymbolSearch<CR>

      " --- commenting (vim-commentary) ---
      nnoremap <C-c> :Commentary<CR>
      vnoremap <C-c> :Commentary<CR>
      nnoremap <C-/> :Commentary<CR>
      vnoremap <C-/> :Commentary<CR>

      " --- splits ---
      nnoremap <leader>v :vsplit<CR>
      nnoremap <leader>o :split<CR>
      nnoremap <leader>q :close<CR>
      nnoremap <leader>x :only<CR>

      " --- open splits navigation (vim-tmux-navigator) ---
      nnoremap <C-l> :TmuxNavigateRight<CR>
      nnoremap <C-h> :TmuxNavigateLeft<CR>
      nnoremap <C-j> :TmuxNavigateDown<CR>
      nnoremap <C-k> :TmuxNavigateUp<CR>

      " --- buffer navigation (vim-unimpaired) ---
      nnoremap ]b :bnext<CR>
      nnoremap [b :bprevious<CR>


      " --- git (vim-fugitive) ---
      nnoremap <leader>gs :Git<CR>
      nnoremap <leader>gc :Git commit<CR>
      nnoremap <leader>ga :Git add .<CR>
      nnoremap <leader>gd :Gdiff<CR>
      nnoremap <leader>gl :Gclog<CR>
      nnoremap <leader>gb :Git blame<CR>
      nnoremap <leader>gp :Git push<CR>
      nnoremap <leader>gf :Git fetch<CR>
      nnoremap <leader>gr :Gread<CR>

      " --- filetree (netrw) ---
      nnoremap <leader>e :Ex<CR>

      " --- indent guides (indentLine) ---
      let g:indentLine_char = '│'
      let g:indentLine_enabled = 1



      inoremap " ""<left>
      inoremap [ []<left>
      inoremap { {}<left>
      inoremap {<CR> {<CR>}<ESC>O
      inoremap {;<CR> {<CR>};<ESC>O

    '';

  };
}
