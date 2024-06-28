return {

  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    init = function()
      if vim.fn.argc(-1) > 0 then
        vim.o.statusline = ' '  -- set an empty statusline till lualine loads
      end
    end,
    opts = function()
      local opts = {
        options = {
          theme = 'auto',
          globalstatus = vim.o.laststatus == 3,
          disabled_filetypes = { statusline = { 'dashboard', 'alpha', 'starter' } },
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch' },
          lualine_y = {
            { 'progress', separator = ' ', padding = { left = 1, right = 0 } },
            { 'location', padding = { left = 0, right = 1 } },
          },
          lualine_z = {
            function()
              return ' ' .. os.date('%R')
            end,
          },
        },
        extensions = { 'neo-tree', 'lazy' },
      }

      return opts
    end,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },

}
