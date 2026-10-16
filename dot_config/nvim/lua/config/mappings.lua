local map = vim.keymap.set
map("i", "jk", "<esc>")
map(
	"n",
	"<leader>S",
	"<Cmd>update %<CR><Cmd>source %<CR>",
	{ desc = "Save and source from current file", silent = true }
)
-- Easier interaction with the system clipboard
map({ "n", "x" }, "<leader>y", '"+y', { desc = "Copy to system clipboard" })
map({ "n", "x" }, "<leader>p", '"+p', { desc = "Paste from system clipboard after the cursor position" })
map({ "n", "x" }, "<leader>P", '"+P', { desc = "Paste from system clipboard before the cursor position" })
-- Ctrl-L redraws the screen by default. Now it will also toggle search highlighting.
map("n", "<esc>", "<cmd>nohlsearch<CR>")
-- gx opens the url under the cursor; gX opens every URL on the line or selection
local function count(s, pattern)
	return select(2, s:gsub(pattern, ""))
end

-- Strip sentence punctuation and closing brackets without an opening pair,
-- e.g. "(see https://a.com/x.)", while keeping "https://w.org/Foo_(bar)"
local function trim_url(url)
	local openers = { [")"] = "%(", ["]"] = "%[" }
	url = url:gsub("[.,;:!?]+$", "")
	while openers[url:sub(-1)] and count(url, openers[url:sub(-1)]) < count(url, "%" .. url:sub(-1)) do
		url = url:sub(1, -2):gsub("[.,;:!?]+$", "")
	end
	return url
end

local function open_urls(text)
	local urls, seen = {}, {}
	for url in text:gmatch("https?://[^%s<>\"'`]+") do
		url = trim_url(url)
		if not seen[url] then
			seen[url] = true
			urls[#urls + 1] = url
		end
	end
	if #urls == 0 then
		vim.notify("No URLs found", vim.log.levels.WARN)
	end
	for _, url in ipairs(urls) do
		local _, err = vim.ui.open(url)
		if err then
			vim.notify(err, vim.log.levels.ERROR)
		end
	end
end

map("n", "gX", function()
	open_urls(vim.api.nvim_get_current_line())
end, { desc = "Open all URLs on line" })
map("x", "gX", function()
	local lines = vim.fn.getregion(vim.fn.getpos("."), vim.fn.getpos("v"), { type = vim.fn.mode() })
	open_urls(table.concat(lines, "\n"))
end, { desc = "Open all URLs in selection" })
-- Disable arrow keys
map({ "n", "i", "v" }, "<left>", "<nop>")
map({ "n", "i", "v" }, "<right>", "<nop>")
map({ "n", "i", "v" }, "<up>", "<nop>")
map({ "n", "i", "v" }, "<down>", "<nop>")
-- Diagnostic keymaps
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
-- Package management
map("n", "<leader>pu", "<Cmd>Lazy update<CR>", { desc = "Update plugins", silent = true })
-- Scroll up/down in terminal mode without needing Esc
map("t", "<C-u>", "<C-\\><C-N><C-u>", { desc = "Scroll up in terminal" })
map("t", "<C-d>", "<C-\\><C-N><C-d>", { desc = "Scroll down in terminal" })
map("t", "<C-b>", "<C-\\><C-N><C-b>", { desc = "Page up in terminal" })
map("t", "<C-f>", "<C-\\><C-N><C-f>", { desc = "Page down in terminal" })
