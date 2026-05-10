require("vague").setup({
  transparent = false,
  bold = false,
  italic = false,
  -- colors = {
  --     bg = "#191d33",
  -- },
  on_highlights = function(highlights, colors)
    -- GitSigns
    highlights.GitSignsAdd = { fg = "#ffffff", bg = "NONE" }
    highlights.GitSignsChange = { fg = "#aaaaaa", bg = "NONE" }
    highlights.GitSignsDelete = { fg = colors.error, bg = "NONE" }

    -- IndentBlankline
    highlights.IndentBlanklineChar = { fg = "#3b3b3b", nocombine = true }
    highlights.IndentBlanklineContextChar = { fg = colors.plus, nocombine = true }
    highlights.IndentBlanklineSpaceChar = { fg = "#444444", nocombine = true }
  end,

  -- style = {
  --   boolean = "italic",
  --   number = "none",
  --   float = "none",
  --   error = "none",
  --   comments = "italic",
  --   conditionals = "none",
  --   functions = "none",
  --   headings = "bold",
  --   operators = "none",
  --   strings = "none",
  --   variables = "none",
  --   keywords = "none",
  --   keyword_return = "none",
  --   keywords_loop = "none",
  --   keywords_label = "none",
  --   keywords_exception = "none",
  -- },
})
-- vim.cmd('colorscheme dark-funeral')

require("tokyonight").setup({
  style = "night",
  styles = { floats = "transparent", sidebars = "transparent" },
  transparent = true,
})

require("kanagawa").setup({
  commonStyle = { bold = false, italic = true },
  dimInactive = false,
  transparent = false,
  undercurl = true,
})

require("palette").setup({ bolds = false, italics = true, transparent_background = true })

require("rose-pine").setup({
  disable_background = true,
  disable_float_background = true,
  flavor = "main",
  show_end_of_buffer = false,
  styles = { bold = false, italic = false, transparency = true },
})

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

require("catppuccin").setup({
  color_overrides = { all = { base = "#191d33" } },
  flavor = "mocha",
  float = { solid = false, transparent = true },
  no_bold = true,
  no_italic = false,
  no_underline = false,
  show_end_of_buffer = false,
  transparent_background = true,
})

vim.cmd([[let $BAT_THEME = 'vague'
colorscheme vague
]])
