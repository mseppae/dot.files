local options = {
	clipboard = "unnamedplus", -- allows neovim to access the system clipboard
	mouse = "a", -- allow the mouse to be used in neovim

	cmdheight = 2, -- more space in the neovim command line for displaying messages
	pumheight = 10, -- pop up menu height
	showmode = false, -- we don't need to see things like -- INSERT -- anymore
	showtabline = 2, -- always show tabs
	completeopt = { "menuone", "noselect" },
	fileencoding = "utf-8", -- the encoding written to a file
	-- wrap = false,                            -- display lines as one long line
	scrolloff = 8, -- number of screen lines to keep above or below the cursor
	sidescrolloff = 8,

	numberwidth = 4, -- set number column width {default 4}
	signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
	number = true, -- set numbered lines
	relativenumber = true, -- set relative numbered lines

	autoindent = true,
	hlsearch = true, -- highlight all matches on previous search pattern
	ignorecase = true, -- ignore case in search patterns
	incsearch = true,
	smartcase = true, -- smart case
	smartindent = true, -- make indenting smarter again
	expandtab = true, -- convert tabs to spaces
	shiftwidth = 2, -- the number of spaces inserted for each indentation
	tabstop = 2, -- insert 2 spaces for a tab
	softtabstop = 2,
	cursorline = true, -- highlight the current line

	splitbelow = true, -- force all horizontal splits to go below current window
	splitright = true, -- force all vertical splits to go to the right of current window

	swapfile = false, -- creates a swapfile
	undofile = true, -- enable persistent undo
	undodir = "~/.vim/undodir",
	updatetime = 300, -- faster completion (4000ms default)
	timeout = true,
	timeoutlen = 300, --	Time in milliseconds to wait for a mapped sequence to complete.
	writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
	history = 1000,
	autoread = true,
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.g.mapleader = " "
