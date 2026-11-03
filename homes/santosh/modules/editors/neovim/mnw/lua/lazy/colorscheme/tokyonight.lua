return {
  "tokyonight.nvim",
  colorscheme = "tokyonight",
  after = function()
    require("tokyonight").setup({
      style = "night",
      styles = { floats = "transparent", sidebars = "transparent" },
      transparent = true,
    })
    vim.env.BAT_THEME = "tokyonight"
  end,
}
