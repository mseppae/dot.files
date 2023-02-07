local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
	return
end

local utils = require("null-ls.utils").make_conditional_utils()
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

local rubocop_diagnostics = function()
	if utils.root_has_file("Gemfile") then
		return diagnostics.rubocop.with({
			command = "bundle",
			args = vim.list_extend({ "exec", "rubocop" }, diagnostics.rubocop._opts.args),
		})
	else
		return diagnostics.rubocop
	end
end

null_ls.setup({
	debug = false,
	sources = {
		formatting.prettier,
		formatting.eslint_d,
		formatting.stylua,
		formatting.goimports,
		formatting.rubocop,

		rubocop_diagnostics(),
	},
})
