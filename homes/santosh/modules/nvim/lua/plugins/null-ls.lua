require("null-ls").setup({
  on_attach = require("lsp-format").on_attach,
  sources = {
    require("null-ls").builtins.formatting.clang_format,
    require("null-ls").builtins.formatting.nixfmt,
    require("null-ls").builtins.formatting.prettier.with({
      filetypes = { "css", "html", "json", "yaml", "markdown", "javascript", "typescript", "typescriptreact" },
    }),
    require("null-ls").builtins.formatting.shfmt.with({ extra_args = { "-i", "4" } }),
    require("null-ls").builtins.formatting.stylua,
  },
})
