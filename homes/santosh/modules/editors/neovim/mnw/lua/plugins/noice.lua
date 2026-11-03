require("noice").setup({
  cmdline = { enabled = true },
  lsp = {
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },

    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
      inc_rename = false,
      lsp_doc_border = true,
    },

    hover = { enabled = true },
    message = { enabled = true },
    progress = { enabled = false },
    signature = { enabled = false },

    views = {
      cmdline_popup = {
        position = {
          col = "50%",
          row = "85%",
        },
      },
    },
  },
  -- notify = { enabled = false },
})
