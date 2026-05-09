require("nvim-web-devicons").setup({})
require("surround-nvim").setup({})
require("nvim-autopairs").setup({})
require("todo-comments").setup({ signs = true })
require("colorizer").setup({})
require("cord").setup({ display = { show_time = true } })
require("cmp_git").setup({})
require("ibl").setup({
  indent = { char = "│" },
  scope = { show_end = false, show_exact_scope = false, show_start = false },
})
