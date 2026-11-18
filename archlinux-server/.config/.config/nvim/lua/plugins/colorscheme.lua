return {
  {
    'rebelot/kanagawa.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      require('kanagawa').setup({
        compile = true,              -- enable compiling the colorscheme
        undercurl = true,            -- enable undercurls
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true},
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = true,          -- do not set background color
        dimInactive = true,          -- dim inactive window `:h hl-NormalNC`
        terminalColors = true,       -- define vim.g.terminal_color_{0,17}
        colors = {                   -- add/modify theme and palette colors
          palette = {},
          theme = {
            wave = {},
            lotus = {}, dragon = {},
            all = {
              ui = {
                bg_dim = 'none',
                bg_gutter = 'none'
              }
            }
          },
        },
        overrides = function(colors) -- add/modify highlights
          return {}
        end,
        theme = 'wave',              -- Load 'wave' theme
        background = {               -- map the value of 'background' option to a theme
          dark = 'wave',             -- try 'dragon' !
          light = 'lotus'
        },
      })

      vim.cmd.colorscheme('kanagawa')
    end,
  },
}
