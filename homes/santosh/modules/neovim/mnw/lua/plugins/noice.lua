require("noice").setup({
  cmdline = { enabled = true },
  lsp = {
    hover = { enabled = true },
    message = { enabled = true },
    progress = { enabled = false },
    signature = { enabled = false },
  },
  notify = { enabled = false },
})
