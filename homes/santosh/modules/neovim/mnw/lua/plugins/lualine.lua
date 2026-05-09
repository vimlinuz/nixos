require("lualine").setup({
  extensions = { "fugitive" },
  inactive_sections = { lualine_c = { { "filename", path = 1 } }, lualine_x = { { "location", padding = 0 } } },
  options = {
    always_divide_middle = true,
    component_separators = { left = " ", right = " " },
    disabled_filetypes = { statusline = { "alpha", "neo-tree" } },
    icons_enabled = true,
    section_separators = { left = "", right = "" },
    theme = "auto",
  },
  sections = {
    lualine_a = {
      function()
        return "󰫍"
      end,
    },
    lualine_b = { "branch" },
    lualine_c = { { "filename", file_status = true, path = 0 } },
    lualine_x = {
      {
        "diagnostics",
        always_visible = false,
        colored = false,
        cond = function()
          return vim.fn.winwidth(0) > 100
        end,
        sections = { "error", "warn" },
        sources = { "nvim_diagnostic" },
        symbols = { error = " ", hint = "", info = " ", warn = " " },
        update_in_insert = false,
      },
      {
        "diff",
        colored = false,
        cond = function()
          return vim.fn.winwidth(0) > 100
        end,
        symbols = { added = " ", modified = " ", removed = " " },
      },
      {
        "encoding",
        cond = function()
          return vim.fn.winwidth(0) > 100
        end,
      },
      {
        "filetype",
        cond = function()
          return vim.fn.winwidth(0) > 100
        end,
      },
    },
    lualine_y = { "location", "progress" },
    lualine_z = {
      function()
        return " "
      end,
    },
  },
})
