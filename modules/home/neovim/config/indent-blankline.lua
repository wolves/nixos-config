require("indent_blankline").setup({
  -- char = "▏",
  char = "│",
  filetype_exclude = {
    "help",
    "dashboard",
    "neo-tree",
    "Trouble",
    "lazy",
    "neogitstatus",
  },
  show_trailing_blankline_indent = false,
  show_current_context = false,
})
