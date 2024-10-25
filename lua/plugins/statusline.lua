return {
  {
    "tjdevries/express_line.nvim",
    dependencies = "nvim-lua/plenary.nvim",
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
        table.insert(segments, " ")

        -- line:column count
        table.insert(segments, "[")
        table.insert(segments, builtin.line_with_width(3))
        table.insert(segments, ":")
        table.insert(segments, builtin.column_with_width(2))
        table.insert(segments, "]")

        -- Total line count in buffer
        table.insert(segments, "(")
        table.insert(segments, function()
          local total_lines = vim.api.nvim_buf_line_count(0)
          return string.format("%d", total_lines)
        end)
        table.insert(segments, ")")
        return segments
      end
      -- And then when you're all done, just call
      require('el').setup { generator = generator }
    end
  },
}
