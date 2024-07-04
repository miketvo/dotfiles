return {

  { -- Powerful fuzzy finder. See `:help telescope`.
    --
    -- Telescope is a fuzzy finder that comes with a lot of different things that it can fuzzy find! It's more than
    -- just a "file finder", it can search many different aspects of Neovim, your workspace, LSP, and more!
    --
    -- The easiest way to use Telescope, is to start by doing something like:
    --   `:Telescope help_tags` or `<leader>fh`.
    --
    -- After running this command, a window will open up and you're able to type in the prompt window. You'll see a
    -- list of `help_tags` options and a corresponding preview of the help.
    --
    -- NOTE: Two important keymaps to use while in Telescope are:
    --  - Insert mode: `<c-/>`.
    --  - Normal mode: `?`.
    --
    -- This opens a window that shows you all of the keymaps for the current Telescope picker. This is really useful to
    -- discover what Telescope can do as well as how to actually do it!
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      { -- If encountering errors, see telescope-fzf-native README for installation instructions.
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
    },
    event = 'VimEnter',
    config = function()
      local telescope = require('telescope')
      telescope.setup({ -- NOTE: See `:help.telescope.setup()` for mor options here.
        extensions = {
          fzf = {
            fuzzy = true,                   -- false will only do exact matching.
            override_generic_sorter = true, -- override the generic sorter.
            override_file_sorter = true,    -- override the file sorter.
            case_mode = 'smart_case',       -- 'smart_case', 'ignore_case' or 'respect_case'.
          },
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      })

      -- Enable Telescope extensions if they are installed.
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- Keymap. See `:help telescope.builtin`.
      local map = vim.keymap
      local builtin = require 'telescope.builtin'
      map.set('n', '<leader>fh', builtin.help_tags, { desc = 'Search help' })
      map.set('n', '<leader>fk', builtin.keymaps, { desc = 'Search keymaps' })
      map.set('n', '<leader>ff', builtin.find_files, { desc = 'Search files' })
      map.set('n', '<leader>fs', builtin.builtin, { desc = 'Search telescope.builtin' })
      map.set('n', '<leader>fw', builtin.grep_string, { desc = 'Search current WORD' })
      map.set('n', '<leader>fg', builtin.live_grep, { desc = 'Search by grep' })
      map.set('n', '<leader>fd', builtin.diagnostics, { desc = 'Search diagnostics' })
      map.set('n', '<leader>fr', builtin.registers, { desc = 'Search registers' })
      map.set('n', '<leader>f.', builtin.oldfiles, { desc = 'Search recent files' })
      map.set('n', '<leader><leader>', builtin.buffers, { desc = 'Find buffers' })
      map.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
          previewer = false,
        }))
      end, { desc = 'Fuzzy search current buffer' })
      map.set('n', '<leader>f/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live grep in open files',
        }
      end, { desc = 'Search in open files' })

      -- Eye candy stuff.
      local TelescopePrompt = {
        TelescopeNormal = {
          bg = '#252931', -- nord-1.
        },
        TelescopeSelection = {
          bg = '#2E3440', -- nord0.
        },
        TelescopeBorder = {
          fg = '#252931', -- nord-1.
          bg = '#252931', -- nord-1.
        },
        TelescopePromptNormal = {
          bg = '#3B4252', -- nord1.
        },
        TelescopePromptCounter = {
          fg = '#5E81AC', -- nord10.
        },
        TelescopePromptBorder = {
          fg = '#3B4252', -- nord1.
          bg = '#3B4252', -- nord1.
        },
        TelescopePromptTitle = {
          fg = '#252931', -- nord-1.
          bg = '#88C0D0', -- nord4.
          bold = true,
        },
        TelescopeResultsTitle = {
          fg = '#252931', -- nord-1.
          bg = '#B48EAD', -- nord15.
          bold = true,
        },
        TelescopePreviewTitle = {
          fg = '#252931', -- nord-1.
          bg = '#A3BE8C', -- nord14.
          bold = true,
        },
        TelescopePreviewLine = {
          bg = '#2E3440', -- nord0.
        },
      }
      for hl, col in pairs(TelescopePrompt) do
        vim.api.nvim_set_hl(0, hl, col)
      end
    end,
  },

  { -- Filesystem explorer. See `:help neo-tree`.
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      -- '3rd/image.nvim', -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    keys = {
      { -- For completeness.
        '<leader>te',
        function()
          require('neo-tree.command').execute({ toggle = true })
          vim.cmd('execute "normal \\<c-w>="') -- Automatically resize splits.
        end,
        desc = 'Toggle file explorer',
      },
      { '<leader>e', '<leader>te', desc = 'File explorer', remap = true }, -- For convenience.
    },
    deactivate = function()
      vim.cmd('Neotree close')
    end,
    init = function()
      -- HACK: Workaround using `autocmd` for lazy-loading Neo-tree instead of directly requiring it, because `cwd` is
      -- not set up properly. This properly disables netrw for Neo-tree to take over.
      vim.api.nvim_create_autocmd('BufEnter', {
        group = vim.api.nvim_create_augroup('plugin-neotree-start-directory', { clear = true }),
        desc = 'Start Neo-tree with directory',
        once = true,
        callback = function()
          if package.loaded['neo-tree'] then
            return
          else
            ---@diagnostic disable-next-line: param-type-mismatch
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
          bind_to_cwd = false, -- This must be set to false for persistence.nvim to work. See the fix above.
          follow_current_file = { enabled = true },
          use_libuv_file_watcher = true,
          filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = false,
            hide_by_name = { '.git' },
          },
        },
        popup_border_style = 'NC',
        default_component_configs = {
          indent = {
            with_expanders = true, -- if nil and file nesting is enabled, will enable expanders.
            expander_collapsed = '',
            expander_expanded = '',
            expander_highlight = 'NeoTreeExpander',
          },
          git_status = {
            symbols = {
              unstaged = '󰄱',
              staged = '󰱒',
            },
          },
        },
      })

      -- Eye candy stuff.
      vim.cmd.highlight('NeoTreeDimText guifg=#434C5E')                   -- nord1.
      vim.cmd.highlight('NeoTreeDotfile guifg=#4C566A')                   -- nord3.
      vim.cmd.highlight('NeoTreeFileStatsHeader guifg=#4C566A')           -- nord3.
      vim.cmd.highlight('NeoTreeFileStats guifg=#4C566A')                 -- nord3.
      vim.cmd.highlight('NeoTreeMessage guifg=#4C566A')                   -- nord3.
      vim.cmd.highlight('NeoTreeFloatBorder ctermfg=Black guifg=#252931') -- no border.
      vim.cmd.highlight('NeoTreeFloatTitle gui=bold guibg=#252931')       -- blended.
      vim.cmd.highlight('NeoTreeTitleBar gui=bold guibg=#252931')         -- blended.
    end,
  },

  { -- Pretty diagnostics, references, telescope results, quickfix and location list. See `:help trouble.nvim`.
    'folke/trouble.nvim',
    cmd = { 'Trouble' },
    keys = {
      { '<leader>dx', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Workspace diagnostics' },
      { '<leader>dX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Buffer diagnostics' },
      {
        '<leader>o',
        '<cmd>Trouble symbols toggle focus=false win.position=right<cr>',
        desc = 'Symbols outline'
      },
      {
        '<leader>O',
        '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
        desc = 'LSP symbols outline',
      },
      { '<leader>dL', '<cmd>Trouble loclist toggle<cr>', desc = 'Diagnostic location list' },
      { '<leader>dq', '<cmd>Trouble qflist toggle<cr>', desc = 'Quickfix list' },
    },
    config = function ()
      require('trouble').setup({})
      vim.cmd.highlight('TroubleNormal ctermbg=None guibg=None') -- Transparent background.
      vim.cmd.highlight('TroubleNormalNC ctermbg=None guibg=None') -- Transparent background.
    end,
  },

  { -- Search/replace panel across files. See `:help spectre.txt` for more details and caveats.
    -- NOTE: Does not support undo. Always save your file first!
    'nvim-pack/nvim-spectre',
    build = false,
    cmd = 'Spectre',
    keys = {
      {'<leader>fR', function() require('spectre').open() end, desc = 'Search/replace across files'},
    },
    opts = {
      color_devicons = vim.g.have_nerd_font,
      open_cmd = 'noswapfile vnew',
      lnum_for_results = true, -- show line number for search/replace results
    },
  },

  { -- Display and manipulate git hunks from the gutter. See `:help gitsigns`.
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
        map({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>', 'Stage Hunk')
        map({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>', 'Reset Hunk')
        map('n', '<leader>hS', gs.stage_buffer, 'Stage Buffer')
        map('n', '<leader>hu', gs.undo_stage_hunk, 'Undo Stage Hunk')
        map('n', '<leader>hR', gs.reset_buffer, 'Reset Buffer')
        map('n', '<leader>hp', gs.preview_hunk_inline, 'Preview Hunk Inline')
        map('n', '<leader>hb', function() gs.blame_line({ full = true }) end, 'Blame Line')
        map('n', '<leader>hB', function() gs.blame() end, 'Blame Buffer')
        map('n', '<leader>hd', gs.diffthis, 'Diff This')
        map('n', '<leader>hD', function() gs.diffthis('~') end, 'Diff This ~')
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', 'Inner Hunk')
      end,
    },
  },

}
