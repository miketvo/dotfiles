return {
  {
    'nordtheme/vim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      vim.cmd.colorscheme('nord')
      vim.cmd.highlight('SignColumn guibg=NONE ctermbg=NONE')
      vim.cmd.highlight('Normal guibg=NONE ctermbg=NONE')
      vim.cmd.highlight('WinSeparator guifg=#3B4252')          -- nord1.
      vim.cmd.highlight('NormalFloat guibg=#252931')           -- nord-1.
      vim.cmd.highlight('WinBar guibg=#252931')                -- nord-1.
      vim.cmd.highlight('WinBarNC guibg=#252931')              -- nord-1.
      vim.cmd.highlight('FloatBorder ctermfg=None guifg=None') -- no border.
    end,
  },
}
