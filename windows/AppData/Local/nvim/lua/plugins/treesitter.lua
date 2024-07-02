return {

  { -- Highlight, edit, and navigate code. See `:help nvim-treesitter`.
    'nvim-treesitter/nvim-treesitter',
    version = false, -- Last release is way too old and doesn't work on Windows.
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufWritePost', 'BufNewFile', 'VeryLazy' },
    lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline.
    init = function(plugin)
      -- PERF: Add nvim-treesitter queries to the rtp and it's custom query predicates early.
      --
      -- This is needed because a bunch of plugins no longer `require('nvim-treesitter')`, which no longer trigger the
      -- **nvim-treesitter** module to be loaded in time. Luckily, the only things that those plugins need are the
      -- custom queries, which we make available during startup.
      require('lazy.core.loader').add_to_rtp(plugin)
      require('nvim-treesitter.query_predicates')
    end,
    cmd = { 'TSUpdateSync', 'TSUpdate', 'TSInstall' },
    opts = {
      ensure_installed = {
        'c', 'cpp', 'c_sharp',
        'make', 'cmake',
        'bash',
        'bibtex', 'latex',
        'html', 'css', 'javascript', 'typescript', 'jsdoc',
        'json', 'hjson', 'jsonc',
        'php', 'phpdoc',
        'gdscript', 'gdshader', 'godot-resource',
        'git_config', 'git_rebase', 'gitignore', 'gitattributes',
        'sql', 'graphql',
        'java',
        'lua', 'luadoc',
        'perl',
        'python', 'pymanifest', 'requirements',
        'markdown', 'markdown_inline',
        'ninja',
        'regex',
        'ruby',
        'toml',
        'xml', 'yaml',
        'ini',
        'typespec',
        'vim', 'vimdoc',
      },
      highlight = {
        enable = true,
        disable = function(lang, buf)
          local max_filesize = 20480 * 1024 -- 20 MB - equal to that of VS Code.
          local disabled_langs = { -- NOTE: These are the names of the parsers and not the filetype. Add more as needed.
            -- 'vimdoc',
          }
          local enabled = false
          for disabled_lang in disabled_langs do
            if lang == disabled_lang then
              enabled = true
              break
            end
          end

        ---@diagnostic disable-next-line: undefined-field
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if enabled and ok and stats and stats.size > max_filesize then
              return true
          end
        end,
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = {
        enable = true,
        disable = { 'ruby' },
      },
    },
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end,
  },

  { -- Automatically add closing tags for HTML and JSX. See `:help nvim-ts-autotag-usage`.
    'windwp/nvim-ts-autotag',
    opts = {
      opts = {
        enable_close = true, -- Auto close tags,
        enable_rename = true, -- Auto rename pairs of tags.
        enable_close_on_slash = false -- Auto close on trailing </.
      },
      -- Override individual filetype configs, these take priority.
      per_filetype = {
        -- ['html'] = {
        --   enable_close = false
        -- }
      },
    },
    config = function(_, opts)
      require('nvim-ts-autotag').setup(opts)
    end,
  },

}
