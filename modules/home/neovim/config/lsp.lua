local lspc = require("lspconfig")

-- formatting & keymaps
local function custom_attach(on_attach)
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local buffer = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      on_attach(client, buffer)
    end,
  })
end

custom_attach(function(client, buffer)
  dofile("/home/wlvs/.config/nixos-config/modules/home/neovim/config/lsp/format.lua").on_attach(client, buffer)
  dofile("/home/wlvs/.config/nixos-config/modules/home/neovim/config/lsp/keymaps.lua").on_attach(client, buffer)
end)

-- local function on_attach(client, bufnr)
--   dofile("/home/wlvs/.config/nixos-config/modules/home/neovim/config/lsp/format.lua").setup(client, bufnr)
--   dofile("/home/wlvs/.config/nixos-config/modules/home/neovim/config/lsp/keymaps.lua").setup(client, bufnr)
-- end

-- diagnostics
vim.diagnostic.config({
  underline = true,
  update_in_insert = false,
  virtual_text = { spacing = 4, prefix = "●" },
  severity_sort = true,
})

vim.lsp.handlers["workspace/diagnostic/refresh"] = function(_, _, ctx)
  local ns = vim.lsp.diagnostic.get_namespace(ctx.client_id)
  pcall(vim.diagnostic.reset, ns)
  return true
end

local diag_icons = {
  Error = " ",
  Warn = " ",
  Hint = " ",
  Info = " ",
}

for name, icon in pairs(diag_icons) do
  name = "DiagnosticSign" .. name
  vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
end


-- capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

local options = {
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_test_changes = 150,
  },
}

local servers = dofile("/home/wlvs/.config/nixos-config/modules/home/neovim/config/lsp/servers.lua")
for server, opts in pairs(servers) do
  opts = vim.tbl_deep_extend("force", {}, options, opts or {})
  lspc[server].setup(opts)
end
