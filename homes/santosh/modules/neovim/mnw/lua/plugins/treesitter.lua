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
