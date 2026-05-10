-- Adapted from NobbZ's Neovim(NobbZvim) config:
-- https://github.com/NobbZ/nobbz-vim/blob/main/plugins/nobbz/lua/nobbz/plugins/blink.lua
local blink = require("blink-cmp")
local luasnip = require("luasnip")

local function is_hidden_snippet()
  local ls = require("luasnip")
  return not require("blink.cmp").is_visible() and not ls.in_snippet() and ls.expandable()
end

blink.setup({
  snippets = {
    preset = "luasnip",
    active = function()
      if luasnip.in_snippet() and not blink.is_visible() then
        return true
      else
        if not luasnip.in_snippet() and vim.fn.mode() == "n" then
          luasnip.unlink_current()
        end
        return false
      end
    end,
    expand = function(snippet)
      luasnip.lsp_expand(snippet)
    end,
    jump = function(direction)
      if is_hidden_snippet() then
        return luasnip.expand_or_jump()
      end
      return luasnip.jumpable(direction) and luasnip.jump(direction)
    end,
  },

  cmdline = { enabled = true },
  sources = {
    default = { "lsp", "path", "snippets", "buffer", "omni" },
  },
  signature = {
    enabled = true,
    window = { border = "single" },
  },
  completion = {
    menu = {
      scrollbar = false,
      auto_show = function(ctx)
        return ctx ~= "cmdline"
      end,
      winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:CurSearch,Search:None",
      border = "single",
      draw = {
        treesitter = { "lsp" },
        columns = { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "source_name" } },
      },
    },
    ghost_text = { enabled = true },
    list = {
      selection = {
        preselect = true,
        auto_insert = false,
      },
    },
    documentation = {
      auto_show = true,
      scrollbar = false,
      window = {
        border = "single",
        winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:CursorLine,Search:None",
      },
      auto_show_delay_ms = 500,
    },
  },
  keymap = {
    ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
    ["<C-y>"] = { "accept", "fallback" },
    ["<C-d>"] = { "scroll_documentation_down", "fallback" },
    ["<C-f>"] = { "scroll_documentation_up", "fallback" },
    ["<C-n>"] = { "select_next", "fallback" },
    ["<C-p>"] = { "select_prev", "fallback" },
    ["<C-e>"] = { "hide", "fallback" },
    ["<C-l>"] = { "snippet_forward", "fallback" },
    ["<C-h>"] = { "snippet_backward", "fallback" },
    ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
  },
})
