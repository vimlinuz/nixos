require("telescope").setup({
  defaults = {
    layout_config = { prompt_position = "top" },
    sorting_strategy = "ascending",
    prompt_prefix = " > ",
    selection_caret = " > ",
  },
  extensions = {
    fzf = { case_mode = "smart_case", fuzzy = true, override_file_sorter = true, override_generic_sorter = true },
  },
})
local telescope_maps = {
  {
    action = "<cmd>Telescope colorscheme<CR>",
    key = "<leader>sc",
    mode = { "n" },
    options = { desc = "search colorscheme" },
  },
  {
    action = "<cmd>Telescope git_branches<CR>",
    key = "<leader>sb",
    mode = { "n" },
    options = { desc = "search git branches" },
  },
  {
    action = "<cmd>Telescope find_files<CR>",
    key = "<leader>sf",
    mode = { "n" },
    options = { desc = "Search files" },
  },
  {
    action = "<cmd>Telescope current_buffer_fuzzy_find<CR>",
    key = "<leader>/",
    mode = { "n" },
    options = { desc = "[/] Fuzzily search in current buffer" },
  },
  {
    action = function()
      local builtin = require("telescope.builtin")
      builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        winblend = 0,
        previewer = true,
      }))
    end,
    key = "<leader>?",
    mode = { "n" },
    options = { desc = "[?] Fuzzily search in current buffer small window" },
  },
  {
    action = function()
      local builtin = require("telescope.builtin")
      builtin.live_grep({
        grep_open_files = true,
        prompt_title = "Live Grep in Open Files",
      })
    end,
    key = "<leader>s/",
    mode = { "n" },
    options = { desc = "[S]earch [/] in Open Files" },
  },
  {
    action = "<cmd>Telescope help_tags<CR>",
    key = "<leader>sh",
    mode = { "n" },
    options = { desc = "Help_tags" },
  },
  {
    action = "<cmd>Telescope live_grep<CR>",
    key = "<leader>sg",
    mode = { "n" },
    options = { desc = "Search using live grep" },
  },
  {
    action = "<cmd>Telescope buffers<CR>",
    key = "<leader><leader>",
    mode = { "n" },
    options = { desc = "List buffers" },
  },
  { action = "<cmd>Telescope<CR>", key = "<leader>st", mode = { "n" }, options = { desc = " help tags" } },
  {
    action = "<cmd>Telescope lsp_type_definitions<CR>",
    key = "<leader>sd",
    mode = { "n" },
    options = { desc = "Search LSP Definitions" },
  },
  {
    action = "<cmd>Telescope lsp_references<CR>",
    key = "<leader>sr",
    mode = { "n" },
    options = { desc = "Search LSP references" },
  },
  {
    action = "<cmd>Telescope lsp_document_symbols<CR>",
    key = "<leader>ss",
    mode = { "n" },
    options = { desc = "Search document symbols" },
  },
}

for _, map in ipairs(telescope_maps) do
  vim.keymap.set(map.mode, map.key, map.action, map.options)
end
