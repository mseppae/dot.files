return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").setup({
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
					"xml",
					"http",
					"graphql",
				},
				sync_install = false,
				auto_install = true,
			})

			-- Disable treesitter for large files
			vim.api.nvim_create_autocmd("BufReadPost", {
				callback = function(args)
					local max_filesize = 100 * 1024 -- 100 KB
					local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(args.buf))
					if ok and stats and stats.size > max_filesize then
						vim.treesitter.stop(args.buf)
					end
				end,
			})
		end,
	},
}