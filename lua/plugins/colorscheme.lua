return {
  {
    'rebelot/kanagawa.nvim', -- GOAT
    -- 'rose-pine/neovim',
    -- 'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      vim.cmd.colorscheme 'kanagawa'
      -- vim.cmd.colorscheme 'rose-pine'
      -- vim.cmd.colorscheme 'tokyonight-night'

      -- You can configure highlights by doing something like:
      vim.cmd.hi 'Comment gui=none'
    end,
  },
}
