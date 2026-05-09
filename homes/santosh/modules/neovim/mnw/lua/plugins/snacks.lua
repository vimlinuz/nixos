require("snacks").setup({
  bigfile = { enabled = true, notify = true, size = 1.5 * 1024 * 1024 },
  notifier = { enabled = false, style = "fancy" },
  quickfile = { enabled = true },
  statuscolumn = { enabled = false },
})
