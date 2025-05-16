return {

  -- Behave testing finding steps
  {
  -- "avanzzzi/behave.vim",
  "bridgerbrown/behave.vim",
  config = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "cucumber", -- Only affects .feature files
      callback = function()
        vim.keymap.set("v", "<leader>b", ":call behave#goto_step_definition()<CR>", { buffer = true })
      end,
    })
  end,

  },
  {
    'mfussenegger/nvim-dap',

    dependencies = {
      -- "nvim-neotest/nvim-nio",
      -- "rcarriga/nvim-dap-ui",
      -- "theHamsta/nvim-dap-virtual-text",

      -- Installs the debug adapters for you
      'williamboman/mason.nvim',
      'jay-babu/mason-nvim-dap.nvim',

      -- Language Debuggers
      'mfussenegger/nvim-dap-python',

      'akinsho/toggleterm.nvim',
    },

    keys = function(_)
      local dap = require('dap')
      local dap_python = require('dap-python')

      -- local dapui = require('dapui')
      -- require('dapui').setup({})
      -- require("nvim-dap-virtual-text").setup({
      --   commented = true, -- Show virtual text alongside comment
      -- })
      -- -- Automatically open/close DAP UI
      -- dap.listeners.after.event_initialized["dapui_config"] = function()
      --   dapui.open()
      -- end
      -- vim.keymap.set("n", "<leader>du", function()
      --   dapui.toggle()
      -- end, { noremap = true, silent = true } )

      dap_python.setup("python3")

      vim.fn.sign_define('DapBreakpoint', {text='🔴', texthl='', linehl='', numhl=''})
      vim.fn.sign_define('DapBreakpointRejected', {text='❌', texthl='', linehl='', numhl=''})
      vim.fn.sign_define('DapStopped', {text='⭕', texthl='', linehl='Visual', numhl=''})

      return {
        { '<F5>', dap.continue, desc = 'Debug: Start/Continue' },
        { '<F4>', dap.pause, desc = 'Debug: Pause' },
        { '<F1>', dap.step_into, desc = 'Debug: Step Into' },
        { '<F2>', dap.step_over, desc = 'Debug: Step Over' },
        { '<F3>', dap.step_out, desc = 'Debug: Step Out' },
        { '<F6>', dap.terminate, desc = 'Debug: Terminate' },
        { '<leader>db', dap.toggle_breakpoint, desc = 'Debug: Toggle Breakpoint' },
        {
          '<leader>dB',
          function()
            dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
          end,
          desc = 'Debug: Set Breakpoint',
        },
        { '<leader>tl', dap.run_last, desc = 'Debug: Run Last' },

      }
    end,

    config = function()
      --
      -- PLUGINS SETUP
      --

      local dap = require 'dap'

      -- Create a horizontal split and open DAP in it
      local toggleterm = require('toggleterm')

      vim.keymap.set('n', '<leader>dh', function()
        dap.defaults.fallback.terminal_win_cmd = 'ToggleTerm'
        dap.continue()
      end, { desc = 'DAP: Buffer Below' })

      -- dap.defaults.fallback.terminal_win_cmd = require("FTerm").toggle()
      dap.defaults.fallback.terminal_win_cmd = 'tabnew'
      dap.defaults.fallback.focus_terminal = true

      -- mason-nvim-dap setup
      require('mason-nvim-dap').setup {
        automatic_installation = true,
        handlers = {},
        ensure_installed = {
          'python',
        },
      }

      --
      -- DEBUGGERS
      --

      -- Python debugger setup
      local python_debugger = require('plugins.debug.python_debugger')
      python_debugger(dap)

      -- Behave (testing framework) debugger setup
      local python_test_runner = require('dap-python').test_runners
      local behave_debugger = require('plugins.debug.behave_debugger')
      behave_debugger(dap, python_test_runner)
    end,
  },

}
