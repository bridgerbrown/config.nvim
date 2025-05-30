return {
  -- Behave testing
  {
  'bridgerbrown/behave.vim',
  config = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = 'cucumber', -- Only affects .feature files
      callback = function()
        vim.keymap.set("v", "<leader>b", ':call behave#goto_step_definition()<CR>', { buffer = true })
      end,
    })
  end,
  },

  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'nvim-neotest/nvim-nio',  -- Required dependency for nvim-dap-ui
      'rcarriga/nvim-dap-ui', -- Creates a beautiful debugger UI
      'theHamsta/nvim-dap-virtual-text',

      -- Installs the debug adapters for you
      'williamboman/mason.nvim',
      'jay-babu/mason-nvim-dap.nvim',

      -- Language Debuggers
      'mfussenegger/nvim-dap-python',
    },

    keys = function(_)
      local dap = require('dap')
      local dapui = require('dapui')

      return {
        { '<F1>', dap.step_into, desc = 'Debug: Step Into' },
        { '<F2>', dap.step_over, desc = 'Debug: Step Over' },
        { '<F3>', dap.step_out, desc = 'Debug: Step Out' },
        { '<F4>', dap.pause, desc = 'Debug: Pause' },
        { '<F5>', dap.continue, desc = 'Debug: Start/Continue' }, -- start!
        { '<F6>', dap.terminate, desc = 'Debug: Terminate' },
        { '<F7>', dapui.open, desc = 'Dapui: Open' },
        { '<F8>', dapui.toggle, desc = 'Debug: See last session result' },
        { '<leader>db', dap.toggle_breakpoint, desc = 'Debug: Toggle Breakpoint' },
        { '<leader>dB', dap.set_breakpoint, desc = 'Debug: Set Breakpoint' },
        { '<leader>tl', dap.run_last, desc = 'Debug: Run Last' },
      }
    end,

    config = function()
      --
      -- PLUGINS SETUP
      --
      local dap = require('dap')
      local dapui = require('dapui')
      local dap_python = require('dap-python')

      dapui.setup({})
      require('nvim-dap-virtual-text').setup({
        commented = true, -- Show virtual text alongside comment
      })

      require('mason-nvim-dap').setup {
        automatic_installation = true,
        handlers = {},
        ensure_installed = {
          'python',
        },
      }

      dap.listeners.after.event_initialized['dapui_config'] = dapui.open

      --
      -- SYMBOLS
      --
      vim.fn.sign_define('DapBreakpoint', {text='🔴', texthl='', linehl='', numhl=''})
      vim.fn.sign_define('DapBreakpointRejected', {text='❌', texthl='', linehl='', numhl=''})
      vim.fn.sign_define('DapStopped', {text='⭕', texthl='', linehl='Visual', numhl=''})


      --
      -- DEBUGGERS
      --
      -- Python debugger setup
      dap_python.setup('python3')

      -- Behave (testing framework) debugger setup
      local behave_debugger = require('plugins.debug.behave_debugger')
      local python_test_runner = require('dap-python').test_runners
      behave_debugger(dap, python_test_runner)
    end,
  },
}
