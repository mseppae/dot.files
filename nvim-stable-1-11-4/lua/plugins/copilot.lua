return {
	{
		"zbirenbaum/copilot.lua",
		enable = true,
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({})
		end,
	},

	{
		"zbirenbaum/copilot-cmp",
		enable = true,
		opts = {
			-- https://github.com/zbirenbaum/copilot.lua#setup-and-configuration
			suggestion = {
				enable = true,
			},
			panel = {
				enable = true,
			},
		},
	},

	{
		"CopilotC-Nvim/CopilotChat.nvim",
		enable = true,
		lazy = false,
		branch = "main",
		dependencies = {
			{ "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
			{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
		},
		build = "make tiktoken",
		keys = {
			{
				"<leader>ccT",
				":CopilotChatToggle<cr>",
				mode = "",
				desc = "AI Toggle Chat",
			},
		},
		opts = {
			window = {
				layout = "float",
				width = 0.8,
				height = 0.8,
				border = "double",
			},
			prompts = {
				Explain = {
					mapping = "<leader>cce",
					description = "AI Explain",
				},
				Review = {
					mapping = "<leader>ccr",
					description = "AI Review",
				},
				Tests = {
					mapping = "<leader>cct",
					description = "AI Tests",
				},
				Fix = {
					mapping = "<leader>ccf",
					description = "AI Fix",
				},
				Optimize = {
					mapping = "<leader>cco",
					description = "AI Optimize",
				},
				Docs = {
					mapping = "<leader>ccd",
					description = "AI Documentation",
				},
			},
		},
	},
}
