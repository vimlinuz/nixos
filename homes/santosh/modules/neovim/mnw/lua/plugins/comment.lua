require("Comment").setup({ mappings = { basic = false, extra = false }, padding = true, sticky = true })

local comment_maps = {
  {
    action = require("Comment.api").toggle.linewise.current,
    key = "<C-_>",
    mode = "n",
    options = { desc = "Toggle line wise comment in normal mode", noremap = true, silent = true },
  },
  {
    action = require("Comment.api").toggle.linewise.current,
    key = "<C-c>",
    mode = "n",
    options = { desc = "Toggle line wise comment in normal mode", noremap = true, silent = true },
  },
  {
    action = require("Comment.api").toggle.linewise.current,
    key = "<C-/>",
    mode = "n",
    options = { desc = "Toggle line wise comment in normal mode", noremap = true, silent = true },
  },
  {
    action = "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
    key = "<C-_>",
    mode = "v",
    options = { desc = "Toggle line wise comment in visual mode", noremap = true, silent = true },
  },
  {
    action = "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
    key = "<C-c>",
    mode = "v",
    options = { desc = "Toggle line wise comment in visual mode", noremap = true, silent = true },
  },
  {
    action = "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
    key = "<C-/>",
    mode = "v",
    options = { desc = "Toggle line wise comment in visual mode", noremap = true, silent = true },
  },
}

for _, map in ipairs(comment_maps) do
  vim.keymap.set(map.mode, map.key, map.action, map.options)
end
