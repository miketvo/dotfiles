return {

  { -- Autoformat. See `:help conform-formatters`.
    'stevearc/conform.nvim',
    dependencies = { 'mason.nvim' },
    cmd = 'ConformInfo',
    keys = {
      {
        '<leader>bf',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        mode = 'n',
        desc = 'Format buffer',
      },
      {
        '<leader>bf',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        mode = 'v',
        desc = 'Format selection',
      },
      {
        '<leader>bF',
        function()
          require('conform').format({ formatters = { 'injected' }, timeout_ms = 3000 })
        end,
        mode = { 'n', 'v' },
        desc = 'Format injected languages',
      },
    },
    opts = {
      format = {
        timeout_ms = 3000,
        async = false,           -- Not recommended to change.
        quiet = false,           -- Not recommended to change.
        lsp_format = 'fallback', -- Not recommended to change.
      },
      ---@type table<string, conform.FormatterUnit[]>
      formatters_by_ft = {
        sh = { 'shfmt' },
        lua = { 'stylua' },
        python = { { 'isort', 'black' } },
        javascript = { { 'prettierd', 'prettier' } },
      },
      -- The options you set here will be merged with the builtin formatters.
      -- You can also define any custom formatters here.
      ---@type table<string, conform.FormatterConfigOverride|fun(bufnr: integer): nil|conform.FormatterConfigOverride>
      formatters = {
        injected = { options = { ignore_errors = true } },
        -- # Example of using dprint only when a dprint.json file is present:
        -- dprint = {
        --   condition = function(ctx)
        --     return vim.fs.find({ 'dprint.json' }, { path = ctx.filename, upward = true })[1]
        --   end,
        -- },
        --
        -- # Example of using shfmt with extra args
        -- shfmt = {
        --   prepend_args = { '-i', '2', '-ci' },
        -- },
      },
    },
  },

}
