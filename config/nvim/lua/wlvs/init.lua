local function init()
  require 'wlvs.vim'.init()
  require 'wlvs.theme'.init()
  require 'wlvs.keymaps'.init()
  require 'wlvs.telescope'.init()
  require 'wlvs.treesitter'.init()
  require 'wlvs.neoscroll'.init()
  require 'wlvs.neogit'.init()
  require 'wlvs.toggleterm'.init()
  require 'wlvs.editor'.init()
end

return {
  init = init
}
