local telescope = require("telescope")
local borderless = true

local function grep_string_prompt()
  require("telescope.builtin").grep_string({
    path_display = { "shorten" },
    search = vim.fn.input("Grep String ❱ "),
  })
end

local function grep_word()
  require("telescope.builtin").grep_string({
    path_display = { "shorten" },
    search = vim.fn.expand("<cword>"),
  })
end

local function project_files(opts)
  opts = opts or {}
  opts.show_untracked = true
  if vim.loop.fs_stat(".git") then
    require("telescope.builtin").git_files(opts)
  else
    local client = vim.lsp.get_active_clients()[1]
    if client then
      opts.cwd = client.config.root_dir
    end
    require("telescope.builtin").find_files(opts)
  end
end

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

vim.keymap.set("n", "<leader><space>", function()
  project_files()
end, { desc = "Find File" })

vim.keymap.set("n", "<leader>ss", function()
  grep_string_prompt()
end, { desc = "Grep Prompt" })

vim.keymap.set("n", "<leader>sw", function()
  grep_word()
end, { desc = "Grep Current Word" })
