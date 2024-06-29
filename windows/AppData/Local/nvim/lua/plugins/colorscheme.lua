return {
  {
    'nordtheme/vim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      vim.cmd.colorscheme('nord')
      vim.cmd.highlight('Normal guibg=NONE ctermbg=NONE')
      vim.cmd.highlight('WinSeparator guifg=#3B4252')          -- nord1.
      vim.cmd.highlight('NormalFloat guibg=#434C5E')           -- nord2.
      vim.cmd.highlight('FloatBorder ctermfg=None guifg=None') -- no border.
    end,
  },
}
