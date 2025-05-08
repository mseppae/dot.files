return {
	"tpope/vim-sleuth",

	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		-- opts = { signs = false },
	},

	{
		"MeanderingProgrammer/render-markdown.nvim",
		lazy = false,
		opts = {},
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
	},

	{
		"Wansmer/treesj",
		keys = {
			{ "J", "<cmd>TSJToggle<cr>", desc = "Join Toggle" },
		},
		opts = { use_default_keymaps = false, max_join_length = 150 },
	},

	"windwp/nvim-autopairs",
	event = "InsertEnter",
	-- Optional dependency
	dependencies = { "hrsh7th/nvim-cmp" },
	config = function()
		require("nvim-autopairs").setup({})
		-- If you want to automatically add `(` after selecting a function or method
		local cmp_autopairs = require("nvim-autopairs.completion.cmp")
		local cmp = require("cmp")
		cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
	end,

	{
		"mrjones2014/smart-splits.nvim",
		keys = {
			{ "<A-h>", "<cmd>lua require('smart-splits').resize_left()<CR>", desc = "Resize left" },
			{ "<A-j>", "<cmd>lua require('smart-splits').resize_down()<CR>", desc = "Resize down" },
			{ "<A-k>", "<cmd>lua require('smart-splits').resize_up()<CR>", desc = "Resize up" },
			{ "<A-l>", "<cmd>lua require('smart-splits').resize_right()<CR>", desc = "Resize right" },
			{ "<C-h>", "<cmd>lua require('smart-splits').move_cursor_left()<CR>", desc = "Move cursor left" },
			{ "<C-j>", "<cmd>lua require('smart-splits').move_cursor_down()<CR>", desc = "Move cursor down" },
			{ "<C-k>", "<cmd>lua require('smart-splits').move_cursor_up()<CR>", desc = "Move cursor up" },
			{ "<C-l>", "<cmd>lua require('smart-splits').move_cursor_right()<CR>", desc = "Move cursor right" },
		},
	},
}
