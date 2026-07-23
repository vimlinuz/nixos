require("nvim-web-devicons").setup({})
require("nvim-autopairs").setup({
  disable_filetype = { "TelescopePrompt", "vim" },
})
require("nvim-surround").setup({})
require("todo-comments").setup({ signs = true })
require("colorizer").setup({})
require("cord").setup({ display = { show_time = true } })

require("ibl").setup({
  indent = { char = "│" },
  scope = { show_end = false, show_exact_scope = false, show_start = false },
})

require("present").setup({})

require("fidget").setup({})
