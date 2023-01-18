vim.g.mapleader = " "

local wk = require("which-key")

vim.o.timeoutlen = 300

wk.setup({
  show_help = false,
  plugins = { spelling = true },
  key_labels = { ["<leader>"] = "SPC" },
  triggers_blacklist = {
    i = { "j", "k" },
    v = { "j", "k" },
  },
})

-- Move to window using the <ctrl> movement keys
vim.keymap.set("n", "<left>", "<C-w>h")
vim.keymap.set("n", "<down>", "<C-w>j")
vim.keymap.set("n", "<up>", "<C-w>k")
vim.keymap.set("n", "<right>", "<C-w>l")

-- Resize window using <ctrl> arrow keys
vim.keymap.set("n", "<S-Up>", "<cmd>resize +2<CR>")
vim.keymap.set("n", "<S-Down>", "<cmd>resize -2<CR>")
vim.keymap.set("n", "<S-Left>", "<cmd>vertical resize -2<CR>")
vim.keymap.set("n", "<S-Right>", "<cmd>vertical resize +2<CR>")

-- Move Lines
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==")
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi")
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi")

-- Switch buffers with tab
vim.keymap.set("n", "<C-Left>", "<cmd>bprevious<CR>")
vim.keymap.set("n", "<C-Right>", "<cmd>bnext<CR>")
vim.keymap.set("n", "<S-h>", "<cmd>bprevious<CR>")
vim.keymap.set("n", "<S-l>", "<cmd>bnext<CR>")

-- Move to splits
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Tree
vim.keymap.set("n", "<C-n>", "<cmd>Neotree toggle reveal<CR>")

-- Clear search with <esc>
vim.keymap.set("", "<esc>", ":noh<esc>")
vim.keymap.set("n", "gw", "*N")
vim.keymap.set("x", "gw", "*N")

wk.register({
  mode = { "n", "v" },
  ["g"] = { name = "+goto" },
  ["]"] = { name = "+next" },
  ["["] = { name = "+prev" },
  ["<leader>b"] = { name = "+buffer" },
  ["<leader>c"] = { name = "+code" },
  ["<leader>f"] = { name = "+file" },
  ["<leader>g"] = { name = "+git" },
  ["<leader>h"] = { name = "+help" },
  ["<leader>n"] = { name = "+noice" },
  ["<leader>q"] = { name = "+quit/session" },
  ["<leader>s"] = { name = "+search" },
  ["<leader>x"] = { name = "+diagnostics/quickfix" },
})

local leader = {
  w = { "<cmd>w!<CR>", "Save" },
  q = { "<cmd>q!<CR>", "Quit" },
  b = {
    b = {
      "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
      "Buffers",
    },
  },
  h = {
    f = { "<cmd>Telescope filetypes<CR>", desc = "Filetypes" },
  },
}

for i = 0, 10 do
  leader[tostring(i)] = "which_key_ignore"
end

wk.register(leader, { prefix = "<leader>" })

wk.register({ g = { name = "+goto" } })
