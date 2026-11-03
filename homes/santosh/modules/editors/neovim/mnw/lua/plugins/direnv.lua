require("direnv").setup({
  bin = "direnv",
  autoload_direnv = true,
  statusline = {
    enabled = true,
    icon = "envyy",
  },
  keybindings = false,
  notifications = {
    level = vim.log.levels.INFO,
    silent_autoload = true,
  },
})
