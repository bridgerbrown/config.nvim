return {
  {
    "tjdevries/express_line.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
         "nvim-lua/plenary.nvim",
    },
    config = function()
      local generator = function()
        local builtin = require "el.builtin"
        local extensions = require "el.extensions"
        local subscribe = require "el.subscribe"
        local sections = require "el.sections"

        vim.opt.laststatus = 3

        local segments = {}

        -- Vim Mode
        table.insert(segments, extensions.mode)
        table.insert(segments, " ")

        -- Git branch
        table.insert(
          segments,
          subscribe.buf_autocmd("el-git-branch", "BufEnter", function(win, buf)
            local branch = extensions.git_branch(win, buf)
            if branch then
              return branch
            end
          end)
        )
        table.insert(segments, function()
          local task_count = #require("misery.scheduler").tasks
          if task_count == 0 then
            return ""
          else
            return string.format(" (Queued Events: %d)", task_count)
          end
        end)
        table.insert(segments, sections.split) -- Split section
        table.insert(segments, "%f") -- Filename
        table.insert(segments, sections.split)
        table.insert(segments, builtin.filetype) -- Filetype


        -- Line:Column count
        table.insert(segments, " [L ")

        -- Current line number, padded to 3 characters
        table.insert(segments, function()
          return string.format("%3d", vim.fn.line('.'))
        end)

        table.insert(segments, ":")

        -- Total lines in buffer, padded to 3 characters
        table.insert(segments, function()
          local total_lines = vim.api.nvim_buf_line_count(0)
          return string.format("%3d", total_lines)
        end)

        table.insert(segments, "] ")

        -- Column section
        table.insert(segments, "[C ")

        -- Current column, padded to 3 characters
        table.insert(segments, function()
          return string.format("%3d", vim.fn.col('.'))
        end)

        table.insert(segments, ":")

        -- Max column in current line, padded to 3 characters
        table.insert(segments, function()
          local line = vim.api.nvim_get_current_line()
          local max_col = vim.fn.strdisplaywidth(line)
          return string.format("%3d", max_col)
        end)

        table.insert(segments, "]")

        return segments
      end
      -- And then when you're all done, just call
      require('el').setup { generator = generator }
    end
  },
}
