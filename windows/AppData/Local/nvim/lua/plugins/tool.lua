return {

  { -- Easily install and manage LSP servers, DAP servers, linters, and formatters.
    -- See `mason.nvim`.
    'williamboman/mason.nvim',
    cmd = 'Mason',
    keys = { { '<leader>m', '<cmd>Mason<cr>', desc = 'Tool manager' } },
    build = ':MasonUpdate',
    opts = {
      ensure_installed = {
        -- Formatters.
        'shfmt',
        'stylua',
        'prettier',
        'black',

        -- CLI tools.
        'tree-sitter-cli',
      },
    },
    ---@param opts MasonSettings | {ensure_installed: string[]}
    config = function(_, opts)
      require('mason').setup(opts)
      local mr = require('mason-registry')
      mr:on('package:install:success', function()
        vim.defer_fn(function()
          -- Trigger FileType event to possibly load this newly installed LSP server.
          require('lazy.core.handler.event').trigger({
            event = 'FileType',
            buf = vim.api.nvim_get_current_buf(),
          })
        end, 100)
      end)

      mr.refresh(function()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end)
    end,
  },

}
