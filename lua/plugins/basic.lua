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

}
