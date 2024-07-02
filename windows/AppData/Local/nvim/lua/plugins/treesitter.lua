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
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = {
        enable = true,
        disable = { 'ruby' },
      },
      ensure_installed = {
        'bash',
        'c',
        'cpp',
        'diff',
        'html',
        'java',
        'javascript',
        'jsdoc',
        'json',
        'jsonc',
        'lua',
        'luadoc',
        'luap',
        'markdown',
        'markdown_inline',
        'printf',
        'python',
        'query',
        'regex',
        'toml',
        'tsx',
        'typescript',
        'vim',
        'vimdoc',
        'xml',
        'yaml',
      },
    },
  },

  { -- Automatically add closing tags for HTML and JSX.
    'windwp/nvim-ts-autotag',
    event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
    opts = {},
  },

}
