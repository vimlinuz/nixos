{
  pkgs,
  ...
}:
let
  optimizedTreesitter = pkgs.symlinkJoin {
    name = "nvim-treesitter-optimized";
    paths = [
      pkgs.vimPlugins.nvim-treesitter.withAllGrammars
      pkgs.vimPlugins.nvim-treesitter.withAllGrammars.dependencies
    ];
  };
in
{
  programs.mnw = {
    enable = true;
    desktopEntry = true;
    initLua = ''
      require("init")
      local lzn = require("lz.n")
      lzn.load('lazy')
      lzn.load('lazy.colorscheme')
    '';

    extraBinPath = [
      pkgs.bash-language-server
      pkgs.clang-tools
      pkgs.emmet-language-server
      pkgs.glslls
      pkgs.lua-language-server
      pkgs.marksman
      pkgs.nixd
      pkgs.nushell
      pkgs.tailwindcss-language-server
      pkgs.typescript
      pkgs.typescript-language-server
      pkgs.vscode-langservers-extracted
      pkgs.rust-analyzer
      pkgs.nixfmt
      pkgs.stylua
      pkgs.prettier
    ];

    plugins = {
      start = [
        pkgs.vimPlugins.lz-n
        pkgs.vimPlugins.alpha-nvim
        pkgs.vimPlugins.comment-nvim
        pkgs.vimPlugins.harpoon2
        pkgs.vimPlugins.which-key-nvim
        pkgs.vimPlugins.vim-tpipeline
        pkgs.vimPlugins.lualine-nvim
        pkgs.vimPlugins.nvim-surround
        pkgs.vimPlugins.markdown-preview-nvim
        pkgs.vimPlugins.undotree
        pkgs.vimPlugins.nvim-autopairs
        pkgs.vimPlugins.todo-comments-nvim
        pkgs.vimPlugins.nvim-colorizer-lua
        pkgs.vimPlugins.cord-nvim
        pkgs.vimPlugins.nvim-web-devicons
        pkgs.vimPlugins.nvim-ufo

        # pkgs.vimPlugins.nvim-notify
        # pkgs.vimPlugins.noice-nvim

        pkgs.vimPlugins.vim-fugitive
        pkgs.vimPlugins.gitsigns-nvim
        pkgs.vimPlugins.vim-rhubarb

        pkgs.vimPlugins.indent-blankline-nvim
        pkgs.vimPlugins.oil-nvim

        pkgs.vimPlugins.catppuccin-nvim
        pkgs.vimPlugins.tokyonight-nvim
        pkgs.vimPlugins.kanagawa-nvim
        pkgs.vimPlugins.palette-nvim
        pkgs.vimPlugins.rose-pine
        pkgs.vimPlugins.falcon
        pkgs.vimPlugins.kanso-nvim
        pkgs.vimPlugins.vague-nvim
        pkgs.vimPlugins.black-metal-theme-neovim

        pkgs.vimPlugins.CopilotChat-nvim
        pkgs.vimPlugins.copilot-lua
        pkgs.vimPlugins.copilot-cmp

        pkgs.vimPlugins.lspsaga-nvim
        pkgs.vimPlugins.lspkind-nvim
        pkgs.vimPlugins.nvim-lspconfig
        pkgs.vimPlugins.none-ls-nvim

        pkgs.vimPlugins.luasnip
        pkgs.vimPlugins.lsp-format-nvim

        pkgs.vimPlugins.blink-cmp
        pkgs.vimPlugins.blink-cmp-git
        pkgs.vimPlugins.blink-cmp-spell
        pkgs.vimPlugins.blink-emoji-nvim
        pkgs.vimPlugins.blink-cmp-copilot
        pkgs.vimPlugins.blink-cmp-env
        pkgs.vimPlugins.blink-cmp-conventional-commits
        pkgs.vimPlugins.blink-cmp-dictionary

        # pkgs.vimPlugins.nvim-cmp
        # pkgs.vimPlugins.cmp-calc
        # pkgs.vimPlugins.cmp-buffer
        # pkgs.vimPlugins.cmp-cmdline
        # pkgs.vimPlugins.cmp-dotenv
        # pkgs.vimPlugins.cmp-nvim-lsp
        # pkgs.vimPlugins.cmp-async-path
        # pkgs.vimPlugins.cmp-conventionalcommits
        # pkgs.vimPlugins.cmp-emoji
        # pkgs.vimPlugins.cmp-git

        optimizedTreesitter
        # pkgs.vimPlugins.nvim-treesitter
        pkgs.vimPlugins.nvim-treesitter-context
        pkgs.vimPlugins.nvim-treesitter-textobjects

        pkgs.vimPlugins.vim-tmux-navigator
        pkgs.vimPlugins.telescope-nvim
        pkgs.vimPlugins.telescope-fzf-native-nvim
      ];

      # Anything that you're loading lazily should be put here
      opt = [
        pkgs.vimPlugins.bigfile-nvim
      ];

      dev.myconfig = {
        pure = ./.;
        impure = toString ./.;
      };
    };
  };
}
