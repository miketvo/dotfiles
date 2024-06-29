return {

  { -- See `:help neo-tree.txt`.
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    keys = {
      {
        '<leader>e',
        function()
          require('neo-tree.command').execute({ toggle = true })
        end,
        desc = '[F]ile [E]xplorer',
      },
    },
    deactivate = function()
      vim.cmd('Neotree close')
    end,
    init = function()
      -- HACK: Workaround using `autocmd` for lazy-loading Neo-tree instead of directly requiring it, because `cwd` is
      -- not set up properly. This properly disables netrw for Neo-tree to take over.
      vim.api.nvim_create_autocmd('BufEnter', {
        group = vim.api.nvim_create_augroup('neotree-start-directory', { clear = true }),
        desc = 'Start Neo-tree with directory',
        once = true,
       callback = function()
          if package.loaded['neo-tree'] then
            return
          else
            local stats = vim.uv.fs_stat(vim.fn.argv(0))
            if stats and stats.type == 'directory' then
              require('neo-tree')
            end
          end
        end,
      })
    end,
    config = function()
      require('neo-tree').setup({ -- NOTE: For more options, see `:help neo-tree-configuration`.
        sources = { 'filesystem', 'git_status' },
        filesystem = {
          hijack_netrw_behavior = 'open_current',
          bind_to_cwd = true,
          follow_current_file = { enabled = true },
          use_libuv_file_watcher = true,
        },
        popup_border_style = 'NC',
      })

      -- Eye candy stuff.
      vim.cmd.highlight('NeoTreeDimText guifg=#434C5E')                  -- nord1.
      vim.cmd.highlight('NeoTreeDotfile guifg=#4C566A')                  -- nord3.
      vim.cmd.highlight('NeoTreeFileStatsHeader guifg=#4C566A')          -- nord3.
      vim.cmd.highlight('NeoTreeFileStats guifg=#4C566A')                -- nord3.
      vim.cmd.highlight('NeoTreeMessage guifg=#4C566A')                  -- nord3.
      vim.cmd.highlight('NeoTreeFloatBorder ctermfg=Gray guifg=#252931') -- no border.
      vim.cmd.highlight('NeoTreeFloatTitle gui=bold guibg=#252931')      -- blended.
      vim.cmd.highlight('NeoTreeTitleBar gui=bold guibg=#252931')        -- blended.
    end,
    git_status = {
      symbols = {
        unstaged = '󰄱',
        staged = '󰱒',
      },
    },
    dependencies = {
      -- '3rd/image.nvim', -- Optional image support in preview window: See `# Preview Mode` for more information
    }
  },

  { -- Display and manipulate git hunks. See `:help gitsigns.txt`.
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '┃' },
        change = { text = '┃' },
        delete = { text = '▁' },
        topdelete = { text = '▔' },
        changedelete = { text = '┅' },
        untracked = { text = '┇' },
      },
      signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
      numhl = false,     -- Toggle with `:Gitsigns toggle_numhl`
      linehl = false,    -- Toggle with `:Gitsigns toggle_linehl`
      word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
      watch_gitdir = {
        follow_files = true,
      },
      attach_to_untracked = true,
      current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
      },
      current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil, -- Use default
      max_file_length = 40000, -- Disable if file is longer than this (in lines)
      preview_config = { -- Options passed to nvim_open_win
        border = 'single',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1,
      },
      yadm = {
        enable = false
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        -- Keymap.
        -- stylua: ignore start
        map('n', ']h', function()
          if vim.wo.diff then
            vim.cmd.normal({ ']c', bang = true })
          else
            gs.nav_hunk('next')
          end
        end, 'Next Hunk')
        map('n', '[h', function()
          if vim.wo.diff then
            vim.cmd.normal({ '[c', bang = true })
          else
            gs.nav_hunk('prev')
          end
        end, 'Prev Hunk')
        map('n', ']H', function() gs.nav_hunk('last') end, 'Last Hunk')
        map('n', '[H', function() gs.nav_hunk('first') end, 'First Hunk')
        map({ 'n', 'v' }, '<leader>ghs', ':Gitsigns stage_hunk<CR>', 'Stage Hunk')
        map({ 'n', 'v' }, '<leader>ghr', ':Gitsigns reset_hunk<CR>', 'Reset Hunk')
        map('n', '<leader>ghS', gs.stage_buffer, 'Stage Buffer')
        map('n', '<leader>ghu', gs.undo_stage_hunk, 'Undo Stage Hunk')
        map('n', '<leader>ghR', gs.reset_buffer, 'Reset Buffer')
        map('n', '<leader>ghp', gs.preview_hunk_inline, 'Preview Hunk Inline')
        map('n', '<leader>ghb', function() gs.blame_line({ full = true }) end, 'Blame Line')
        map('n', '<leader>ghB', function() gs.blame() end, 'Blame Buffer')
        map('n', '<leader>ghd', gs.diffthis, 'Diff This')
        map('n', '<leader>ghD', function() gs.diffthis('~') end, 'Diff This ~')
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', 'Inner Hunk')
      end,
    },
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
        ["<leader>gh"] = { name = "+hunks", _ = "which_key_ignore" },
      }, { mode = { 'n', 'v' } })
    end,
  },

}
