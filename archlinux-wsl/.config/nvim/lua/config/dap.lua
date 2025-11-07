-------------------------------
-- [[ DEBUG ADAPTER SETUP ]] --
-- See https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
-------------------------------
vim.g.dap_setup = function ()
  local dap = require('dap')

  -- Godot gdscript
  dap.adapters.godot = {
    type = 'server',
    host = '127.0.0.1',
    port = 6006,
  }
end
