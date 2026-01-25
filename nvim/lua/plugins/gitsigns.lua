return {
	{
		"lewis6991/gitsigns.nvim",
		lazy = false,
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
			current_line_blame = true, -- Enable blame on current line
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "eol", -- End of line
				delay = 250,
				ignore_whitespace = false,
			},
		},
	},
}
