local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

configs.setup({
	ensure_installed = {
		"dockerfile",
		"go",
		"html",
		"javascript",
		"json",
		"lua",
		"ruby",
		"typescript",
		"yaml",
	}, -- one of "all" or a list of languages
	ignore_install = { "" }, -- List of parsers to ignore installing
	autopairs = {
		enable = true,
	},
	highlight = {
		enable = true,
		disable = { "" },
		additional_vim_regex_highlighting = true,
	},
	indent = {
		enable = true,
		disable = { "" },
	},
	context_commentstring = {
		enable = true,
		enable_autocmd = false,
	},
})
