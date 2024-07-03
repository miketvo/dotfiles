return {

  { -- LSP configuration & plugins.
    -- See:
    --   - `:help lspconfig`.
    --   - `:help mason.nvim`.
    --   - `:help mason-lspconfig.nvim`.
    'neovim/nvim-lspconfig',
    depedencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'folke/lazydev.nvim',
    },
    opts = {
      -- NOTE: Ensure the following language servers are automatically installed.
      -- See `:help lspconfig-all` for a list of all the pre-configured LSPs
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --    - cmd (table): Override the default command used to start the server
      --    - filetypes (table): Override the default list of associated filetypes for the server
      --    - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --    - settings (table): Override the default settings passed when initializing the server.
      -- For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      servers = {
        clangd = {},
        pyright = {
          settings = {
            python = {
              analysis = {
                useLibraryCodeForTypes = true,
                diagnosticMode = 'workspace',
              }
            },
          },
        },
        jdtls = {},
        tsserver = {},
        lua_ls = {
          -- mason = false, -- Set to false if you don't want this server to be installed with mason.
          -- ---@type LazyKeysSpec[]
          -- keys = {}, -- Use this to add any additional keymaps for specific lsp servers.
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                callSnippet = 'Replace',
              },
              doc = {
                privateName = { '^_' },
              },
              hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = 'Disable',
                semicolon = 'Disable',
                arrayIndex = 'Disable',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      },

      -- NOTE: Do any additional lsp server setup here. Return true if you don't want this server to be setup with
      -- lspconfig.
      setup = {
        -- example to setup with typescript.nvim
        -- tsserver = function(_, opts)
        --   require('typescript').setup({ server = opts })
        --   return true
        -- end,
        -- Specify * to use this function as a fallback for any server
        -- ['*'] = function(server, opts) end,
      },
    },
    config = function(_, opts)
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('plugin-lsp-attach', { clear = true }),
        callback = function(event)
          local client = vim.lsp.get_client_by_id(event.data.client_id)

          -- [[ Keymap ]] --
          -- NOTE: Modify your LSP key bindings here.
          local map = vim.keymap
          map.set('n', '<leader>gd', require('telescope.builtin').lsp_definitions, { desc = 'Goto definition' })
          map.set('n', '<leader>gt', require('telescope.builtin').lsp_type_definitions, { desc = 'Goto type definition' })
          map.set('n', '<leader>gD', vim.lsp.buf.declaration, { desc = 'Goto declaration' })
          map.set('n', '<leader>gr', require('telescope.builtin').lsp_references, { desc = 'Goto references' })
          map.set('n', '<leader>gi', require('telescope.builtin').lsp_implementations, { desc = 'Goto implementation' })
          map.set('n', '<leader>bs', require('telescope.builtin').lsp_document_symbols, { desc = 'Buffer symbols' })
          map.set('n', '<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, { desc = 'Workspace symbols' })
          map.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename symbol' })
          map.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code action' })
          map.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover documentation' }) -- See `:help K` for why this keymap.
          map.set('n', '<leader>K', vim.lsp.buf.hover, { desc = 'Goto hover documentation' }) -- For completeness.
          map.set('n', '<leader>gK', vim.lsp.buf.signature_help, { desc = 'Goto signature help' })
          -- Enable inlay hints in your code, if the language server you are using supports them.
          -- WARN: This may be unwanted, since they displace some of your code. Comment out if needed.
          if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
            map.set('n', '<leader>th', function()
              ---@diagnostic disable-next-line: missing-parameter
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
              ---@diagnostic disable-next-line: missing-parameter
              vim.notify(not vim.lsp.inlay_hint.is_enabled() and 'Inlay hints disabled' or 'Inlay hints enabled', vim.log.levels.INFO)
            end, { desc = 'Toggle inlay hints' })
          end

          -- [[ Quality of life ]]
          -- Highlight references of the word under the cursor when it rests there for a little while. See
          -- `:help CursorHold` for information about when this is executed.
          if client and client.server_capabilities.documentHighlightProvider then
            local highlight_augroup = vim.api.nvim_create_augroup('plugin-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            }) -- Clear highlights on cursor move.
            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })
            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('plugin-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({ group = 'plugin-lsp-highlight', buffer = event2.buf })
              end,
            })
          end
        end,
      })

      -- [[ Capabilities ]] --
      -- By default, Neovim doesn't support everything that is in the LSP specification. When you add nvim-cmp,
      -- luasnip, etc. Neovim now has *more* capabilities.
      -- NOTE: Set up additional LSP capabilities here. Refer to your plugin's documentation.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend( -- hrsh7th/nvim-cmp
        'force',
        capabilities,
        require('cmp_nvim_lsp').default_capabilities()
      )

      -- [[ Mason and mason-lspconfig setup ]]
      -- WARN: DO NOT EDIT THIS SECTION.
      local servers = opts.servers

      local function setup(server)
        local server_opts = vim.tbl_deep_extend('force', {
          capabilities = vim.deepcopy(capabilities),
        }, servers[server] or {})

        if opts.setup[server] then
          if opts.setup[server](server, server_opts) then
            return
          end
        elseif opts.setup['*'] then
          if opts.setup['*'](server, server_opts) then
            return
          end
        end

        require('lspconfig')[server].setup(server_opts)
      end

      -- Get all the servers that are available through mason-lspconfig.
      local have_mason, mlsp = pcall(require, 'mason-lspconfig')
      local all_mslp_servers = {}
      if have_mason then
        all_mslp_servers = vim.tbl_keys(require('mason-lspconfig.mappings.server').lspconfig_to_package)
      end

      local ensure_installed = {} ---@type string[]
      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          if server_opts.enabled ~= false then
            -- Run manual setup if server_opts.mason == false or if this is a server that cannot be installed with
            -- mason-lspconfig.
            if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
              setup(server)
            else
              ensure_installed[#ensure_installed + 1] = server
            end
          end
        end
      end

      if have_mason then
        mlsp.setup({
          ensure_installed = ensure_installed,
          handlers = { setup },
        })
      end
    end,
  },

  { 'williamboman/mason-lspconfig.nvim', config = function() end },

  { -- LuaLS setup for Neovim. See `:help lazydev-nvim-lazydev.nvim`.
    'folke/lazydev.nvim',
    depedencies = { 'Bilal2453/luvit-meta' },
    ft = 'lua', -- Only load on lua files.
    opts = {
      library = {
        'lazy.nvim',
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },

  { 'Bilal2453/luvit-meta', lazy = true }, -- `vim.uv` typings

}
