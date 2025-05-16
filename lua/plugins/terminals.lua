return {

  -- Floating Terminal
  {
    "numToStr/FTerm.nvim",
    config = function()
      require'FTerm'.setup({
          border = 'double',
          dimensions  = {
              height = 0.9,
              width = 0.9,
          },
      })
      vim.keymap.set('n', '<A-i>', '<CMD>lua require("FTerm").toggle()<CR>')
      vim.keymap.set('t', '<A-i>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
    end
  },

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

}
