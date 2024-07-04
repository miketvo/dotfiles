return {

  { -- Debug Adapter Protocol client. See `:help dap-adapter`.
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'theHamsta/nvim-dap-virtual-text',
      'nvim-lua/plenary.nvim',
    },
    keys = {
      { '<leader>k', '', desc = '+debug', mode = {'n', 'v'} },
      { '<leader>kB', function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = 'Breakpoint Condition' },
      { '<leader>kb', function() require('dap').toggle_breakpoint() end, desc = 'Toggle Breakpoint' },
      { '<leader>kc', function() require('dap').continue() end, desc = 'Continue' },
      { '<leader>ka', function() require('dap').continue({ before = get_args }) end, desc = 'Run with Args' },
      { '<leader>kC', function() require('dap').run_to_cursor() end, desc = 'Run to Cursor' },
      { '<leader>kg', function() require('dap').goto_() end, desc = 'Go to Line (No Execute)' },
      { '<leader>ki', function() require('dap').step_into() end, desc = 'Step Into' },
      { '<leader>kj', function() require('dap').down() end, desc = 'Down' },
      { '<leader>kk', function() require('dap').up() end, desc = 'Up' },
      { '<leader>kl', function() require('dap').run_last() end, desc = 'Run Last' },
      { '<leader>ko', function() require('dap').step_out() end, desc = 'Step Out' },
      { '<leader>kO', function() require('dap').step_over() end, desc = 'Step Over' },
      { '<leader>kp', function() require('dap').pause() end, desc = 'Pause' },
      { '<leader>kr', function() require('dap').repl.toggle() end, desc = 'Toggle REPL' },
      { '<leader>kq', function() require('dap').session() end, desc = 'Session' },
      { '<leader>kx', function() require('dap').terminate() end, desc = 'Terminate' },
      { '<leader>kw', function() require('dap.ui.widgets').hover() end, desc = 'Widgets' },
    },
    config = function ()
      vim.api.nvim_set_hl(0, 'DapStoppedLine', { default = true, link = 'Visual' })
      vim.fn.sign_define('DapStopped', { text = '→', texthl = 'DiagnosticWarn', linehl = 'DapStoppedLine', numhl = '' })
      vim.fn.sign_define('DapBreakpoint', { text = '●', texthl = 'DiagnosticInfo', linehl = '', numhl = '' })
      vim.fn.sign_define('DapBreakpointCondition', { text = '', texthl = 'DiagnosticInfo', linehl = '', numhl = '' })
      vim.fn.sign_define('DapBreakpointRejected', { text = '', texthl = 'DiagnosticError', linehl = '', numhl = '' })
      vim.fn.sign_define('LogPoint', { text = '', texthl = 'DiagnosticInfo', linehl = '', numhl = '' })

      local vscode = require('dap.ext.vscode')
      local json = require('plenary.json')
      vscode.json_decode = function(str)
        return vim.json.decode(json.json_strip_comments(str, {}))
      end
    end
  },

  {
    'rcarriga/nvim-dap-ui',
    dependencies = { 'nvim-neotest/nvim-nio' },
    keys = {
      { '<leader>X', function() require('dapui').toggle({ }) end, desc = 'Debug panel' },
      { '<leader>ke', function() require('dapui').eval() end, desc = 'Eval', mode = {'n', 'v'} },
    },
    opts = {},
    config = function(_, opts)
      local dap = require('dap')
      local dapui = require('dapui')
      dapui.setup(opts)
      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open({})
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close({})
      end
      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close({})
      end
    end,
  },

  { 'theHamsta/nvim-dap-virtual-text', opts = {} },

}
