return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	lazy = false,
	enabled = true,
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		{ "<leader>sf", "<cmd>Telescope find_files<cr>", desc = "Find files" },
		{ "<leader>s.", "<cmd>Telescope oldfiles<cr>", desc = "Old files" },
		{ "<leader>sw", "<cmd>Telescope grep_string<cr>", desc = "Search word" },
		{ "<leader>sg", "<cmd>Telescope live_grep<cr>", desc = "Search by grep" },
		{ "<leader>sr", "<cmd>Telescope resume<cr>", desc = "Resume search" },
		{ "<leader><leader>", "<cmd>Telescope buffers<cr>", desc = "Existing buffers" },
	},
	opts = {
		pickers = {
			oldfiles = {
				cwd_only = true,
			},
		},
	},
}
