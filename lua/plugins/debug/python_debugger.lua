local python_debugger = function (dap)
    -- PYTHON ADAPTER
    dap.configurations.python = {
      {
        name = "Debug File",
        type = "python",
        request = "launch",
        program = "${workspaceFolder}",
        console = "integratedTerminal",
      }
    }
    local dap_python = require("dap-python")
    -- local venv_python_path = vim.fn.getcwd() .. '/venv/bin/python'
    -- dap_python.setup(venv_python_path)
    -- vim.env.PYTHONPATH = vim.fn.getcwd()

    dap_python.test_runner = 'pytest'

    vim.keymap.set("n", "<leader>dn", function() require("dap-python").test_method() end, { silent = true, noremap = true })
    vim.keymap.set("n", "<leader>df", function() require("dap-python").test_class() end, { silent = true, noremap = true })
    vim.keymap.set("v", "<leader>ds", function()
      vim.cmd("normal! <Esc>") -- exit visual mode before running the function
      require("dap-python").debug_selection()
    end, { silent = true, noremap = true })
end

return python_debugger
