local set = vim.keymap.set
set('n', '<leader>w', ':w<CR>')
set('n', '<C-q>', ':q<CR>')
set('n', '<Esc>', '<cmd>nohlsearch<CR>')
set('n', '<leader>e', ':Ex<CR>')

-- Next/prev buffer
set('n', '<leader>bn', ':bnext<CR>', { desc = 'Next buffer'})
set('n', '<leader>bp', ':bprev<CR>', { desc = 'Prev buffer'})

-- Diagnostic keymaps
set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal
set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Easily hit escape in terminal mode.
set("t", "<esc><esc>", "<c-\\><c-n>")

-- Open a terminal at the bottom of the screen with a fixed height.
set("n", ",st", function()
  vim.cmd.new()
  vim.cmd.wincmd "J"
  vim.api.nvim_win_set_height(0, 12)
  vim.wo.winfixheight = true
  vim.cmd.term()
end)

-- Window management
set('n', '<leader>wh', '<C-w><C-h>', { desc = 'Move focus to the left window' })
set('n', '<leader>wl', '<C-w><C-l>', { desc = 'Move focus to the right window' })
set('n', '<leader>wj', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
set('n', '<leader>wk', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
set("n", "<leader>wv", "<C-w>v") -- split window vertically
set("n", "<leader>wm", "<C-w>s") -- split window horizontally
set("n", "<leader>we", "<C-w>=") -- make split windows equal width
set("n", "<leader>wx", ":close<CR>") -- close current split window
