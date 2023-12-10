local function init()
  local cmp = require("cmp")
  cmp.setup({})

  require("treesj").setup({
    use_default_keymaps = false,
    max_join_length = 150,
  })
end

return {
  init = init
}
