return {
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
  {
    'numToStr/Comment.nvim',
    opts = {},
    config = function()
      require("Comment").setup()
    end,
  },
  {
    "tpope/vim-fugitive",
    config = function()
      vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
    end
  }
}
