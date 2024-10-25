return {
  'mfussenegger/nvim-dap',
  dependencies = {
    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add debuggers here
    'mfussenegger/nvim-dap-python',
  },
  keys = function(_)
    local dap = require 'dap'
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
    local dap = require 'dap'
    vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})

    require('mason-nvim-dap').setup {
      automatic_installation = true,
      handlers = {},
      ensure_installed = {
        'python',
      },
    }
    dap.configurations.python = {
      {
        name = "Run Scenario",
        type = "python",
        request = "launch",
        program = "${workspaceFolder}",
        console = "integratedTerminal",
      }
    }

    dap.defaults.fallback.terminal_win_cmd = 'ToggleTerm'
    dap.defaults.fallback.focus_terminal = true

    local dap_python = require("dap-python")
    local venv_python_path = vim.fn.getcwd() .. '/venv/bin/python'
    dap_python.setup(venv_python_path)

    local test_runners = require('dap-python').test_runners
    -- Custom test runner for Behave
    test_runners.behave = function(classnames, methodname)
      local args = {}

      -- Add the feature file path
      local feature_file = "features/" .. classnames[1]
      print("feature path: ", feature_file)

      -- If a specific scenario name is provided, include it in the arguments
      if methodname then
        table.insert(args, "-n")
        table.insert(args, methodname)
      end

      -- Return the module name and the arguments for Behave
      return 'behave', { feature_file, "--no-capture", unpack(args) }
    end

    -- use launch.json for configuration
    require('dap.ext.vscode').load_launchjs(nil, nil)

    vim.env.PYTHONPATH = vim.fn.getcwd()


    local get_string_of_visual_selection = function()
      local _, srow, scol = unpack(vim.fn.getpos('v'))
      local _, erow, ecol = unpack(vim.fn.getpos('.'))
      if vim.fn.mode() == 'v' then
        local text
        if srow < erow or (srow == erow and scol <= ecol) then
          text = vim.api.nvim_buf_get_text(0, srow - 1, scol - 1, erow - 1, ecol, {})
        else
          text = vim.api.nvim_buf_get_text(0, erow - 1, ecol - 1, srow - 1, scol, {})
        end

        return table.concat(text, "\n")
      end

      return ""
    end

    -- Function to run the test based on the selected scenario name
    local run_behave_scenario = function()
      local visual_selection = get_string_of_visual_selection()

      -- Prepare the feature file path
      local feature_file = vim.fn.getcwd() .. "/features/"  -- Update as needed

      -- Run the DAP command
      dap.run({
          type = "python",
          request = "launch",
          name = "Run Behave Scenario",
          program = "${workspaceFolder}/venv/bin/behave",
          args = {
              feature_file,
              "--no-capture",
              "--no-color",
              "-n",
              visual_selection -- Use the selected scenario name
          },
          cwd = vim.fn.getcwd(),
          console = "integratedTerminal"
      })
    end

    -- Create a command or key mapping to invoke the function
    vim.keymap.set('v', '<leader>t', function() run_behave_scenario() end, { noremap = true, silent = true })
  end,
}
