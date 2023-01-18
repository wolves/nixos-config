require('neogit').setup({
  disable_commit_confirmation = true,
  kind = "floating",
  commit_popup = {
    kind = "floating",
  },
  popup = {
    kind = "floating",
  },
  signs = {
    -- { CLOSED, OPENED }
    section = { "", "" },
    item = { "", "" },
    hunk = { "", "" },
  },
  integrations = { diffview = true },
})