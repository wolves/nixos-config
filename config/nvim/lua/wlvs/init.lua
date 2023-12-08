local function init()
  require 'wlvs.theme'.init()
  require 'wlvs.keymaps'.init()
  require 'wlvs.telescope'.init()
  require 'wlvs.treesitter'.init()
  require 'wlvs.neogit'.init()
end

return {
  init = init
}
