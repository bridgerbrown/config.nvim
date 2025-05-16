return {
  {
    'rebelot/kanagawa.nvim', -- GOAT
    -- 'rose-pine/neovim',

    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      vim.cmd.colorscheme 'kanagawa'

      -- local bg_color = "#201725" -- darker Kanagawa blue bg
      -- local bg_color = "#18111A" -- even darker

      -- vim.cmd("highlight Normal guibg=" .. bg_color)
      -- vim.cmd("highlight NormalNC guibg=" .. bg_color)
      -- vim.cmd("highlight SignColumn guibg=NONE")
      -- vim.cmd("highlight LineNr guibg=" .. bg_color)
      -- vim.cmd("highlight CursorLineNr guibg=" .. bg_color)

      -- vim.cmd("highlight CursorLine guibg=#16161d")

      -- Remove bg from gitsigns icons, nicer with bg color changes
      vim.cmd("highlight GitSignsAdd guibg=NONE")
      vim.cmd("highlight GitSignsChange guibg=NONE")
      vim.cmd("highlight GitSignsDelete guibg=NONE")
      vim.cmd("highlight GitSignsChangeDelete guibg=NONE")
      vim.cmd("highlight GitSignsTopDelete guibg=NONE")

      -- end
    end,
  },
}
