local function jump(key, dir)
  vim.keymap.set({ "i", "s" }, key, function()
    return require("luasnip").jump(dir) or key
  end, { expr = true })
end
jump("<tab>", 1)
jump("<s-tab>", -1)

require("luasnip").config.setup({
  history = true,
  delete_check_events = "TextChanged",
})
