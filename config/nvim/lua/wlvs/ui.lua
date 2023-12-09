local function init()
  require("dressing").setup({})

  require("bufferline").setup({
    options = {
      always_show_bufferline = true,
      separator_style = "thin",
      indicator = {
        icon = "▎", -- this should be omitted if indicator style is not 'icon'
        style = "icon",
      },
      -- indicator = {
      --   style = "underline",
      -- },
      --diagnostics = "nvim_lsp",
      --diagnostics_indicator = function(_, _, diag)
      --  local icons = require("lazyvim.config.settings").icons.diagnostics
      --  local ret = (diag.error and icons.Error .. diag.error .. " " or "")
      --    .. (diag.warning and icons.Warn .. diag.warning or "")
      --  return vim.trim(ret)
      --end,
      offsets = {
        {
          filetype = "neo-tree",
          text = "EXPLORER",
          -- highlight = "Directory",
          text_align = "center",
          separator = true,
        },
      },
    }
  })

  require("ibl").setup({
    indent = {
      char = "│",
      tab_char = "│",
    },
    scope = { enabled = false },
    exclude = {
      filetypes = {
        "help",
        "dashboard",
        "neo-tree",
        "Trouble",
        "lazy",
        "neogitstatus",
        "mason",
        "notify",
        "toggleterm",
        "lazyterm",
      },
    },
    -- show_trailing_blankline_indent = false,
  })

  require("noice").setup({
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
      },
    },
    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
    },
  })

  require("nvim-web-devicons").setup({})
end

return {
  init = init
}

