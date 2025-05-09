-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- disable some default providers
vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

vim.g.have_nerd_font = true

require("config.options")
require("config.mappings")

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- https://github.com/neovim/nvim-lspconfig/tree/master/lua/lspconfig/configs
vim.lsp.enable({
	"lua_ls",
	"gopls",
	"ruby_lsp",
	"sorbet",
	"zig",
})

vim.diagnostic.config({
	virtual_text = true,
	underline = true,
	virtual_lines = false,
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)

		if client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(false, client.id, ev.buf, { autotrigger = false })
		end
	end,
})

require("config.custom.git-commit-sha-copy-command")

-- Use lazy.nvim as package manager
require("config.lazy")
