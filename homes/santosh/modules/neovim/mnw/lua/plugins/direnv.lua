require("direnv").setup({
  bin = "direnv",
  autoload_direnv = true,
  statusline = {
    enabled = true,
    icon = "envyy",
  },

  notifications = {
    level = vim.log.levels.INFO,
    silent_autoload = true,
  },
})
