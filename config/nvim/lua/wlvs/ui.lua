local function init()
  require("notify").setup({
    timeout = 3000,
    max_height = function()
      return math.floor(vim.o.lines * 0.75)
    end,
    max_width = function()
      return math.floor(vim.o.columns * 0.75)
    end,
  })

  require("dressing").setup({})

  require("barbar").setup({
    sidebar_filetypes = {
      ['neo-tree'] = { event = 'BufWipeout' },
    }
  })

  -- require("bufferline").setup({
  --   options = {
  --     always_show_bufferline = true,
  --     separator_style = "thin",
  --     indicator = {
  --       icon = "▎", -- this should be omitted if indicator style is not 'icon'
  --       style = "icon",
  --     },
  --     -- indicator = {
  --     --   style = "underline",
  --     -- },
  --     --diagnostics = "nvim_lsp",
  --     --diagnostics_indicator = function(_, _, diag)
  --     --  local icons = require("lazyvim.config.settings").icons.diagnostics
  --     --  local ret = (diag.error and icons.Error .. diag.error .. " " or "")
  --     --    .. (diag.warning and icons.Warn .. diag.warning or "")
  --     --  return vim.trim(ret)
  --     --end,
  --     offsets = {
  --       {
  --         filetype = "neo-tree",
  --         text = "EXPLORER",
  --         -- highlight = "Directory",
  --         text_align = "center",
  --         separator = true,
  --       },
  --     },
  --   }
  -- })

  local function fg(name)
    return function()
      ---@type {foreground?:number}?
      local hl = vim.api.nvim_get_hl_by_name(name, true)
      return hl and hl.foreground and { fg = string.format("#%06x", hl.foreground) }
    end
  end

  require("lualine").setup({
    options = {
      theme = "auto",
      globalstatus = true,
      disabled_filetypes = { statusline = { "lazy" } },
      section_separators = { left = "", right = "" },
      component_separators = { left = "", right = "" },
      icons_enabled = true,
    },
    sections = {
      lualine_a = { { "mode", separator = { left = "" } } },
      lualine_b = { "branch" },
      lualine_c = {
        {
          "diagnostics",
          symbols = {
            error = " ",
            warn = " ",
            hint = " ",
            info = " ",
          },
        },
        { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
        { "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
        {
          function()
            return require("nvim-navic").get_location()
          end,
          cond = function()
            return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
          end,
        },
      },
      lualine_x = {
        {
          function()
            return require("noice").api.status.command.get()
          end,
          cond = function()
            return package.loaded["noice"] and require("noice").api.status.command.has()
          end,
          color = fg("Statement"),
        },
        {
          function()
            return require("noice").api.status.mode.get()
          end,
          cond = function()
            return package.loaded["noice"] and require("noice").api.status.mode.has()
          end,
          color = fg("Constant"),
        },
        -- { require("lazy.status").updates, cond = require("lazy.status").has_updates, color = fg("Special") },
        {
          "diff",
          symbols = {
            added = " ",
            modified = " ",
            removed = " ",
          },
        },
      },
      lualine_y = {
        { "progress", separator = "",                   padding = { left = 1, right = 0 } },
        { "location", padding = { left = 0, right = 1 } },
      },
      lualine_z = {
        {
          function()
            return " " .. os.date("%R")
          end,
          separator = { right = "" },
        },
      },
    },
    -- extensions = { "nvim-tree" },
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
