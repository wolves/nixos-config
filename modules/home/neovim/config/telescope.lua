local telescope = require("telescope")
local borderless = true

telescope.setup({
  defaults = {
    layout_strategy = "horizontal",
    layout_config = {
      prompt_position = "top",
    },
    sorting_strategy = "ascending",
    winblend = borderless and 0 or 10,
  },
})
telescope.load_extension("fzf")
