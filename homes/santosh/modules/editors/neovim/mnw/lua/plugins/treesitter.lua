-- Detect nvim-treesitter API
local has_configs_module = pcall(require, "nvim-treesitter.configs")

if has_configs_module then
  require("nvim-treesitter.configs").setup({
    highlight = { enable = true },
    indent = { enable = true },
    textobjects = {
      select = {
        enable = true,
        includeSurroundingWhitespace = true,
        keymaps = {
          aa = "@parameter.outer",
          ac = "@class.outer",
          af = "@function.outer",
          al = "@loop.outer",
          as = { desc = "Select language scope", query = "@local.scope", queryGroup = "locals" },
          ia = "@parameter.inner",
          ic = { desc = "Select inner class", query = "@class.inner" },
          ["if"] = "@function.inner",
          il = "@loop.inner",
        },
        lookahead = true,
        selectionModes = { ["@class.outer"] = "<c-v>", ["@function.outer"] = "V", ["@parameter.outer"] = "v" },
      },
    },
  })
else
  require("nvim-treesitter").setup({
    highlight = { enable = true },
    indent = { enable = true },
    textobjects = {
      select = {
        enable = true,
        includeSurroundingWhitespace = true,
        keymaps = {
          aa = "@parameter.outer",
          ac = "@class.outer",
          af = "@function.outer",
          al = "@loop.outer",
          as = { desc = "Select language scope", query = "@local.scope", queryGroup = "locals" },
          ia = "@parameter.inner",
          ic = { desc = "Select inner class", query = "@class.inner" },
          ["if"] = "@function.inner",
          il = "@loop.inner",
        },
        lookahead = true,
        selectionModes = { ["@class.outer"] = "<c-v>", ["@function.outer"] = "V", ["@parameter.outer"] = "v" },
      },
    },
  })

  -- Enable features via autocommands for modern nvim-treesitter
  local disabled_highlight = {}

  vim.api.nvim_create_autocmd("FileType", {
    group = augroup,
    pattern = "*",
    callback = function(args)
      local filetype = vim.bo[args.buf].filetype
      local lang = vim.treesitter.language.get_lang(filetype) or filetype
      local start_highlight = true

      for _, disabled in ipairs(disabled_highlight) do
        if disabled == lang or disabled == filetype then
          start_highlight = false
          break
        end
      end

      if start_highlight then
        pcall(vim.treesitter.start, args.buf, lang)
      end
      vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
  })
end

require("treesitter-context").setup({
  enable = true,
  line_numbers = true,
  max_lines = 3,
  min_window_height = 0,
  mode = "cursor",
  multiline_threshold = 20,
  trim_scope = "outer",
  zindex = 90,
})
