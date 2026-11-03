return {
  "kanagawa.nvim",
  colorscheme = "kanagawa",
  after = function()
    require("kanagawa").setup({
      commonStyle = { bold = false, italic = true },
      dimInactive = false,
      transparent = false,
      undercurl = true,
    })
    vim.env.BAT_THEME = "kanagawa"
  end,
}
