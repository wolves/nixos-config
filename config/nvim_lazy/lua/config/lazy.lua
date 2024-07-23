local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local lockpath = os.getenv("LAZY_NVIM_LOCK_PATH")

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local lazy_config = {
  defaults = {
    lazy = false,
  },
  install = { colorscheme = { "kanagawa", "habamax" } },
  checker = { enabled = false },
  diff = {
    cmd = "terminal_git",
  },
  performance = {
    cache = { enabled = true },
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
        "nvim-treesitter-textobjects",
      },
    },
  },
  ui = {
    backdrop = 100,
  },
}
if lockpath then
  vim.notify(("Lockpath set to: %s"):format(lockpath), vim.log.levels.INFO, { title = "Lazy: lockpath set!" })
  lazy_config.lockfile = lockpath .. "/lazy-lock.json"
else
  vim.notify("No lock path", vim.log.levels.INFO, { title = "Lazy: lockpath not set!" })
end

require("lazy").setup("plugins", lazy_config)

vim.keymap.set("n", "<leader>l", "<cmd>:Lazy<CR>")
