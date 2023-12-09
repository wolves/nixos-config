local function init()

  -- Comments
  require("mini.comment").setup({
    hooks = {
      pre = function()
        require("ts_context_commentstring.internal").update_commentstring({})
      end,
    },
  })

  -- Indentscope
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

  -- Pairs
  require("mini.pairs").setup({})

  -- Surround
  require("mini.surround").setup({
    mappings = {
      add = "gza", -- Add surrounding in Normal and Visual modes
      delete = "gzd", -- Delete surrounding
      find = "gzf", -- Find surrounding (to the right)
      find_left = "gzF", -- Find surrounding (to the left)
      highlight = "gzh", -- Highlight surrounding
      replace = "gzr", -- Replace surrounding
      update_n_lines = "gzn", -- Update `n_lines`
    },
  })
end

return {
  init = init
}
