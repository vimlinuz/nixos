do
  local nixvim_globals = { mapleader = " ", maplocalleader = " " }

  for k, v in pairs(nixvim_globals) do
    vim.g[k] = v
  end
end

do
  local misc_maps = {

    {
      action = "<cmd>UndotreeToggle<CR>",
      key = "<leader>u",
      mode = { "n" },
      options = { desc = "Toggle undo tree" },
    },
  }

  for k, v in pairs(misc_maps) do
    vim.g[k] = v
  end
end

vim.keymap.set("n", "<leader>o", "<CMD>Oil<CR>", { desc = "Open oil" })
