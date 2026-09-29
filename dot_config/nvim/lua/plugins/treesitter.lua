-- Parsers installed and kept updated (compiled with the tree-sitter CLI, which
-- mise installs). A fixed list on purpose: parsers are not installed
-- automatically for new filetypes, since that compiles third-party grammars.
local parsers = {
	"c",
	"go",
	"odin",
	"ruby",
	"python",
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
}

return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false, -- the main branch does not support lazy-loading
		build = ":TSUpdate",
		config = function()
			if vim.fn.executable("tree-sitter") == 1 then
				require("nvim-treesitter").install(parsers)
			else
				vim.notify("tree-sitter CLI not found; run `mise install` to install parsers", vim.log.levels.WARN)
			end

			-- The main branch leaves highlighting to Neovim: start it for every
			-- buffer whose language has a parser, but not for large files.
			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("treesitter-start", { clear = true }),
				callback = function(args)
					local max_filesize = 100 * 1024 -- 100 KB
					local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(args.buf))
					if ok and stats and stats.size > max_filesize then
						-- Neovim's own ftplugins (lua, markdown, help) start
						-- treesitter after this autocmd, so stop it afterwards.
						vim.schedule(function()
							pcall(vim.treesitter.stop, args.buf)
						end)
						return
					end
					pcall(vim.treesitter.start, args.buf)
				end,
			})
		end,
	},
}
