return {
  "palette.nvim",
  colorscheme = "palette",
  after = function()
    require("palette").setup({ bolds = false, italics = true, transparent_background = true })
    vim.env.BAT_THEME = "palette"
  end,
}
