local M = {}

local lspconfig = require("lspconfig")
local servers = require("wlvs.lsp.servers")
local keymaps = require("wlvs.lsp.keymaps")

local rust_tools = require("rust-tools")

local util = require("util")

local opts = {
  diagnostics = {
    underline = true,
    update_in_insert = false,
    virtual_text = {
      spacing = 4,
      source = "if_many",
      prefix = "●",
    },
    severity_sort = true,
  },
  -- Automatically format on save
  autoformat = true,
  -- Enable this to show formatters used in a notification
  -- Useful for debugging formatter issues
  format_notify = false,
  -- options for vim.lsp.buf.format
  -- `bufnr` and `filter` is handled by the LazyVim formatter,
  -- but can be also overriden when specified
  format = {
    formatting_options = nil,
    timeout_ms = nil,
  },
  -- you can do any additional lsp server setup here
  -- return true if you don't want this server to be setup with lspconfig
  ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
  setup = {
    -- example to setup with typescript.nvim
    -- tsserver = function(_, opts)
      --   require("typescript").setup({ server = opts })
      --   return true
      -- end,
      -- Specify * to use this function as a fallback for any server
      -- ["*"] = function(server, opts) end,
    },
}

function M.init()

  require("wlvs.lsp.format").setup(opts)

  -- Rust specific setup
  rust_tools.setup {
    server = {
      settings = {
        ['rust-analyzer'] = {
          cargo = {
            buildScripts = {
              enable = true,
            },
          },
          diagnostics = {
            enable = false,
          },
          files = {
            excludeDirs = { ".direnv", ".git" },
            watcherExclude = { ".direnv", ".git" },
          },
        },
      },
      on_attach = keymaps.on_attach,
      -- on_attach = on_attach,
    },
  }

  util.on_attach(function(client, buffer)
    keymaps.on_attach(client, buffer)
  end)

  -- diagnostics
  for name, icon in pairs(require("wlvs.symbols").icons.diagnostics) do
    name = "DiagnosticSign" .. name
    vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
  end
  vim.diagnostic.config(opts.diagnostics)


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
