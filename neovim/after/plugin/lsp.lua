local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_ok then
	return
end

local mason_ok, mason = pcall(require, "mason")
if not mason_ok then
	return
end
local mason_lspconfig_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_ok then
	return
end

local lsp_config_ok, lspconfig = pcall(require, "lspconfig")
if not lsp_config_ok then
	return
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local Remap = require("mseppae.keymap")
local nnoremap = Remap.nnoremap
-- local xnoremap = Remap.xnoremap

mason.setup()
mason_lspconfig.setup()

local function config(_config)
	return vim.tbl_deep_extend("force", {
		flags = { debounce_text_changes = 150 },
		capabilities = cmp_nvim_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities()),
		on_attach = function(client)
			-- Autoformatting files
			vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])
			nnoremap("<leader>f", ":Format<cr>")
			-- Use null-ls formatter for given language servers
			if client.name == "tsserver" or client.name == "sumneko_lua" then
				client.resolved_capabilities.document_formatting = false
			end

			-- Displays hover information about the symbol under the cursor
			nnoremap("K", function()
				vim.lsp.buf.hover()
			end)

			-- Jump to the definition
			nnoremap("gd", function()
				vim.lsp.buf.definition()
			end)

			-- Jump to declaration
			-- nnoremap('gD', function() vim.lsp.buf.declaration() end)

			-- Lists all the implementations for the symbol under the cursor
			-- nnoremap('gi', function() vim.lsp.buf.implementation() end)

			-- Jumps to the definition of the type symbol
			nnoremap("go", function()
				vim.lsp.buf.type_definition()
			end)

			-- Lists all the references
			nnoremap("gr", function()
				vim.lsp.buf.references()
			end)

			-- Displays a function's signature information
			nnoremap("<C-k>", function()
				vim.lsp.buf.signature_help()
			end)

			-- Renames all references to the symbol under the cursor
			nnoremap("<F2>", function()
				vim.lsp.buf.rename()
			end)

			-- Selects a code action available at the current cursor position
			-- nnoremap('<F4>', function() vim.lsp.buf.code_action() end)
			-- xnoremap('<F4>', function() vim.lsp.buf.range_code_action() end)

			-- Show diagnostics in a floating window
			nnoremap("gl", function()
				vim.diagnostic.open_float()
			end)

			-- Move to the previous diagnostic
			nnoremap("[d", function()
				vim.diagnostic.goto_prev()
			end)

			-- Move to the next diagnostic
			nnoremap("]d", function()
				vim.diagnostic.goto_next()
			end)
		end,
	}, _config or {})
end

lspconfig.solargraph.setup(config())
lspconfig.gopls.setup(config())
lspconfig.tsserver.setup(config())
lspconfig.sumneko_lua.setup(config({
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
}))
