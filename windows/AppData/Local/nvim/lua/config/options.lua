--------------------------------------
-- [[ GLOBAL VIMSCRIPT VARIABLES ]] --
-- See `:let g:`.
--------------------------------------

-- Leader key.
vim.g.mapleader = ' '          -- See `:help <Leader>` and `:help mapleader`.
vim.g.maplocalleader = '\\'    -- See `:help <LocalLeader>` and `:help maplocalleader`.

-- Whether the system has Nerd Fonts installed and enabled in the terminal.
-- NOTE: This is a custom variable.
vim.g.have_nerd_font = true


--------------------------
-- [[ NEOVIM OPTIONS ]] --
-- See `:help vim.opt`.
-- For more options, see `:help option-list`.
--------------------------
local opt = vim.opt

-- Decrease update time.
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time. Displays which-key popup sooner.
vim.opt.timeoutlen = 300

-- Line numbers.
opt.number = true
opt.relativenumber = true

-- Mouse mode.
opt.mouse = 'a'                -- See `:help mouse` for more values.

-- Clipboard. See `:help clipboard` and `:help 'clipboard'`.
-- Yank, delete and put from "+" clipboard register (system clipboard).
opt.clipboard = 'unnamedplus'

-- Undo file. See `:help 'undofile'`.
opt.undofile = true

-- Spell checking. See `:help spell`.
opt.spell = false              -- Turn off spell checking by default.

-- Line wrap and break indent.
opt.breakindent = true         -- See `:help 'breakindent'`.
opt.linebreak = true           -- Wrap line at convenient points. See `:help 'breakat'`.
opt.wrap = false               -- Set no line wrapping by default.

-- Indentation
opt.smartindent = true         -- See `:help 'smartindent'`.
opt.tabstop = 4                -- Default to 4 spaces per tab.
opt.shiftwidth = 4             -- Default to 4 spaces per (auto)indent.
opt.expandtab = true           -- Using spaces instead of tab by default.

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term.
opt.ignorecase = true
opt.smartcase = true

-- Visual behavior options.
opt.showmode = false           -- Don't show the editing mode, since it's already in the status line.
opt.signcolumn = 'auto'         -- Keep signcolumn off by default.
opt.cursorline = true          -- Show which line the cursor is on.
opt.list = true                -- Show whitespace character.
opt.listchars = {              -- Custom whitespace markers.
  tab = '⇥ ',
  trail = '·',
  nbsp = '␣',
}
if vim.fn.has('termguicolors') then
  opt.termguicolors = true       -- True color support.
end

-- Window splitting options.
opt.splitright = true
opt.splitbelow = true
