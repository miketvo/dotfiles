-- Bootstrap lazy.nvim.
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim.
require('lazy').setup({
  spec = {
    -- Import your plugins.
    { import = 'plugins' },
  },
  defaults = {
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning, have outdated
    -- releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = '*', -- try installing the latest stable version for plugins that support semver
  },
  -- Configure any other settings here. See the documentation (https://lazy.folke.io) for more details.
  checker = { enabled = true },  -- automatically check for plugin updates
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = ' ',
      config = '',
      event = ' ',
      favorite = ' ',
      ft = ' ',
      init = ' ',
      import = ' ',
      keys = ' ',
      lazy = ' ',
      loaded = '●',
      not_loaded = '○',
      plugin = ' ',
      runtime = ' ',
      require = '󰢱 ',
      source = ' ',
      start = ' ',
      task = '🗹 ',
      list = {
        '●',
        '➜',
        '★',
        '‒',
      },
    },
  },
})
