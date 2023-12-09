local function init()
  require('trouble').setup({
    auto_open = false,
    use_diagnostic_signs = true,
  })

  require("todo-comments").setup({})
end

return {
  init = init
}
