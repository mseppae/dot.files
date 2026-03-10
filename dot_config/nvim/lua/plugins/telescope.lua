return {
	{
		"nvim-telescope/telescope.nvim",
		version = "*",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			{
				"nvim-telescope/telescope-live-grep-args.nvim",
				-- This will not install any breaking changes.
				-- For major updates, this must be adjusted manually.
				version = "^1.0.0",
			},
		},
		config = function()
			local telescope = require("telescope")
			telescope.load_extension("live_grep_args")
			telescope.load_extension("fzf")
			telescope.setup({
				pickers = {
					oldfiles = {
						cwd_only = true,
					},
				},
				extensions = {
					fzf = {},
					live_grep_args = {
						auto_quoting = false,
					},
				},
			})
		end,
		keys = {
			{ "<leader>sf", "<cmd>Telescope find_files<cr>", desc = "Search files" },
			{ "<leader>s.", "<cmd>Telescope oldfiles<cr>", desc = "Search old files" },
			{
				"<leader>sw",
				"<cmd>lua require('telescope-live-grep-args.shortcuts').grep_word_under_cursor()<CR>",
				desc = "Search word",
			},
			{
				"<leader>sw",
				"<cmd>lua require('telescope-live-grep-args.shortcuts').grep_visual_selection()<CR>",
				desc = "Search visual",
				mode = { "v" },
			},
			{
				"<leader>sg",
				"<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
				desc = "Search by grep",
			},
			{ "<leader>sr", "<cmd>Telescope resume<cr>", desc = "Resume search" },
			{ "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Search help" },
			{ "<leader><leader>", "<cmd>Telescope buffers<cr>", desc = "Existing buffers" },
		},
	},
}
