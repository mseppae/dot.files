vim.opt.number = true

-- Sync clipboard between OS and Neovim.
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

vim.opt.smartcase = true

-- length of an actual \t character:
vim.opt.tabstop = 2

-- length to use when shifting text (eg. <<, >> and == commands)
-- (0 for ‘tabstop’):
vim.opt.shiftwidth = 0

-- length to use when editing text (eg. TAB and BS keys)
-- (0 for ‘tabstop’, -1 for ‘shiftwidth’):
vim.opt.softtabstop = -1

-- if set, only insert spaces; otherwise insert \t and complete with spaces:
vim.opt.expandtab = true

---reproduce the indentation of the previous line:
vim.opt.autoindent = true

-- try to be smart (increase the indenting level after ‘{’,
-- decrease it after ‘}’, and so on):
--set smartindent

-- https://neovim.io/doc/user/lua-guide.html#_mappings
vim.keymap.set("i", "jk", "<esc>")

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
