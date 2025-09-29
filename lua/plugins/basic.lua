return {

  -- Detect tabstop and shiftwidth automatically
  { 'tpope/vim-sleuth' },

  -- Indent lines
  {
    "nvimdev/indentmini.nvim",
    config = function()
      require("indentmini").setup()
      vim.cmd.highlight('IndentLine guifg=#2a2938')
      vim.cmd.highlight('IndentLineCurrent guifg=#4f4f69')
    end,
  },

  -- Visual indicator for nvim marks
  {
    "chentoast/marks.nvim",
    events = "VeryLazy",
    opts = {}
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

   {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      -- Set header
      dashboard.section.header.val = {
        '███▄▄▄▄      ▄████████  ▄██████▄   ▄█    █▄   ▄█    ▄▄▄▄███▄▄▄▄   ',
        '███▀▀▀██▄   ███    ███ ███    ███ ███    ███ ███  ▄██▀▀▀███▀▀▀██▄ ',
        '███   ███   ███    █▀  ███    ███ ███    ███ ███▌ ███   ███   ███ ',
        '███   ███  ▄███▄▄▄     ███    ███ ███    ███ ███▌ ███   ███   ███ ',
        '███   ███ ▀▀███▀▀▀     ███    ███ ███    ███ ███▌ ███   ███   ███ ',
        '███   ███   ███    █▄  ███    ███ ███    ███ ███  ███   ███   ███ ',
        '███   ███   ███    ███ ███    ███ ███    ███ ███  ███   ███   ███ ',
        ' ▀█   █▀    ██████████  ▀██████▀   ▀██████▀  █▀    ▀█   ███   █▀  ',
      }

      -- Set menu
      dashboard.section.buttons.val = {
          dashboard.button("e", "  > New file" , ":ene <BAR> startinsert <CR>"),
          dashboard.button("f", "󰱼  > Find file", ":cd $HOME | Telescope find_files<CR>"),
          dashboard.button("r", "  > Recent files"   , ":Telescope oldfiles<CR>"),
          dashboard.button("z", '  > Suspend', ':suspend<CR>'),
          dashboard.button("q", '  > Quit', '<cmd>qa<CR>'),
      }

      -- Send config to alpha
      alpha.setup(dashboard.opts)

      -- Disable folding on alpha buffer
      vim.cmd([[
          autocmd FileType alpha setlocal nofoldenable
      ]])
    end,
  }
}
