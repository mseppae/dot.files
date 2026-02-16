local map = vim.keymap.set
map("i", "jk", "<esc>")
map(
	"n",
	"<leader>s",
	"<Cmd>update %<CR><Cmd>source %<CR>",
	{ desc = "Save and source from current file", silent = true }
)
-- Easier interaction with the system clipboard
map({ "n", "x" }, "<leader>y", '"+y', { desc = "Copy to system clipboard" })
map({ "n", "x" }, "<leader>p", '"+p', { desc = "Paste from system clipboard after the cursor position" })
map({ "n", "x" }, "<leader>P", '"+P', { desc = "Paste from system clipboard before the cursor position" })
-- Ctrl-L redraws the screen by default. Now it will also toggle search highlighting.
map("n", "<esc>", "<cmd>nohlsearch<CR>")
-- Disable arrow keys
map({ "n", "i", "v" }, "<left>", "<nop>")
map({ "n", "i", "v" }, "<right>", "<nop>")
map({ "n", "i", "v" }, "<up>", "<nop>")
map({ "n", "i", "v" }, "<down>", "<nop>")
-- Diagnostic keymaps
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
-- Package management
map("n", "<leader>pr", ":restart<CR>", { desc = "Restart the Neovim session", silent = true })
map("n", "<leader>pu", "<Cmd>vim.pack.update<CR>", { desc = "Restart the Neovim session", silent = true })
-- Scroll up/down in terminal mode without needing Esc
map("t", "<C-u>", "<C-\\><C-N><C-u>", { desc = "Scroll up in terminal" })
map("t", "<C-d>", "<C-\\><C-N><C-d>", { desc = "Scroll down in terminal" })
map("t", "<C-b>", "<C-\\><C-N><C-b>", { desc = "Page up in terminal" })
map("t", "<C-f>", "<C-\\><C-N><C-f>", { desc = "Page down in terminal" })
