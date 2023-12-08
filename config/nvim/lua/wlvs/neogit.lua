local function init()
  local neogit = require("neogit")

  neogit.setup({
    disable_commit_confirmation = true,
    kind = "floating",
    commit_editor = {
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
end

return {
  init = init
}
