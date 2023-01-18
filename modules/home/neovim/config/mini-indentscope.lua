vim.api.nvim_create_autocmd("FileType", {
  pattern = { "alpha", "lazy" },
  callback = function()
    vim.b.miniindentscope_disable = true
  end,
})

require("mini.indentscope").setup({
  -- symbol = "▏",
  symbol = "│",
  options = { try_as_border = true },
})
