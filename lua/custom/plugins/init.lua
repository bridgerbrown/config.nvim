return {
  -- Hotkey buffers
  {
    "theprimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon"):setup({})

      vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
      vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

      vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
      vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
      vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
      vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)
      vim.keymap.set("n", "<leader><C-h>", function() harpoon:list():replace_at(1) end)
      vim.keymap.set("n", "<leader><C-t>", function() harpoon:list():replace_at(2) end)
      vim.keymap.set("n", "<leader><C-n>", function() harpoon:list():replace_at(3) end)
      vim.keymap.set("n", "<leader><C-s>", function() harpoon:list():replace_at(4) end)
    end,
  },
  -- File explorer
  {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  config = function()
    require("oil").setup {
      keymaps = {
        ["<C-h>"] = false,
      },
      view_options = {
        show_hidden = true,
      },
    }
    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
  end
  },
  -- Commenting
  {
    'numToStr/Comment.nvim',
    opts = {},
    config = function()
      require("Comment").setup()
    end,
  },
  {
    "tpope/vim-fugitive", -- Git in Vim commands
  },
  -- Nice error lists
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
    },
  },
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
        table.insert(segments, extensions.mode)
        table.insert(segments, " ")
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
        table.insert(segments, sections.split)
        table.insert(segments, "%f")
        table.insert(segments, sections.split)
        table.insert(segments, builtin.filetype)
        table.insert(segments, "[")
        table.insert(segments, builtin.line_with_width(3))
        table.insert(segments, ":")
        table.insert(segments, builtin.column_with_width(2))
        table.insert(segments, "]")

        return segments
      end
      -- And then when you're all done, just call
      require('el').setup { generator = generator }
    end
  }
}
