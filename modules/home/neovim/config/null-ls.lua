local nls = require("null-ls")

nls.setup({
  debounce = 150,
  save_after_format = false,
  sources = {
    -- nls.builtins.formatting.prettierd,
    nls.builtins.formatting.stylua,
    nls.builtins.formatting.fish_indent,
    nls.builtins.formatting.shfmt,
    nls.builtins.formatting.markdownlint,
    nls.builtins.formatting.prettierd.with({
      filetypes = { "markdown" }, -- only runs `deno fmt` for markdown
    }),
    nls.builtins.diagnostics.selene.with({
      condition = function(utils)
        return utils.root_has_file({ "selene.toml" })
      end,
    }),
    nls.builtins.diagnostics.flake8,
  },
  root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", ".git"),
})
