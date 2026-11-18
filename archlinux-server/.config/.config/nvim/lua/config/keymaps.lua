-----------------------
-- [[ KEY MAPPING ]] --
-- See `:help vim.keymap.set()`.
-----------------------
local map = vim.keymap

-- Set highlight on search, but clear on pressing <Esc> in normal mode.
vim.opt.hlsearch = true
map.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps.
map.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Goto previous diagnostic' })
map.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Goto next diagnostic' })
map.set('n', '<leader>df', vim.diagnostic.open_float, { desc = 'Diagnostic detail' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier for people to discover. Otherwise,
-- you normally need to press <C-\><C-n>, which is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping or just use <C-\><C-n> to exit
-- terminal mode.
map.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Plugin manager shortcut.
map.set('n', '<leader>l', '<cmd>Lazy<cr>', { desc = 'Plugin manager' })


----------------------------------
-- [[ BUFFER COMMAND MAPPING ]] --
----------------------------------
map.set('n', '<leader>bn', '<cmd>bn<cr>', { desc = 'Switch to next buffer'})
map.set('n', '<leader>bp', '<cmd>bp<cr>', { desc = 'Switch to previous buffer'})
map.set('v', '<leader>bn', '<cmd>bn<cr>', { desc = 'Switch to next buffer'})
map.set('v', '<leader>bp', '<cmd>bp<cr>', { desc = 'Switch to previous buffer'})


----------------------------------
-- [[ WINDOW COMMAND MAPPING ]] --
-- See `:help wincmd` for a list of all window commands.
----------------------------------

-- CTRL+<hjkl> to switch between windows.
map.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- CTRL+ARROW to resize window.
map.set('n', '<C-Up>', '<cmd>resize +1<cr>', { desc = 'Increase window height' })
map.set('n', '<C-Down>', '<cmd>resize -1<cr>', { desc = 'Decrease window height' })
map.set('n', '<C-Left>', '<cmd>vertical resize -1<cr>', { desc = 'Decrease window width' })
map.set('n', '<C-Right>', '<cmd>vertical resize +1<cr>', { desc = 'Increase window width' })


-----------------------------------
-- [[ EDITING COMMAND MAPPING ]] --
-----------------------------------

-- Move lines
map.set('n', '<A-j>', '<cmd>m .+1<cr>==', { desc = 'Move line down' })
map.set('n', '<A-k>', '<cmd>m .-2<cr>==', { desc = 'Move line up' })
map.set('i', '<A-j>', '<esc><cmd>m .+1<cr>==gi', { desc = 'Move line down' })
map.set('i', '<A-k>', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move line up' })
map.set('v', '<A-j>', ":m '>+1<cr>gv=gv", { desc = 'Move line down' })
map.set('v', '<A-k>', ":m '<-2<cr>gv=gv", { desc = 'Move line up' })
