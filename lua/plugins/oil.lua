return {
  -- File explorer
  {
  "stevearc/oil.nvim",
  ---@module 'oil'
  ---@type oil.SetupOpts
  dependencies = { "nvim-tree/nvim-web-devicons" },
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
}
