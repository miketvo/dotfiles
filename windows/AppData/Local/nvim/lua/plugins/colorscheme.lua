return {
  {
    'nordtheme/vim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      vim.cmd.colorscheme 'nord'
    end,
  },
}
