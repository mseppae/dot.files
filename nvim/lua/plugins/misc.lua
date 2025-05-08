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
		lazy = false, -- Avoid lazy-loading for Wezterm integration
		opts = {
			multiplexer_integration = "wezterm", -- Enable Wezterm support
			at_edge = "wrap", -- Wrap to opposite side when at edge (or set to "stop")
			default_amount = 3, -- Default resize amount
			ignored_filetypes = { "nofile", "quickfix", "prompt" },
			ignored_buftypes = { "NvimTree" },
			log_level = "info",
		},
		config = function(_, opts)
			local smart_splits = require("smart-splits")
			smart_splits.setup(opts)

			vim.keymap.set("n", "<C-h>", smart_splits.move_cursor_left, { desc = "Move focus to the left window" })
			vim.keymap.set("n", "<C-j>", smart_splits.move_cursor_down, { desc = "Move focus to the lower window" })
			vim.keymap.set("n", "<C-k>", smart_splits.move_cursor_up, { desc = "Move focus to the upper window" })
			vim.keymap.set("n", "<C-l>", smart_splits.move_cursor_right, { desc = "Move focus to the right window" })

			vim.keymap.set("n", "<M-h>", smart_splits.resize_left, { desc = "Resize left" })
			vim.keymap.set("n", "<M-j>", smart_splits.resize_down, { desc = "Resize down" })
			vim.keymap.set("n", "<M-k>", smart_splits.resize_up, { desc = "Resize up" })
			vim.keymap.set("n", "<M-l>", smart_splits.resize_right, { desc = "Resize right" })
		end,
	},
}
