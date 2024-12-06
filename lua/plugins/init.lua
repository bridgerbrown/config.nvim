return {
  -- Detect tabstop and shiftwidth automatically
  { 'tpope/vim-sleuth' },

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

      -- cucumber .feature files commenting
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "cucumber",
        callback = function()
          vim.bo.commentstring = "# %s"
        end,
      })
    end,
  },

  -- Git related signs to the gutter
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      signcolumn = true,
    },
  },
  -- Git in Vim commands
  { "tpope/vim-fugitive", },

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

  -- Toggling a consistent internal term
  -- (not set on this. mainly for debug window.)
  {
    "akinsho/toggleterm.nvim",
    version = '*',
    config = function()
      local toggleterm = require("toggleterm")
      toggleterm.setup({
        size = 20,
        shade_terminals = true,
      })

      vim.keymap.set("n", "<A-t>", ":ToggleTerm<CR>")
      function _G.set_terminal_keymaps()
        local opts = {buffer = 0}
        vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
        vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
        vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
        vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
        vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
      end
    end
  },

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

  -- Visual indicator for nvim marks
  {
    "chentoast/marks.nvim",
    events = "VeryLazy",
    opts = {}
  },
}
