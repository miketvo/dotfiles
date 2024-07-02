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
      ensure_installed = 'all',
    },
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
