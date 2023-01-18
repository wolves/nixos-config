require('bufferline').setup({
  options = {
    --diagnostics = "nvim_lsp",
    always_show_bufferline = false,
    --diagnostics_indicator = function(_, _, diag)
    --  local icons = require("lazyvim.config.settings").icons.diagnostics
    --  local ret = (diag.error and icons.Error .. diag.error .. " " or "")
    --    .. (diag.warning and icons.Warn .. diag.warning or "")
    --  return vim.trim(ret)
    --end,
    offsets = {
      {
        filetype = "neo-tree",
        text = "Neo Tree",
        highlight = "Directory",
        text_align = "left",
      },
    },
  },
})
