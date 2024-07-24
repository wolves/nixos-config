local util = require('util')

grep_string_prompt = require('wlvs.telescope').grep_string_prompt
grep_word = require('wlvs.telescope').grep_word

local function init()
  --require("lazyvim.config.keymaps")

  local wk = require("which-key")
  --local util = require("util")

  wk.setup({
    show_help = false,
    plugins = { spelling = true },
  })
  wk.add({
    {
      mode = { "n", "v" },
      { "<leader>b", group = "+buffer" },
      { "<leader>c", group = "+code" },
      { "<leader>f", group = "+file" },
      { "<leader>g", group = "+git" },
      { "<leader>h", group = "+help" },
      { "<leader>n", group = "+noice" },
      { "<leader>q", group = "+quit/session" },
      { "<leader>s", group = "+search" },
      { "<leader>x", group = "+diagnostics/quickfix" },
      { "[",         group = "+prev" },
      { "]",         group = "+next" },
      { "g",         group = "+goto" },
    },
  })

  vim.o.timeoutlen = 300

  -- Atempting fixing <C-c> -> <esc> remapping error
  -- vim.keymap.set("i", "<C-c>", "<C-c>")

  -- Move to window using the <ctrl> movement keys
  vim.keymap.set("n", "<left>", "<C-w>h")
  vim.keymap.set("n", "<right>", "<C-w>l")
  -- vim.keymap.set("n", "<down>", "<C-w>j")
  -- vim.keymap.set("n", "<up>", "<C-w>k")

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

  vim.keymap.set("n", "<C-Left>", "<cmd>BufferPrevious<CR>")
  vim.keymap.set("n", "<C-Right>", "<cmd>BufferNext<CR>")
  vim.keymap.set("n", "<S-h>", "<cmd>bprevious<CR>")
  vim.keymap.set("n", "<S-l>", "<cmd>bnext<CR>")

  -- Move to splits
  vim.keymap.set("n", "<C-h>", "<C-w>h")
  vim.keymap.set("n", "<C-j>", "<C-w>j")
  vim.keymap.set("n", "<C-k>", "<C-w>k")
  vim.keymap.set("n", "<C-l>", "<C-w>l")

  -- Tree
  vim.keymap.set("n", "<C-e>", "<cmd>Neotree toggle reveal<CR>")

  -- Search
  local function search(backward)
    vim.cmd([[echo "1> "]])
    local first = vim.fn.getcharstr()
    vim.fn.search(first, "s" .. (backward and "b" or ""))
    vim.schedule(function()
      vim.cmd([[echo "2> "]])
      local second = vim.fn.getcharstr()
      vim.fn.search(first .. second, "c" .. (backward and "b" or ""))

      vim.fn.setreg("/", first .. second)
    end)
  end

  vim.keymap.set("n", "s", search)
  vim.keymap.set("n", "S", function()
    search(true)
  end)

  -- Clear search with <esc>
  vim.keymap.set("", "<esc>", ":noh<esc>")
  vim.keymap.set("n", "gw", "*N")
  vim.keymap.set("x", "gw", "*N")

  wk.add({
    { "<leader>w",       "<cmd>w!<CR>",                desc = "Save" },
    { "<leader>q",       "<cmd>q!<CR>",                desc = "Quit" },
    { "<leader><space>", util.telescope("find_files"), desc = "Find Files" },
    { "<leader>b",       group = "+buffer" },
    {
      "<leader>bb",
      "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
      desc = "Buffers",
    },
    {
      "<leader>bd",
      "<cmd>lua require('mini.bufremove').delete(0, false)<CR>",
      desc = "Delete Buffer",
    },
    { "<leader>e",  "<cmd>lua require('mini.files').open()<CR>", desc = "File Explorer" },
    { "<leader>f",  group = "+file" },
    { "<leader>fn", "<cmd>enew<CR>",                             desc = "New" },
    { "<leader>g",  group = "+git" },
    { "<leader>gd", "<cmd>DiffviewOpen<CR>",                     desc = "Diffview" },
    { "<leader>gg", "<cmd>Neogit<CR>",                           desc = "Neogit" },
    { "<leader>gh", group = "+hunk" },

    { "<leader>gJ", "<cmd>TSJJoin<cr>",                          desc = "Join" },
    { "<leader>gS", "<cmd>TSJSplit<cr>",                         desc = "Split" },

    { "<leader>m",  group = "+harpoon" },
    { "<leader>s",  group = "+search" },
    { "<leader>ss", grep_string_prompt,                          desc = "Grep Prompt" },
    { "<leader>sw", grep_word,                                   desc = "Grep Current Word" },
    { "<leader>t",  group = "+toggle" },
    { "<leader>tc", util.toggle_colors,                          desc = "Colorscheme Light/Dark" },
    { "<leader>tf", require("wlvs.lsp.format").toggle,           desc = "Format on Save" },
    {
      "<leader>tn",
      function()
        util.toggle("relativenumber", true)
        util.toggle("number")
      end,
      desc = "Line Numbers",
    },
    {
      "<leader>ts",
      function()
        util.toggle("spell")
      end,
      desc = "Spelling",
    },
    {
      "<leader>tw",
      function()
        util.toggle("wrap")
      end,
      desc = "Word Wrap",
    },
    { "<leader>x",  group = "+trouble/todo" },
    { "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>",              desc = "Diagnostics (Trouble)" },
    { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Buffer Diagnostics (Trouble)" },
    { "<leader>xt", "<cmd>TodoTrouble<CR>",                             desc = "Todo Trouble" },
    { "<leader>xT", "<cmd>TodoTelescope<CR>",                           desc = "Todo Telescope" },
  })

  -- Ignore <leader> with numerals
  local ignores = {}
  for i = 0, 10 do
    table.insert(ignores, { "<leader>" .. tostring(i), hidden = true })
  end
  wk.add(ignores)

  -- wk.register(leader, { prefix = "<leader>" })


  wk.add({
    { "g", group = "+goto" },
  })
end

return {
  init = init
}
