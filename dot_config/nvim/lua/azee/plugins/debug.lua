return {
  {
    'mfussenegger/nvim-dap',
    cmd = { 'DebugStart', 'DebugStop', 'DebugToggleBreakpoint', 'DebugContinue' },
    optional = true,
    dependencies = {
      'mfussenegger/nvim-dap-python',
      {
        'rcarriga/nvim-dap-ui',
        dependencies = {
          'nvim-telescope/telescope-dap.nvim',
          'nvim-neotest/nvim-nio',
        },
      },
      {
        'theHamsta/nvim-dap-virtual-text',
        opts = {},
      },
      {
        'LiadOz/nvim-dap-repl-highlights',
        opts = true,
      },
    },
    config = function()
      local dap = require 'dap'
      local dapui = require 'dapui'

      -- Keymaps
      vim.keymap.set('n', '<leader>dc', dap.continue, { desc = 'Debug: Start/Continue' })
      vim.keymap.set('n', '<leader>dt', dap.terminate, { desc = 'Debug: Terminate' })
      vim.keymap.set('n', '<leader>dd', function()
        dap.disconnect()
        dapui.close()
      end, { desc = 'Degbugger: Disconnect' })
      vim.keymap.set('n', '<leader>df', '<cmd>Telescope dap frames<cr>')
      vim.keymap.set('n', '<leader>dh', '<cmd>Telescope dap commands<cr>')
      vim.keymap.set('n', '<leader>dL', '<cmd>Telescope dap configurations<cr>')
      vim.keymap.set('n', '<leader>dv', '<cmd>Telescope dap variables<cr>')
      vim.keymap.set('n', '<leader>di', dap.step_into, { desc = 'Debug: Step Into' })
      vim.keymap.set('n', '<leader>do', dap.step_over, { desc = 'Debug: Step Over' })
      vim.keymap.set('n', '<leader>dO', dap.step_out, { desc = 'Debug: Step Out' })
      vim.keymap.set('n', '<leader>lb', '<cmd>Telescope dap list_breakpoints<cr>', { desc = 'Debug: List Breakpoints' })
      vim.keymap.set('n', '<leader>cb', dap.clear_breakpoints, { desc = 'Debug: Clear Breakpoints' })
      vim.keymap.set('n', '<leader>tB', function()
        dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end, { desc = 'Debug: Set Breakpoint' })
      vim.keymap.set('n', '<leader>dl', dapui.toggle, { desc = 'Debug: See last session result.' })

      -- DAP UI
      dapui.setup()
      dap.listeners.after.event_initialized['dapui_config'] = dapui.open
      dap.listeners.before.attach['dapui_config'] = dapui.open
      dap.listeners.before.launch['dapui_config'] = dapui.open
      dap.listeners.before.event_terminated['dapui_config'] = dapui.close
      dap.listeners.before.event_exited['dapui_config'] = dapui.close
    end,
  },
  {
    'mfussenegger/nvim-dap-python',
    lazy = true,
    config = function()
      local dap_python = require 'dap-python'
      dap_python.setup '/Users/aizazshahid/.pyenv/versions/3.11.0/bin/python3.11'
      dap_python.test_runner = 'pytest'

      -- Custom Configurations
      table.insert(require('dap').configurations.python, {
        type = 'python',
        request = 'launch',
        name = 'Debug: SAS Current File',
        python = '/Users/aizazshahid/Flexciton/dev/platform/schedule_analyser_service/.venv/bin/python',
        program = '${file}',
        console = 'integratedTerminal',
        cwd = '${workspaceFolder}',
      })
    end,
  },
}
