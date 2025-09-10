return {
	{
		{
			"nvim-treesitter/nvim-treesitter",
			build = ":TSUpdate",
			config = function()
				local configs = require("nvim-treesitter.configs")

				configs.setup({
					ensure_installed = {
						"c",
						"go",
						"ruby",
						"json",
						"lua",
						"vim",
						"vimdoc",
						"query",
						"heex",
						"javascript",
						"typescript",
						"html",
						"css",

						-- Rest.nvim
						"xml",
						"http",
						"json",
						"graphql",
					},
					sync_install = false,
					auto_install = true,
					highlight = {
						enable = true,
						disable = function(lang, buf)
							local max_filesize = 100 * 1024 -- 100 KB
							local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
							if ok and stats and stats.size > max_filesize then
								return true
							end
						end,
						additional_vim_regex_highlighting = { "ruby" },
					},
					indent = { enable = true },
					additional_vim_regex_highlighting = true,
				})
			end,
		},
	},
}
