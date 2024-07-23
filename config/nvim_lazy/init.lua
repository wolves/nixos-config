------------------------------------------------------------------------------//
--    _/          _/  _/      _/      _/    _/_/_/
--   _/          _/  _/      _/      _/  _/
--  _/    _/    _/  _/      _/      _/    _/_/
--   _/  _/  _/    _/        _/  _/          _/
--    _/  _/      _/_/_/_/    _/      _/_/_/
------------------------------------------------------------------------------//

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.lazy")
require("config.options")

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    require("util").version()
    require("config.autocmds")
    require("config.keymaps")
  end,
})
