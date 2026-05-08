do
  local nixvim_globals = { mapleader = " ", maplocalleader = " " }

  for k, v in pairs(nixvim_globals) do
    vim.g[k] = v
  end
end
vim.keymap.set("n", "<leader>o", "<CMD>Oil<CR>", { desc = "Open oil" })
