return {

  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    keys = {
      {
        '<leader>fe',
        function()
          require('neo-tree.command').execute({ toggle = true })
        end,
        desc = '[F]ile [E]xplorer',
      },
      { '<leader>e', '<leader>fe', desc = 'File [E]xplorer', remap = true },
    },
    deactivate = function()
      vim.cmd('Neotree close')
    end,
    init = function()
      -- FIX: using `autocmd` for lazy-loading Neo-tree instead of directly requiring it, because `cwd` is not set up
      -- properly. This properly disables netrw for Neo-tree to take over.
      vim.api.nvim_create_autocmd('BufEnter', {
        group = vim.api.nvim_create_augroup('Neotree_start_directory', { clear = true }),
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
    opts = {
      filesystem = {
        hijack_netrw_behavior = 'open_current',
        bind_to_cwd = true,
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
      }
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
      -- '3rd/image.nvim', -- Optional image support in preview window: See `# Preview Mode` for more information
    }
  },

}
