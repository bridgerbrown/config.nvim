local behave_debugger = function (dap, python_test_runner)
    -- use launch.json for configuration
    -- require('dap.ext.vscode').load_launchjs(nil, nil)

    -- string selection
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

    -- run based on the selected scenario name
    local run_behave_scenario = function()
      local visual_selection = get_string_of_visual_selection()
      local feature_file = vim.fn.getcwd() .. "/features/"  -- Update as needed

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
              visual_selection
          },
          cwd = vim.fn.getcwd(),
          console = "integratedTerminal"
      })
    end

    -- setup feature
    python_test_runner.behave = function(classnames, methodname)
      local args = {}
      local feature_file = "features/" .. classnames[1]

      print("feature path: ", feature_file)

      if methodname then
        table.insert(args, "-n")
        table.insert(args, methodname)
      end

      return 'behave', { feature_file, "--no-capture", unpack(args) }
    end

    vim.keymap.set('v', '<leader>t', function() run_behave_scenario() end, { noremap = true, silent = true })
end

return behave_debugger
