require("lspkind").init({
  cmp = { max_width = 10 },
  ellipsis_char = "...",
  maxwidth = 50,
  mode = "symbol_text",
  symbol_map = { Copilot = "" },
})

require("luasnip").config.setup({})
require("lsp-format").setup({})

do
  vim.lsp.inlay_hint.enable(true)
  local __lspCapabilities = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

    -- Capabilities configuration for nvim-ufo
    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    }

    return capabilities
  end

  local __setup = { capabilities = __lspCapabilities() }

  local __wrapConfig = function(cfg)
    if cfg == nil then
      cfg = __setup
    else
      cfg = vim.tbl_extend("keep", cfg, __setup)
    end
    return cfg
  end

  vim.lsp.config("bashls", __wrapConfig({}))
  vim.lsp.enable("bashls")
  vim.lsp.config("clangd", __wrapConfig({}))
  vim.lsp.enable("clangd")
  vim.lsp.config("cssls", __wrapConfig({}))
  vim.lsp.enable("cssls")
  vim.lsp.config("emmet_language_server", __wrapConfig({}))
  vim.lsp.enable("emmet_language_server")
  vim.lsp.config("glslls", __wrapConfig({}))
  vim.lsp.enable("glslls")
  vim.lsp.config("html", __wrapConfig({}))
  vim.lsp.enable("html")
  vim.lsp.config("lua_ls", __wrapConfig({}))
  vim.lsp.enable("lua_ls")
  vim.lsp.config("marksman", __wrapConfig({}))
  vim.lsp.enable("marksman")
  vim.lsp.config("nixd", __wrapConfig({}))
  vim.lsp.enable("nixd")
  vim.lsp.config("nushell", __wrapConfig({}))
  vim.lsp.enable("nushell")
  vim.lsp.config("pylsp", __wrapConfig({}))
  vim.lsp.enable("pylsp")
  vim.lsp.config("rust_analyzer", __wrapConfig({ settings = { ["rust-analyzer"] = { checkOnSave = true } } }))
  vim.lsp.enable("rust_analyzer")
  vim.lsp.config("tailwindcss", __wrapConfig({}))
  vim.lsp.enable("tailwindcss")
  vim.lsp.config(
    "ts_ls",
    __wrapConfig({
      filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
      },
      on_attach = function(client, bufnr)
        if vim.list_contains({ "dockerls", "gopls", "nushell", "rust_analyzer", "pylsp" }, client.name) then
          require("lsp-format").on_attach(client, bufnr)
        end

        client.server_capabilities.documentFormattingProvider = false
      end,
    })
  )
  vim.lsp.enable("ts_ls")
end
