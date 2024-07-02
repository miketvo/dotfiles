return {
  {
    'sainnhe/gruvbox-material',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      vim.opt.background = 'dark'
      vim.g.gruvbox_material_background = 'medium'
      vim.g.gruvbox_material_better_performance = 1
      vim.g.gruvbox_material_enable_bold = 1
      vim.g.gruvbox_material_transparent_background = 1

      vim.cmd.colorscheme('gruvbox-material')

      vim.cmd.highlight('NormalFloat guibg=#1B1B1B')           -- gruvbox-material bg_dim.
      vim.cmd.highlight('WinBar guibg=#1B1B1B')                -- gruvbox-material bg_dim.
      vim.cmd.highlight('WinBarNC guibg=#1B1B1B')              -- gruvbox-material bg_dim.
      vim.cmd.highlight('FloatBorder ctermfg=None guifg=None') -- no border.
    end,
  },
}
