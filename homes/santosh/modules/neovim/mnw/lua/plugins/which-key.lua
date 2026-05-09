require("which-key").setup({
  notify = true,
  plugins = { marks = true, registers = true },
  preset = "helix",
  win = { wo = { winblend = 0 }, zindex = 1000 },
})
