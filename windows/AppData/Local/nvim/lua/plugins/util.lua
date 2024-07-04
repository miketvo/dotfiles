return {

  -- Utility dependency. See https://github.com/nvim-lua/plenary.nvim.
  { 'nvim-lua/plenary.nvim', lazy = true },

  -- UI component library. See https://github.com/MunifTanjim/nui.nvim.
  { 'MunifTanjim/nui.nvim', lazy = true },

  -- Asynchronous I/O library. See https://github.com/nvim-neotest/nvim-nio.
  { 'nvim-neotest/nvim-nio' },

  -- Pretty icon dependency for file explorer, tabline, statusline, etc.
  -- See https://github.com/nvim-tree/nvim-web-devicons.
  -- See `:help nvim-web-devicons-usage`.
  { 'nvim-tree/nvim-web-devicons', lazy = true },

  { -- Session management. This saves your session in the background, keeping track of open buffers, window
    -- arrangement, and more.
    -- See `:help persistence.nvim-persistence`.
    'folke/persistence.nvim',
    event = 'BufReadPre',
    keys = {
      { '<leader>qr', function() require('persistence').load() end, desc = 'Restore Session' },
      { '<leader>ql', function() require('persistence').load({ last = true }) end, desc = 'Restore Last Session' },
      { '<leader>qd', function() require('persistence').stop() end, desc = "Don't Save Current Session" },
    },
    opts = {
      options = { 'buffers', 'curdir', 'tabpages', 'winsize', 'help', 'globals', 'skiprtp' },
    },
  }

}
