return {

  { -- See `:help comment-nvim`
    'numToStr/Comment.nvim',
    event = 'VimEnter',
    opts = {
      toggler = {
          line = 'gcc',  -- Line-comment toggle keymap.
          block = 'gbc', -- Block-comment toggle keymap.
      },
      opleader = {       --[[ LHS of operator-pending mappings in NORMAL and VISUAL mode ]]
          line = 'gc',   -- Line-comment keymap.
          block = 'gb',  -- Block-comment keymap.
      },
      extra = {          --[[ LHS of extra mappings ]]
          above = 'gcO', -- Add comment on the line above.
          below = 'gco', -- Add comment on the line below.
          eol = 'gcA',   -- Add comment at the end of line.
      },
      -- Enable keybindings.
      -- NOTE: If given `false` then the plugin won't create any mappings.
      mappings = {
          basic = true,  -- Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`.
          extra = true,  -- Extra mapping; `gco`, `gcO`, `gcA`.
      },
    },
  },

  { -- Automatically manage character pairs .See `:help mini.pairs`.
    'echasnovski/mini.pairs',
    version = false, -- Recommended.
    event = 'VeryLazy',
    keys = {
      {
        '<leader>tp',
        function()
          vim.g.minipairs_disable = not vim.g.minipairs_disable
          if vim.g.minipairs_disable then
            vim.cmd('echo "Auto-pairs disabled"')
          else
            vim.cmd('echo "Auto-pairs enabled"')
          end
        end,
        desc = 'Toggle auto-pairs',
      },
    },
    opts = {
      modes = { insert = true, command = true, terminal = false },
      -- Skip autopair when next character is one of these.
      skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
      -- Skip autopair when the cursor is inside these treesitter nodes,
      skip_ts = { "string" },
      -- Skip autopair when next character is closing pair and there are more closing pairs than opening pairs.
      skip_unbalanced = true,
      -- Better deal with markdown code blocks.
      markdown = true,
    },
  },

  { -- Surround actions. Similar to tpope/vim-surround, but more advanced. See `:help mini.surround`.
    'echasnovski/mini.surround',
    version = false, -- Recommended.
    keys = { -- This is for which-key documentation.
      { '<leader>sa', desc = 'Add surround', mode = { 'n', 'v' } },
      { '<leader>sd', desc = 'Delete surround' },
      { '<leader>sf', desc = 'Find right surround' },
      { '<leader>sF', desc = 'Find left surround' },
      { '<leader>sh', desc = 'Highlight surround' },
      { '<leader>sc', desc = 'Change surround' },
      { '<leader>sl', desc = 'Update surround n_lines' },
      { '<leader>sN', desc = 'Last surround' },
      { '<leader>sn', desc = 'Next surround' },
    },
    opts = {
      n_lines = 20,
      mappings = {
        add = '<leader>sa',            -- Add surrounding in Normal and Visual modes.
        delete = '<leader>sd',         -- Delete surrounding.
        find = '<leader>sf',           -- Find surrounding (to the right).
        find_left = '<leader>sF',      -- Find surrounding (to the left).
        highlight = '<leader>sh',      -- Highlight surrounding.
        replace = '<leader>sc',        -- Change surrounding.
        update_n_lines = '<leader>sl', -- Update `n_lines`.
        suffix_last = '<leader>sN',    -- Suffix to search with "prev" method.
        suffix_next = '<leader>sn',    -- Suffix to search with "next" method.
      },
    },
  },

  { -- Quick and dirty indent text object. See `:help indent-object.txt`.
    'michaeljsmith/vim-indent-object',
    event = 'VeryLazy',
  },

  { -- Better text objects. See `:help mini.ai`
    'echasnovski/mini.ai',
    version = false, -- Recommended.
    event = 'VeryLazy',
    opts = {
      n_lines = 500,
      mappings = {
        -- Main textobject prefixes
        around = 'a',
        inside = 'i',

        -- Next/last variants
        around_next = 'an',
        inside_next = 'in',
        around_last = 'aN',
        inside_last = 'iN',

        -- Move cursor to corresponding edge of `a` textobject
        goto_left = 'g[',
        goto_right = 'g]',
      },
    },
  },

  { -- See `:help todo-comments.nvim`.
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = 'VimEnter',
    opts = { signs = false },
  },

  { -- See `:help `colorizer.lua`
    'norcalli/nvim-colorizer.lua',
    enabled = vim.opt.termguicolors,
    event = 'VimEnter',
    opts = { '*', '!txt', '!md' },
  },

}
