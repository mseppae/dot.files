return {
	{
		"https://github.com/nvim-neo-tree/neo-tree.nvim",
		version = "*",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"https://github.com/MunifTanjim/nui.nvim",
			"https://github.com/nvim-tree/nvim-web-devicons",
		},
		cmd = "Neotree",
		keys = {
			{ "\\", ":Neotree reveal<CR>", desc = "NeoTree reveal", silent = true },
		},
		opts = {
			close_if_last_window = true,
			filesystem = {
				follow_current_file = {
					enabled = true,
				},
				window = {
					mappings = {
						["\\"] = "close_window",
					},
				},
			},
		},
	},
}
