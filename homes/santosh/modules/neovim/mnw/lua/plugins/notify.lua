vim.notify = require("notify")
require("notify").setup({
  background_colour = "#000000",
  fps = 60,
  level = vim.log.levels.INFO,
  render = "simple",
  stages = "slide",
})
