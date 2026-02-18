vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
-- Sync clipboard between OS and Neovim.
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)
vim.opt.winborder = "rounded"
vim.opt.cursorcolumn = false
-- Length of an actual \t character:
vim.opt.tabstop = 2
-- Length to use when shifting text (eg. <<, >> and == commands)
-- (0 for ‘tabstop’):
vim.opt.shiftwidth = 0
-- Length to use when editing text (eg. TAB and BS keys)
-- (0 for ‘tabstop’, -1 for ‘shiftwidth’):
vim.opt.softtabstop = -1
-- If set, only insert spaces; otherwise insert \t and complete with spaces:
vim.opt.expandtab = true
-- Reproduce the indentation of the previous line:
vim.opt.autoindent = true
-- Text wrapping
vim.opt.wrap = true
vim.opt.breakindent = true
-- Save undo history
vim.opt.undofile = true
-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
-- Decrease update time
vim.opt.updatetime = 250
-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300
-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.scrolloff = 999
-- Show whitespace characters
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
