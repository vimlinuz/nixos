return {
  "avante.nvim",

  keys = {
    { "<leader>aa", "<CMD>AvanteAsk<CR>", desc = "AvanteAsk" },
  },
  after = function()
    require("avante").setup({
      behaviour = {
        auto_suggestions = false,
      },
    })
  end,
}
