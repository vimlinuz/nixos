do
  local __nixvim_autogroups = {
    nixvim_binds_LspAttach = { clear = true },
    nixvim_lsp_binds = { clear = false },
    nixvim_lsp_on_attach = { clear = false },
  }

  for group_name, options in pairs(__nixvim_autogroups) do
    vim.api.nvim_create_augroup(group_name, options)
  end
end

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

local __telescopeExtensions = { "fzf", "harpoon" }
for _, extension in ipairs(__telescopeExtensions) do
  require("telescope").load_extension(extension)
end

do
  local __nixvim_autocommands = {
    {
      callback = function(event)
        do
          -- client and bufnr are supplied to the builtin `on_attach` callback,
          -- so make them available in scope for our global `onAttach` impl
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          local bufnr = event.buf
          if vim.list_contains({ "dockerls", "gopls", "nushell", "rust_analyzer", "pylsp" }, client.name) then
            require("lsp-format").on_attach(client, bufnr)
          end
        end
      end,
      desc = "Run LSP onAttach",
      event = "LspAttach",
      group = "nixvim_lsp_on_attach",
    },
    {
      callback = function(args)
        local __keymaps = {
          {
            action = vim.lsp.buf["definition"],
            key = "gd",
            mode = "",
            options = {
              desc = "Go to defination",
            },
          },
          {
            action = vim.lsp.buf["references"],
            key = "gD",
            mode = "",
            options = {
              desc = "References",
            },
          },
          {
            action = vim.lsp.buf["type_definition"],
            key = "gt",
            mode = "",
            options = {
              desc = "Type defination",
            },
          },
          {
            action = vim.lsp.buf["implementation"],
            key = "gi",
            mode = "",
            options = {
              desc = "Got to implementation",
            },
          },
          {
            action = "<CMD>Lspsaga hover_doc<Enter>",
            key = "K",
            mode = "",
            options = {
              desc = "Hover docs",
            },
          },
          {
            action = "<CMD>Lspsaga rename<Enter>",
            key = "<leader>rn",
            mode = "",
            options = {
              desc = "Rename the variable",
            },
          },
          {
            action = "<CMD>Lspsaga code_action<Enter>",
            key = "<leader>ca",
            mode = "",
            options = {
              desc = "Code action",
            },
          },
          {
            action = "<CMD>Lspsaga diagnostic_jump_next<Enter>",
            key = "]d",
            mode = "",
            options = {
              desc = "Jump to next diagnostic ",
            },
          },
          {
            action = "<CMD>Lspsaga diagnostic_jump_prev<Enter>",
            key = "[d",
            mode = "",
            options = {
              desc = "Jump to previous diagnostic ",
            },
          },
        }

        for _, keymap in ipairs(__keymaps) do
          local options = vim.tbl_extend("keep", keymap.options or {}, { buffer = args.buf })
          vim.keymap.set(keymap.mode, keymap.key, keymap.action, options)
        end
      end,
      desc = "Load LSP keymaps",
      event = "LspAttach",
      group = "nixvim_lsp_binds",
    },
    {
      callback = function(args)
        do
          local __nixvim_binds = {}

          for i, map in ipairs(__nixvim_binds) do
            local options = vim.tbl_extend("keep", map.options or {}, { buffer = args.buf })
            vim.keymap.set(map.mode, map.key, map.action, options)
          end
        end
      end,
      desc = "Load keymaps for LspAttach",
      event = "LspAttach",
      group = "nixvim_binds_LspAttach",
    },
    { command = "lua vim.highlight.on_yank{timeout=50}", event = "TextYankPost", pattern = "*" },
    {
      command = "lua\n        if vim.env.TMUX then\n          vim.opt.laststatus = 0\n        end\n          ",
      event = { "WinResized" },
      pattern = "*",
    },
    {
      command = "lua\n            vim.api.nvim_set_hl(0, 'CopilotChatSeparator', { fg = vim.api. nvim_get_hl(0, { name = 'Normal' }).bg or '#000000', bg = 'NONE' })\n          ",
      event = { "VimEnter" },
      pattern = "*",
    },
  }

  for _, autocmd in ipairs(__nixvim_autocommands) do
    vim.api.nvim_create_autocmd(autocmd.event, {
      group = autocmd.group,
      pattern = autocmd.pattern,
      buffer = autocmd.buffer,
      desc = autocmd.desc,
      callback = autocmd.callback,
      command = autocmd.command,
      once = autocmd.once,
      nested = autocmd.nested,
    })
  end
end
