return {

  { -- See `:help lualine`.
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = 'VeryLazy',
    init = function()
      if vim.fn.argc(-1) > 0 then
        vim.o.statusline = ' ' -- set an empty statusline till lualine loads.
      end
    end,
    keys = {
      { '<leader>bP', '<cmd>LualineBuffersJump 1<cr>', desc = 'Switch to first buffer', mode = { 'n', 'v' } },
      { '<leader>bN', '<cmd>LualineBuffersJump $<cr>', desc = 'Switch to last buffer', mode = { 'n', 'v' } },
    },
    opts = { -- NOTE: For more options, see `:help lualine-Available-options`.
      options = {
        icon_enabled = vim.g.have_nerd_font,
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        globalstatus = true,          -- One statusline for all window splits.
        always_divide_middle = false, -- More space for buffers and filename.
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
          {
            'filename',
            path = 1, -- Show relative path.
          },
        },
        lualine_x = {
          { 'filetype', colored = false },
          { 'encoding', separator = '' },
          { 'fileformat', padding = { left = 0, right = 1 } },
        },
        lualine_y = { '%p%%' },
        lualine_z = { '%l/%L:%c' },
      },
      tabline = {
        lualine_a = {
          {
            'buffers',
            mode = 4, -- Show buffer number and buffer name.
            use_mode_colors = true, -- Sync color with current mode.
            show_filename_only = false, -- Show shortened relative path.
            show_modified_status = false,
            filetype_names = {
              TelescopePrompt = 'Telescope',
              fzf = 'Fuzzy Find',
              ['neo-tree'] = 'File System',
              ['neo-tree-preview'] = 'File Preview',
              ['neo-tree-popup'] = 'Popup',
              NVimTree = 'File System',
              ['spectre_panel'] = 'Search/Replace',
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
          },
        },
      },
      extensions = { 'neo-tree', 'lazy' },
    },
  },

  { -- Visual indent guides. See `:help indent-blankline`.
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      local hooks = require('ibl.hooks')
      hooks.register(
        hooks.type.HIGHLIGHT_SETUP,
        function()
          vim.api.nvim_set_hl(0, 'IblScope', { fg = '#A89984' }) -- gruvbox-material grey2.
        end
      )

      require('ibl').setup({
        indent = { char = '▏', tab_char = '▏', highlight = 'IblIndent' },
        scope = { show_start = true, show_end = false, highlight = 'IblScope' },
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
      })
    end,
    main = 'ibl',
  },

  { -- Useful plugin to show pending keybinds. See `:help which-key.nvim`
    'folke/which-key.nvim',
    event = 'VeryLazy',
    config = function()
      local wk = require('which-key')
      wk.setup({ plugins = { spelling = true } })
      wk.add({ -- NOTE: Document existing key chains here.
        {
          mode = { 'n', 'v' },
          { '<leader>b', group = 'buffer' },
          { '<leader>b_', hidden = true },
          { '<leader>c', group = 'code' },
          { '<leader>c_', hidden = true },
          { '<leader>d', group = 'diagnostics' },
          { '<leader>d_', hidden = true },
          { '<leader>f', group = 'find (search)' },
          { '<leader>f_', hidden = true },
          { '<leader>g', group = 'goto' },
          { '<leader>g_', hidden = true },
          { '<leader>h', group = 'hunk' },
          { '<leader>h_', hidden = true },
          { '<leader>q', group = 'session' },
          { '<leader>q_', hidden = true },
          { '<leader>r', group = 'rename' },
          { '<leader>r_', hidden = true },
          { '<leader>s', group = 'surround' },
          { '<leader>s_', hidden = true },
          { '<leader>t', group = 'toggle' },
          { '<leader>t_', hidden = true },
          { '<leader>w', group = 'workspace' },
          { '<leader>w_', hidden = true },
          { '[', group = 'prev' },
          { ']', group = 'next' },
          { 'z', group = 'view' },
        },
      })
    end,
  },

}
