
local servers = {
  bashls = {},
  cssls = {},
  gopls = {
    settings = {
      gopls = {
        gofumpt = true,
      },
    },
  },
  html = {},
  jsonls = {},
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { 'vim' }
        },
        runtime = {
          version = 'LuaJIT',
        },
        telemetry = {
          enable = false,
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
        },
      },
    }
  },
  nil_ls = {
    settings = {
      ['nil'] = {
        formatting = { command = { "nixpkgs-fmt" } },
      },
    }
  },
  tsserver = {},
  yamlls = {
    settings = {
      yaml = {
        keyOrdering = false,
      },
    },
  },
}

return servers
