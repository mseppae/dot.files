local close = { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" } }

return {
	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
		keys = {
			{ "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diff working tree" },
			{ "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File history" },
		},
		opts = {
			-- Diffview has no default key to close its tab; q in the help and
			-- option panels still closes just those panels.
			keymaps = {
				view = { close },
				file_panel = { close },
				file_history_panel = { close },
			},
		},
	},
}
