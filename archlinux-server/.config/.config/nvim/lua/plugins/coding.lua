return {

  { -- Autocompletion. See `:help cmp`.
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = { -- Snippet Engine & its associated nvim-cmp source.
      'L3MON4D3/LuaSnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
    },
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      luasnip.config.setup {}

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert' },

        mapping = cmp.mapping.preset.insert {
          ['<Tab>'] = cmp.mapping.select_next_item(),
          ['<S-Tab>'] = cmp.mapping.select_prev_item(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<C-Space>'] = cmp.mapping.complete({}), -- Manually trigger a completion from nvim-cmp.

          -- Scroll the documentation window back/forward
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),

          -- <c-l> will move you to the right of each of the expansion locations.
          -- <c-h> is similar, except moving you backwards.
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),
          -- Think of <c-l> as moving to the right of your snippet expansion.
          --  So if you have a snippet that's like:
          --  function $name($args)
          --    $body
          --  end

          -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
          --   https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
        },
        sources = {
          { name = 'lazydev', group_index = 0 },
          { name = 'luasnip' },
          { name = 'nvim_lsp' },
          { name = 'path' },
        },
      }
    end,
  },

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
          vim.notify(vim.g.minipairs_disable and 'Auto-pairs disabled' or 'Auto-pairs enabled', vim.log.levels.INFO)
        end,
        desc = 'Toggle auto-pairs',
      },
    },
    opts = {
      modes = { insert = true, command = true, terminal = false },
      skip_next = [=[[%w%%%'%[%"%.%`%$]]=], -- Skip autopair when next character is one of these.
      skip_ts = { 'string' }, -- Skip autopair when the cursor is inside these treesitter nodes,
      skip_unbalanced = true, -- Skip autopair when unbalanced.
      markdown = true, -- Better deal with markdown code blocks.
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
