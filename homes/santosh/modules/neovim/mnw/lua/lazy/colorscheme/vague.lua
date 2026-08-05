return {
  "vague.nvim",
  colorscheme = "vague",
  after = function()
    require("vague").setup({
      transparent = true,
      bold = false,
      italic = false,
      -- colors = {
      --   bg = "#191d33",
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
    vim.env.BAT_THEME = "vague"
  end,
}
