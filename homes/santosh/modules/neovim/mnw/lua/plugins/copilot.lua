require("copilot").setup({
  filetypes = {
    ["."] = false,
    bash = true,
    cvs = false,
    gitcommit = true,
    gitrebase = true,
    help = false,
    hgcommit = false,
    html = true,
    js = true,
    lua = true,
    markdown = true,
    nix = true,
    python = true,
    rs = true,
    svn = false,
    ts = true,
    yaml = false,
  },
  panel = { auto_refresh = false, enabled = false },
  suggestion = { auto_trigger = true, debounce = 90, enabled = false, hide_during_completion = true },
})

require("CopilotChat").setup({
  auto_fold = true,
  auto_follow_cursor = true,
  headers = { assistant = "## Ai ", tool = "## Tool ", user = "## santosh " },
  highlight_selection = false,
  model = "gpt-4.1",
  show_help = false,
  window = { border = "none", height = 1, layout = "float", title = "─", width = 1 },
})
