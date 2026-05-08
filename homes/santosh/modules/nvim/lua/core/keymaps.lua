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

do
  local junk_maps = {
    { action = "<cmd>cnext<CR>zz", key = "]q", mode = { "n" }, options = { desc = "Go to next quickfix item" } },
    {
      action = "<cmd>cprev<CR>zz",
      key = "[q",
      mode = { "n" },
      options = { desc = "Go to previous quickfix item" },
    },
    {
      action = "<cmd>lnext<CR>zz",
      key = "]Q",
      mode = { "n" },
      options = { desc = "Go to next location list item" },
    },
    {
      action = "<cmd>lprev<CR>zz",
      key = "[Q",
      mode = { "n" },
      options = { desc = "Go to previous location list item" },
    },
    {
      action = "<CMD>NoiceDismiss<CR>",
      key = "<leader>nd",
      mode = { "n" },
      options = { desc = "Dismiss all Noice notifications" },
    },
    {
      action = "<CMD>CopilotChatReset<CR>",
      key = "<leader>cR",
      mode = { "n" },
      options = { desc = "Reset Copilot Chat" },
    },
    {
      action = "<CMD>CopilotChatToggle<CR>",
      key = "<leader>ct",
      mode = { "n", "v" },
      options = { desc = "Toggle Copilot Chat Window" },
    },
    {
      action = "<CMD>CopilotChatStop<CR>",
      key = "<leader>cs",
      mode = { "n", "v" },
      options = { desc = "Stop current Copilot output" },
    },
    {
      action = "<CMD>CopilotChatReview<CR>",
      key = "<leader>cr",
      mode = { "v" },
      options = { desc = "Review the selected code" },
    },
    {
      action = "<CMD>CopilotChatExplain<CR>",
      key = "<leader>ce",
      mode = { "v" },
      options = { desc = "Give an explanation for the selected code" },
    },
    {
      action = "<CMD>CopilotChatDocs<CR>",
      key = "<leader>cd",
      mode = { "v" },
      options = { desc = "Add documentation for the selection" },
    },
    {
      action = "<CMD>CopilotChatTests<CR>",
      key = "<leader>cp",
      mode = { "v" },
      options = { desc = "Add tests for my code" },
    },
    {
      action = "<cmd>Terminal code-runner<CR>",
      key = "<leader>t",
      mode = { "n" },
      options = { desc = "Run the code-runner script", noremap = true, silent = true },
    },
    {
      action = "<cmd>Terminal opencode .<CR>",
      key = "<leader>ao",
      mode = { "n" },
      options = { desc = "Open code", noremap = true, silent = true },
    },
    { action = '"_dP', key = "p", mode = { "v" }, options = { noremap = true, silent = true } },
    {
      action = ">gv",
      key = "<C-l>",
      mode = { "v" },
      options = { desc = "> without loosing indent mode", noremap = true, silent = true },
    },
    {
      action = "<gv",
      key = "<C-h>",
      mode = { "v" },
      options = { desc = "< without loosing indent mode", noremap = true, silent = true },
    },
    {
      action = ":m '>+1<CR>gv",
      key = "<C-j>",
      mode = { "v" },
      options = { desc = "Move selected line down", noremap = true, silent = true },
    },
    {
      action = ":m '<-2<CR>gv",
      key = "<C-k>",
      mode = { "v" },
      options = { desc = "Move selected line up", noremap = true, silent = true },
    },
    {
      action = "<cmd>set wrap!<CR>",
      key = "<leader>lw",
      mode = { "n" },
      options = { desc = "Toggle line wrapping", noremap = true, silent = true },
    },
    {
      action = "nzzzv",
      key = "n",
      mode = { "n" },
      options = { desc = "Find n with cursor in center", noremap = true, silent = true },
    },
    {
      action = "nzzzv",
      key = "N",
      mode = { "n" },
      options = { desc = "Find N with cursor in center", noremap = true, silent = true },
    },
    {
      action = "mzJ`z",
      key = "J",
      mode = { "n" },
      options = { desc = "Join line with out moving cursor", noremap = true, silent = true },
    },
    {
      action = "<cmd>resize +2<CR>",
      key = "<Up>",
      mode = { "n" },
      options = { desc = "Horizontal resize +2", noremap = true, silent = true },
    },
    {
      action = "<cmd>resize -2<CR>",
      key = "<Down>",
      mode = { "n" },
      options = { desc = "Horizontal resize -2", noremap = true, silent = true },
    },
    {
      action = "<cmd>vertical resize -2<CR>",
      key = "<Left>",
      mode = { "n" },
      options = { desc = "Vertical resize -2", noremap = true, silent = true },
    },
    {
      action = "<cmd>vertical resize +2<CR>",
      key = "<Right>",
      mode = { "n" },
      options = { desc = "Vertical resize +2", noremap = true, silent = true },
    },
    {
      action = "<C-u>zz",
      key = "<C-u>",
      mode = { "n" },
      options = { desc = "<C-u> with with cursor in center", silent = true },
    },
    {
      action = "<C-d>zz",
      key = "<C-d>",
      mode = { "n" },
      options = { desc = "<C-d> with with cursor in center", silent = true },
    },
    {
      action = "<cmd>noautocmd w<CR>",
      key = "<leader>sn",
      mode = { "n" },
      options = { desc = "save file without auto-formatting", noremap = true, silent = true },
    },
    {
      action = '"_x',
      key = "x",
      mode = { "n" },
      options = { desc = "Delete single character with out copying into register", noremap = true, silent = true },
    },
    {
      action = require("treesitter-context").go_to_context,
      key = "[c",
      mode = { "n" },
      options = { desc = "Go to context", silent = true },
    },
    {
      action = "<cmd>vsplit<CR>",
      key = "<leader>v",
      mode = { "n" },
      options = { desc = "Split window vertically", silent = true },
    },
    {
      action = "<cmd>split<CR>",
      key = "<leader>o",
      mode = { "n" },
      options = { desc = "Split window vertically", silent = true },
    },
    {
      action = "<cmd>close<CR>",
      key = "<leader>q",
      mode = { "n" },
      options = { desc = "Close current split", silent = true },
    },
    {
      action = "<cmd>only<CR>",
      key = "<leader>x",
      mode = { "n" },
      options = { desc = "Close all other splits", silent = true },
    },
    {
      action = function()
        if vim.bo.filetype == "oil" then
          vim.cmd("bdelete")
        else
          vim.cmd("Oil")
        end
      end,
      key = "<leader>e",
      mode = { "n" },
      options = { desc = "toggle oil", noremap = true, silent = true },
    },
    {
      action = "<cmd>Lspsaga peek_definition<CR>",
      key = "<leader>cd",
      mode = { "n" },
      options = { desc = "Code Definition" },
    },
    {
      action = "<cmd>Lspsaga incoming_calls<CR>",
      key = "<leader>ci",
      mode = { "n" },
      options = { desc = "Code Incoming Calls" },
    },
    {
      action = "<cmd>Lspsaga outgoing_calls<CR>",
      key = "<leader>co",
      mode = { "n" },
      options = { desc = "Code Outgoing Calls" },
    },
    {
      action = "<cmd>Lspsaga outline<CR>",
      key = "<leader>cs",
      mode = { "n" },
      options = { desc = "Code Symbols Outline" },
    },
  }
  for _, map in ipairs(junk_maps) do
    vim.keymap.set(map.mode, map.key, map.action, map.options)
  end
end
