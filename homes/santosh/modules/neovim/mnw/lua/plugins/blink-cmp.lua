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

    default = {
      "lsp",
      "path",
      "snippets",
      "copilot",
      "git",
      "conventional_commits",
      "spell",
      "buffer",
      -- "omni",
      "emoji",
      "env",
      "dictionary",
      dictionary = {
        module = "blink-cmp-dictionary",
        name = "Dict",
        min_keyword_length = 1,
        opts = {
          -- Optional: explicitly force fallback mode
          -- (By default, fallback is used when fzf is not found)
          force_fallback = true,
        },
      },
    },

    providers = {
      conventional_commits = {
        name = "Conventional Commits",
        module = "blink-cmp-conventional-commits",
        enabled = function()
          return vim.bo.filetype == "gitcommit"
        end,
        ---@module 'blink-cmp-conventional-commits'
        ---@type blink-cmp-conventional-commits.Options
        opts = {
          ---[for custom commits](https://github.com/disrupted/blink-cmp-conventional-commits#using-only-custom-types)
          scopes = false,
        },
      },

      git = {
        module = "blink-cmp-git",
        name = "Git",
        -- only enable this source when filetype is gitcommit, markdown, or 'octo'
        enabled = function()
          return vim.tbl_contains({ "octo", "gitcommit", "markdown" }, vim.bo.filetype)
        end,
      },

      spell = {
        name = "Spell",
        module = "blink-cmp-spell",
        opts = {
          -- EXAMPLE: Only enable source in `@spell` captures, and disable it
          -- in `@nospell` captures.
          enable_in_context = function()
            local curpos = vim.api.nvim_win_get_cursor(0)
            local captures = vim.treesitter.get_captures_at_pos(0, curpos[1] - 1, curpos[2] - 1)
            local in_spell_capture = false
            for _, cap in ipairs(captures) do
              if cap.capture == "spell" then
                in_spell_capture = true
              elseif cap.capture == "nospell" then
                return false
              end
            end
            return in_spell_capture
          end,
        },
      },
      emoji = {
        module = "blink-emoji",
        name = "Emoji",
        score_offset = 15, -- Tune by preference
        opts = {
          insert = true, -- Insert emoji (default) or complete its name
          ---@type string|table|fun():table
          trigger = function()
            return { ":" }
          end,
        },
        should_show_items = function()
          return vim.tbl_contains(
            -- Enable emoji completion only for git commits and markdown.
            -- By default, enabled for all file-types.
            { "gitcommit", "markdown" },
            vim.o.filetype
          )
        end,
      },

      copilot = {
        name = "copilot",
        module = "blink-cmp-copilot",
        score_offset = 100,
        async = true,
      },
      env = {
        name = "Env",
        module = "blink-cmp-env",
        --- @type blink-cmp-env.Options
        opts = {
          item_kind = require("blink.cmp.types").CompletionItemKind.Variable,
          show_braces = false,
          show_documentation_window = true,
        },
      },
      dictionary = {
        module = "blink-cmp-dictionary",
        name = "Dict",
        min_keyword_length = 1,
        opts = {
          -- Optional: explicitly force fallback mode
          -- (By default, fallback is used when fzf is not found)
          force_fallback = true,
        },
      },
    },
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
      window = {
        scrollbar = false,
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
