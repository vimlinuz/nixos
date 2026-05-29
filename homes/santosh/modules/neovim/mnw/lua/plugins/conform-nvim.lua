local conform = require("conform")

conform.setup({
  formatters_by_ft = {
    lua = { "stylua" },
    -- Conform will run multiple formatters sequentially
    python = { "isort", "black" },
    -- You can customize some of the format options for the filetype (:help conform.format)
    rust = { "rustfmt" },
    -- Conform will run the first available formatter
    javascript = { "prettierd", "prettier" },
    css = { "prettierd", "prettier" },
    html = { "prettierd", "prettier" },
    json = { "prettierd", "prettier" },
    yaml = { "prettierd", "prettier" },
    markdown = { "prettierd", "prettier" },
    typescript = { "prettierd", "prettier" },
    typescriptreact = { "prettierd", "prettier" },

    bash = { "shfmt" },
    nix = { "nixfmt" },
    c = {},
    cpp = {},
    -- Use the "_" filetype to run formatters on filetypes that don't
    -- have other formatters configured.
    ["_"] = { "trim_whitespace" },
  },
  -- Set this to change the default values when calling conform.format()
  -- This will also affect the default values for format_on_save/format_after_save
  default_format_opts = {
    lsp_format = "fallback",
    stop_after_first = true,
  },
  -- -- If this is set, Conform will run the formatter on save.
  -- -- It will pass the table to conform.format().
  -- -- This can also be a function that returns the table.
  -- format_on_save = {
  --   -- I recommend these options. See :help conform.format for details.
  --   lsp_format = "fallback",
  --   timeout_ms = 500,
  -- },
  -- If this is set, Conform will run the formatter asynchronously after save.
  -- It will pass the table to conform.format().
  -- This can also be a function that returns the table.
  format_after_save = {
    lsp_format = "fallback",
  },
})

conform.formatters.shfmt = {
  append_args = { "-i", "4" },
  -- The base args are { "-filename", "$FILENAME" } so the final args will be
  -- { "-filename", "$FILENAME", "-i", "2" }
}
