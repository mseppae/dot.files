return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	lazy = false,
	enabled = true,
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	keys = {
		{ "<leader>sf", "<cmd>Telescope find_files<cr>", desc = "Find files" },
		{ "<leader>s.", "<cmd>Telescope oldfiles<cr>", desc = "Old files" },
		{ "<leader>sw", "<cmd>Telescope grep_string<cr>", desc = "Search word" },
		{ "<leader>sg", "<cmd>Telescope live_grep<cr>", desc = "Search by grep" },
		{ "<leader>sr", "<cmd>Telescope resume<cr>", desc = "Resume search" },
		{ "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Search help" },
		{ "<leader><leader>", "<cmd>Telescope buffers<cr>", desc = "Existing buffers" },
	},
	opts = {
		pickers = {
			oldfiles = {
				cwd_only = true,
			},
		},
		extensions = {
			fzf = {},
		},
	},
	init = function()
		require("telescope").load_extension("fzf")
		require("config.telescope.multigrep").setup()
	end,
}
