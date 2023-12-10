local function init()
  require 'wlvs.vim'.init()
  require 'wlvs.autocmds'.init()
  require 'wlvs.theme'.init()
  require 'wlvs.keymaps'.init()
  require 'wlvs.telescope'.init()
  require 'wlvs.treesitter'.init()
  require 'wlvs.mini'.init()
  require 'wlvs.editor'.init()
  require 'wlvs.coding'.init()
  require 'wlvs.ui'.init()
  require 'wlvs.lsp'.init()
end

return {
  init = init
}
