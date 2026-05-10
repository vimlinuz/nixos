local cmp = require("cmp")
cmp.setup({
  mapping = {
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-e>"] = cmp.mapping.close(),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-h>"] = cmp.mapping(function(fallback)
      local luasnip = require("luasnip")
      if luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<C-l>"] = cmp.mapping(function(fallback)
      local luasnip = require("luasnip")
      if luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
  },
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  sources = {
    { name = "calc" },
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "luasnip" },
    { name = "nvim_lsp_signature_help" },
    { name = "spell" },
    { name = "async_path" },
    { name = "emoji" },
    { name = "git" },
    { name = "latex_symbols" },
    { name = "nvim_lsp_document_symbols" },
  },
  window = {
    completion = {
      scrollbar = false,
      winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:CurSearch,Search:None",
    },
    documentation = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
      winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:CursorLine,Search:None",
    },
  },
})

cmp.setup.cmdline("/", { mapping = cmp.mapping.preset.cmdline(), sources = { { name = "buffer" } } })

cmp.setup.cmdline(
  ":",
  { mapping = cmp.mapping.preset.cmdline(), sources = { { name = "async_path" }, { name = "cmdline" } } }
)

require("cmp_git").setup({})
