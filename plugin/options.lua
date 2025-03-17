vim.opt.number = true

vim.opt.relativenumber = false
vim.opt.mouse = 'a'
vim.opt.showmode = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.autoindent = true

-- Sync clipboard between OS and Neovim.
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250 -- Decrease update time
vim.opt.timeoutlen = 500 -- Decrease mapped sequence wait time
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = '  ', trail = ' ', nbsp = ' ' }
vim.opt.inccommand = 'split' -- Preview substitutions live, as you type!
vim.opt.cursorline = true
vim.opt.scrolloff = 8 -- Minimal number of screen lines to keep above and below the cursor.
vim.opt.wrap = false
vim.cmd [[let &stc = '%s%3l %=%#Normal# ']]  -- Adds a space between status col and buffer text

vim.opt.iskeyword:remove("_") -- treat underscores as not parts of words, easier traversing in python

-- Set custom fill characters for vertical splits and folds
vim.opt.fillchars = {
    vert = "█",
    horiz = "█",
    fold = "·",
}

-- Set highlight for split borders
vim.api.nvim_set_hl(0, "VertSplit", { fg = "#16161d" })
vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#16161d" })

local function set_tab_size(tabstop, shiftwidth, expandtab)
  vim.opt_local.tabstop = tabstop
  vim.opt_local.shiftwidth = shiftwidth
  vim.opt_local.expandtab = expandtab
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "c",
  callback = function() set_tab_size(4, 4, true) end,
})

-- auto equal width resize splits on window resize
vim.api.nvim_create_autocmd("VimResized", {
  pattern = "*",
  command = "wincmd =",
})
