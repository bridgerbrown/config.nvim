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

      -- Dark bg past 3pm
      -- local current_hour = tonumber(os.date("%H"))
      -- local bg_color = "#000000"
      -- if current_hour >= 15 then
      --   vim.cmd.hi 'Comment gui=none'
      --   vim.cmd("highlight Normal guibg=" .. bg_color)
      --   vim.cmd("highlight NormalNC guibg=" .. bg_color)
      --   vim.cmd("highlight SignColumn guibg=NONE")
      --   vim.cmd("highlight LineNr guibg=" .. bg_color)
      --   vim.cmd("highlight CursorLineNr guibg=" .. bg_color)
      --   vim.cmd("highlight CursorLine guibg=#16161d")
      --   vim.cmd("highlight GitSignsAdd guibg=NONE")
      --   vim.cmd("highlight GitSignsChange guibg=NONE")
      --   vim.cmd("highlight GitSignsDelete guibg=NONE")
      --   vim.cmd("highlight GitSignsChangeDelete guibg=NONE")
      --   vim.cmd("highlight GitSignsTopDelete guibg=NONE")
      -- end
    end,
  },
}
