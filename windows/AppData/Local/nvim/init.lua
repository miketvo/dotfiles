--[[

 ╔═════════════════════[ MIKETVO ]═════════════════════╗
 ║                                                     ║
 ║  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ║
 ║  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ║
 ║  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ║
 ║  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ║
 ║  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ║
 ║  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ║
 ╟─────────────────────────────────────────────────────╢
 ║                    CONFIGURATION                    ║
 ╚═════════════════════════════════════════════════════╝

--]]


-- [[ CONFIGURATIONS ]]
require('config.options')   -- See stdpath('config') .. '/config/options.lua'.
require('config.keymaps')   -- See stdpath('config') .. '/config/keymaps.lua'.
require('config.autocmds')  -- See stdpath('config') .. '/config/autocmds.lua'.


-- [[ PLUGIN MANAGER (LAZY.NVIM) ]]
-- See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info.
--
-- NOTE: Install and configure plugins by adding or modifying specfiles in stdpath('config') .. '/plugins'. See
-- `:help stdpath()`.
--
-- To check the current status of your plugins, run
--   :Lazy (shortcut: <leader>l)
--
--   You can press `?` in this menu for help. Use `:q` (shortcut: q) to close the window.
--
-- To update plugins you can run
--   :Lazy update
require('config.lazy')  -- See stdpath('config') .. '/config/lazy.lua'.
