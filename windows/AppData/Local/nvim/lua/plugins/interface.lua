return {

  { -- See `:help lualine.txt`.
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    init = function()
      if vim.fn.argc(-1) > 0 then
        vim.o.statusline = ' ' -- set an empty statusline till lualine loads
      end
    end,
    opts = { -- NOTE: For more options, see `:help lualine-Available-options`.
      options = {
        icon_enabled = vim.g.have_nerd_font,
        theme = 'auto',
        globalstatus = true,
        disabled_filetypes = {
          statusline = { 'dashboard', 'alpha', 'starter' },
        },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = {
          'branch',
          {
            'diff',
            source = function()
              local gitsigns = vim.b.gitsigns_status_dict
              if gitsigns then
                return {
                  added = gitsigns.added,
                  modified = gitsigns.changed,
                  removed = gitsigns.removed,
                }
              end
            end,
          },
        },
        lualine_c = {
          { 'filename', path = 1 },
        },
        lualine_x = {
          { 'filetype', colored = false },
          { 'encoding', separator = '' },
          { 'fileformat', padding = { left = 0, right = 1 } },
        },
        lualine_y = { '%p%%' },
        lualine_z = { '%l/%L:%c' }
      },
      tabline = {
        lualine_a = {
          {
            'buffers',
            mode = 4, -- Shows buffer number and buffer name.
            use_mode_colors = true, -- Sync color with current mode.
            show_modified_status = false,
            filetype_names = {
              TelescopePrompt = 'Telescope',
              fzf = 'Fuzzy Find',
              ['neo-tree'] = 'File System',
              ['neo-tree-preview'] = 'File Preview',
              ['neo-tree-popup'] = 'Popup',
              NVimTree = 'File System',
              packer = 'Plugins',
              lazy = 'Plugins',
              alpha = 'Dashboard',
              dashboard = 'Dashboard',
            }, -- Shows specific window name for that filetype ( { `filetype` = 'window_name', ... } ),
            buffers_color = vim.g.termguicolors
                and { inactive = 'StatusLineNC' }
                or { inactive = 'StatusLineTermNC' },
            symbols = { alternate_file = '' },
          },
        },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {
          {
            'tabs',
            mode = 0, -- Just show tab number.
            use_mode_colors = true, -- Sync color with current mode.
            show_modified_status = false,
            tabs_color = vim.g.termguicolors
                and { inactive = 'StatusLineNC' }
                or { inactive = 'StatusLineTermNC' },
          }
        },
      },
      extensions = { 'neo-tree', 'lazy' },
    },
  },

  { -- Visual indent guides. See `:help indent-blankline`.
    'lukas-reineke/indent-blankline.nvim',
    opts = {
      indent = { char = '▏' },
      scope = { show_start = true, show_end = false },
      exclude = {
        filetypes = {
          'help',
          'alpha',
          'dashboard',
          'neo-tree',
          'Trouble',
          'trouble',
          'lazy',
          'mason',
          'notify',
          'toggleterm',
        },
      },
    },
    main = 'ibl',
  },

  { -- Useful plugin to show pending keybinds. See `:help which-key.nvim.txt`
    'folke/which-key.nvim',
    event = 'VeryLazy',
    config = function()
      wk = require('which-key')
      wk.setup({ plugins = { spelling = true } })
      wk.register({ -- NOTE: Document existing key chains here.
        ['g'] = { name = '+g-commands' },
        ['gs'] = { name = '+surround' },
        ['z'] = { name = '+view' },
        [']'] = { name = '+next' },
        ['['] = { name = '+prev' },
        ["<leader>b"] = { name = "+buffer", _ = "which_key_ignore" },
        ["<leader>gh"] = { name = "+hunk", _ = "which_key_ignore" },
      }, { mode = { 'n', 'v' } })
    end,
  },

}
