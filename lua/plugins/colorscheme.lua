return {
  {
    'rebelot/kanagawa.nvim', -- GOAT
    -- 'yazeed1s/oh-lucy.nvim',
    -- 'rose-pine/neovim',
    -- 'folke/tokyonight.nvim',
    -- 'vague2k/vague.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      vim.cmd.colorscheme 'kanagawa'
      -- vim.cmd.colorscheme 'rose-pine'
      -- vim.cmd.colorscheme 'tokyonight-night'
      -- vim.cmd.colorscheme 'oh-lucy'

      -- local bg_color = "#000000"
      -- vim.cmd("highlight Normal guibg=" .. bg_color)
      -- vim.cmd("highlight NormalNC guibg=" .. bg_color)
      -- vim.cmd("highlight SignColumn guibg=NONE")
      -- vim.cmd("highlight LineNr guibg=" .. bg_color)
      -- vim.cmd("highlight CursorLineNr guibg=" .. bg_color)
      -- vim.cmd("highlight CursorLine guibg=#16161d")
      -- vim.cmd("highlight GitSignsAdd guibg=NONE")
      -- vim.cmd("highlight GitSignsChange guibg=NONE")
      -- vim.cmd("highlight GitSignsDelete guibg=NONE")
      -- vim.cmd("highlight GitSignsChangeDelete guibg=NONE")
      -- vim.cmd("highlight GitSignsTopDelete guibg=NONE")
      -- end
    end,
  },
}
