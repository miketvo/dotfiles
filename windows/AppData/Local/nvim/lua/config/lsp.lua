---------------------------------
-- [[ LANGUAGE SERVER SETUP ]] --
-- See https://github.com/neovim/nvim-lspconfig/tree/master/lua/lspconfig/server_configurations
---------------------------------

-- NOTE: Ensure the following language servers are automatically installed.
-- See `:help lspconfig-all` for a list of all the pre-configured LSPs
--
--  Add any additional override configuration in the following tables. Available keys are:
--    - cmd (table): Override the default command used to start the server
--    - filetypes (table): Override the default list of associated filetypes for the server
--    - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
--    - settings (table): Override the default settings passed when initializing the server.
-- For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
-- NOTE: This is a custom variable.
vim.g.lsp_server_configs = {
  clangd = {},
  gdscript = {},
  gdshader_lsp = {},
  pyright = {
    settings = {
      python = {
        analysis = {
          typeCheckingMode = 'off',
          useLibraryCodeForTypes = true,
          diagnosticMode = 'workspace',
        }
      },
    },
  },
  jdtls = {},
  ts_ls = {},
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
}

-- NOTE: Do any additional lsp server setup here. Return true if you don't want this server to be setup with
-- lspconfig.
-- NOTE: This is a custom variable.
vim.g.lsp_setups = {
  -- example to setup with typescript.nvim
  -- tsserver = function(_, opts)
  --   require('typescript').setup({ server = opts })
  --   return true
  -- end,
  -- Specify * to use this function as a fallback for any server
  -- ['*'] = function(server, opts) end,
}
