local function init()
  require("treesj").setup({
    use_default_keymaps = false,
    max_join_length = 150,
  })
end

return {
  init = init
}
