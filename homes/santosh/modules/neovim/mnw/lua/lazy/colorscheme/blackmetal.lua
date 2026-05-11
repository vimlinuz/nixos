return {
  "black-metal-theme-neovim",
  colorscheme = "dark-funeral",
  after = function()
    require("black-metal").setup({
      -- If true, docstrings will be highlighted like strings, otherwise they will be
      -- highlighted like comments. Note, behavior is dependent on the language server.
      colored_docstrings = true,
      -- If true, highlights the {sign,fold} column the same as cursorline
      cursorline_gutter = true,
      -- If true, highlights the gutter darker than the bg
      dark_gutter = false,
      show_eob = false,
      -- if true favor treesitter highlights over semantic highlights
      favor_treesitter_hl = true,
      -- Don't set background
      transparent = true,
      -- Don't set background of floating windows. Recommended for when using floating
      -- windows with borders.
      plain_float = false,
      -- If true, enable the vim terminal colors
      term_colors = true,

      -- The following options allow for more control over some plugin appearances.
      plugin = {
        lualine = {
          -- Bold lualine_a sections
          bold = false,
          -- Don't set section/component backgrounds. Recommended to not set
          -- section/component separators.
          plain = false,
        },
        cmp = {
          -- works for nvim.cmp and blink.nvim
          -- Don't highlight lsp-kind items. Only the current selection will be highlighted.
          plain = true,
          -- Reverse lsp-kind items' highlights in blink/cmp menu.
          reverse = false,
        },
      },
    })
    vim.env.BAT_THEME = "dark-funeral"
  end,
}
