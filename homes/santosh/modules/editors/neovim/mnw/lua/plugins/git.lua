do
  local git_maps = {

    {
      action = "<cmd>diffget //2<CR>",
      key = "gh",
      mode = { "n", "v" },
      options = { desc = "Git Hunks: get left side of diff", noremap = true, silent = true },
    },
    {
      action = "<cmd>diffget //3<CR>",
      key = "gl",
      mode = { "n", "v" },
      options = { desc = "Git Hunks: get right side of diff", noremap = true, silent = true },
    },
    {
      action = "<cmd>GBrowse<CR>",
      key = "<leader>go",
      mode = { "n" },
      options = { desc = "Git Browse", noremap = true, silent = true },
    },
    {
      action = "<cmd>Git<CR>",
      key = "<leader>gs",
      mode = { "n" },
      options = { desc = "Git Status", noremap = true, silent = true },
    },
    {
      action = "<cmd>Git commit<CR>",
      key = "<leader>gc",
      mode = { "n" },
      options = { desc = "Git Commit", noremap = true, silent = true },
    },
    {
      action = "<cmd>Git add .<CR>",
      key = "<leader>ga",
      mode = { "n" },
      options = { desc = "Git Add All changes", noremap = true, silent = true },
    },
    {
      action = "<cmd>Gwrite<CR>",
      key = "<leader>gw",
      mode = { "n" },
      options = { desc = "Git Write", noremap = true, silent = true },
    },
    {
      action = "<cmd>Gvdiffsplit!<CR>",
      key = "<leader>gd",
      mode = { "n" },
      options = { desc = "Git Diff", noremap = true, silent = true },
    },
    {
      action = "<cmd>Gclog<CR>",
      key = "<leader>gl",
      mode = { "n" },
      options = { desc = "Git Log", noremap = true, silent = true },
    },
    {
      action = "<cmd>Git blame<CR>",
      key = "<leader>gb",
      mode = { "n" },
      options = { desc = "Git Blame", noremap = true, silent = true },
    },
    {
      action = "<cmd>Git push<CR>",
      key = "<leader>gp",
      mode = { "n" },
      options = { desc = "Git Push", noremap = true, silent = true },
    },
    {
      action = "<cmd>Git fetch<CR>",
      key = "<leader>gf",
      mode = { "n" },
      options = { desc = "git Fetch", noremap = true, silent = true },
    },
    {
      action = "<cmd>Gread<CR>",
      key = "<leader>gr",
      mode = { "n" },
      options = { desc = "Git: restore buffer to HEAD", noremap = true, silent = true },
    },
  }

  for _, map in ipairs(git_maps) do
    vim.keymap.set(map.mode, map.key, map.action, map.options)
  end
end

require("gitsigns").setup({
  signs = {
    add = { text = "│" },
    change = { text = "│" },
    changedelete = { text = "~" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    untracked = { text = "┆" },
  },
  signs_staged = {
    add = { text = "│" },
    change = { text = "│" },
    changedelete = { text = "~" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    untracked = { text = "┆" },
  },
})
