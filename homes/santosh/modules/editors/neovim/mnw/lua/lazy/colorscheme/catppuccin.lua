return {
  "nvim",
  colorscheme = "catppuccin-mocha",
  after = function()
    require("catppuccin").setup({
      -- color_overrides = { all = { base = "#191d33" } },
      flavor = "mocha",
      float = { solid = false, transparent = false },
      no_bold = true,
      no_italic = false,
      no_underline = false,
      show_end_of_buffer = false,
      transparent_background = false,
    })
    vim.env.BAT_THEME = "catppuccin-mocha"
  end,
}
