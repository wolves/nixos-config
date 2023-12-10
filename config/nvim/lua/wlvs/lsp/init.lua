local M = {}

local lspconfig = require("lspconfig")
local servers = require("wlvs.lsp.servers")
local keymaps = require("wlvs.lsp.keymaps")

local util = require("util")

-- local function autocmd(args)
--   local event = args[1]
--   local group = args[2]
--   local callback = args[3]
--
--   vim.api.nvim_create_autocmd(event, {
--     group = group,
--     buffer = args[4],
--     callback = function()
--       callback()
--     end,
--     once = args.once,
--   })
-- end

-- local function on_attach(client, buffer)
--   local augroup_highlight = vim.api.nvim_create_augroup("custom-lsp-references", { clear = true })
--   local autocmd_clear = vim.api.nvim_clear_autocmds
--
--   local opts = { buffer = buffer, remap = false }
--
--   -- Enable completion triggered by <c-x><c-o>
--   vim.bo[buffer].omnifunc = 'v:lua.vim.lsp.omnifunc'
--
--   vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
--   vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
--   vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
--   vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
--   vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
--   vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
--   vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
--   vim.keymap.set('n', '<leader>wl', function()
--     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--   end, opts)
--   vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
--   vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
--   vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
--   vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
--   vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, opts)
--
--   if client.server_capabilities.documentHighlightProvider then
--     autocmd_clear { group = augroup_highlight, buffer = buffer }
--     autocmd { "CursorHold", augroup_highlight, vim.lsp.buf.document_highlight, buffer }
--     autocmd { "CursorMoved", augroup_highlight, vim.lsp.buf.clear_references, buffer }
--   end
-- end

function M.init()

  util.on_attach(function(client, buffer)
    keymaps.on_attach(client, buffer)
  end)

  local capabilities = vim.tbl_deep_extend(
    "force",
    {},
    vim.lsp.protocol.make_client_capabilities(),
    require("cmp_nvim_lsp").default_capabilities()
  )

  -- local servers = require("wlvs.lsp.servers").servers
  -- Initialize servers
  for server, server_config in pairs(servers) do
    -- local config = { on_attach = on_attach }
    --
    -- if server_config then
    --   for k, v in pairs(server_config) do
    --     config[k] = v
    --   end
    -- end
    server_config.capabilities = capabilities
    lspconfig[server].setup(server_config)
  end
end

return M
