return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		enabled = false,
		name = "tokyonight",
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme tokyonight]])
		end,
	},

	{
		"catppuccin/nvim",
		enabled = false,
		name = "catppuccin",
		priority = 1000,
		config = function()
			-- colorscheme catppuccin " catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha
			vim.cmd([[colorscheme catppuccin]])
		end,
	},

	{
		"ellisonleao/gruvbox.nvim",
		enabled = true,
		priority = 1000,
		name = "gruvbox",
		init = function()
			vim.o.background = "dark"
		end,
		config = function()
			vim.cmd([[colorscheme gruvbox]])
		end,
	},

	{
		"tiagovla/tokyodark.nvim",
		enabled = false,
		priority = 1000,
		name = "tokyodark",
		config = function()
			vim.cmd([[colorscheme tokyodark]])
		end,
	},

	{
		"kepano/flexoki-neovim",
		enabled = false,
		priority = 1000,
		name = "flexoki",
		config = function()
			vim.cmd([[colorscheme flexoki-dark]])
		end,
	},

	{ "nvim-tree/nvim-web-devicons", lazy = true },

	{
		"stevearc/dressing.nvim",
		opts = {},
	},
}
