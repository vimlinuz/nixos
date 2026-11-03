return {
  "neovim",
  colorscheme = "rose-pine",
  after = function()
    require("rose-pine").setup({
      disable_background = true,
      disable_float_background = true,
      flavor = "main",
      show_end_of_buffer = false,
      styles = { bold = false, italic = false, transparency = false },
    })
    vim.env.BAT_THEME = "rose-pine"
  end,
}
