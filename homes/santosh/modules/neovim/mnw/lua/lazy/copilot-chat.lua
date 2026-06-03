return {
  {
    "CopilotChat.nvim",
    keys = {
      { "<leader>ct", "<CMD>CopilotChatToggle<CR>", desc = "Toggle Copilot Chat Window" },
    },
    after = function()
      require("CopilotChat").setup({
        auto_fold = true,
        auto_follow_cursor = true,
        headers = { assistant = "## Ai ", tool = "## Tool ", user = "## vimlinuz " },
        highlight_selection = false,
        model = "claude-haiku-4.5",
        show_help = false,
        window = { border = "none", height = 1, layout = "float", title = "─", width = 1 },
      })

      local copilotChatMaps = {
        {
          action = "<CMD>CopilotChatReset<CR>",
          key = "<leader>cR",
          mode = { "n" },
          options = { desc = "Reset Copilot Chat" },
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
      }

      for _, map in ipairs(copilotChatMaps) do
        vim.keymap.set(map.mode, map.key, map.action, map.options)
      end
    end,
  },
}
