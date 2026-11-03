require("oil").setup({
  default_file_explorer = true,
  delete_to_trash = true,
  columns = {
    "icon",
    "permissions",
    "size",
    "mtime",
  },
  keymaps = {
    ["<C-h>"] = false,
    ["<C-l>"] = false,
    ["<C-p>"] = false,
    ["<C-r>"] = "actions.refresh",
    ["<C-v>"] = "actions.select_vsplit",
  },
  skip_confirm_for_simple_edits = true,
  use_default_keymaps = true,
  view_options = { natural_order = true, show_hidden = true },
  watch_for_changes = true,
  win_options = { wrap = true },
})

vim.keymap.set("n", "<leader>e", function()
  if vim.bo.filetype == "oil" then
    vim.cmd("bdelete")
  else
    vim.cmd("Oil")
  end
end, { desc = "toggle oil", noremap = true, silent = true })
