return {

  { -- Highlight, edit, and navigate code. See `:help nvim-treesitter`.
    'nvim-treesitter/nvim-treesitter',
    branch = "main",
    version = false, -- Last release is way too old and doesn't work on Windows.
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufWritePost', 'BufNewFile', 'VeryLazy' },
    lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline.
    cmd = { 'TSUpdateSync', 'TSUpdate', 'TSInstall' },

    config = function ()
      vim.env.CC = 'gcc'

      local ts = require('nvim-treesitter')
      ts.setup()

      ts.install({
        'c', 'cpp', 'c_sharp',
        'make', 'cmake',
        'bash',
        'bibtex', 'latex',
        'html', 'css', 'javascript', 'typescript', 'jsdoc',
        'json', 'hjson',
        'php', 'phpdoc',
        'gdscript', 'gdshader', 'godot_resource',
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
      })

      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('UserTreesitterConfig', { clear = true }),
        callback = function(ev)
          local lang = vim.treesitter.language.get_lang(ev.match)
          if not lang then
            return
          end

          -- vimdoc: Disable highlighting.
          if lang ~= 'vimdoc' then
            pcall(vim.treesitter.start, ev.buf, lang)
          end

          -- ruby: Additional vim Regex highlighting.
          if lang == 'ruby' then
            vim.bo[ev.buf].syntax = 'on'
          end

          -- ruby: Disable indentation.
          if lang ~= 'ruby' then
            vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },

  { -- Automatically add closing tags for HTML and JSX. See `:help nvim-ts-autotag-usage`.
    'windwp/nvim-ts-autotag',
    event = { 'BufReadPost', 'BufNewFile' },
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
  },
}
