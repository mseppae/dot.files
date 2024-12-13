return {
	{
		"stevearc/conform.nvim",
		lazy = false,
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = "",
				desc = "[F]ormat buffer",
			},
		},
		opts = {
			notify_on_error = false,
			format_on_save = function()
				return {
					timeout_ms = 500,
					lsp_format = "fallback",
				}
			end,
			formatters_by_ft = {
				lua = { "stylua" },
				ruby = { "ruby_lsp" },
				go = { "goimports-reviser", "gofumpt", "golines" },
				css = { { "prettierd", "prettier" } },
				html = { { "prettierd", "prettier" } },
				-- Conform can also run multiple formatters sequentially
				-- python = { "isort", "black" },
				--
				-- You can use a sub-list to tell conform to run *until* a formatter
				-- is found.
				javascript = { { "prettierd", "prettier" } },
			},
		},
	},

	{
		"neovim/nvim-lspconfig",
		config = function()
			require("nvchad.configs.lspconfig").defaults()
			require("configs.lspconfig")
		end,
	},

	{
		"williamboman/mason.nvim",
	},

	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"vim",
				"lua",
				"vimdoc",
				"html",
				"css",
				"ruby",
				"javascript",
				"typescript",
				"go",

				-- Rest.nvim
				"xml",
				"http",
				"json",
				"graphql",
			},
		},
	},

	{
		"olexsmir/gopher.nvim",
		ft = "go",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {},
	},

	{
		"nvim-telescope/telescope.nvim",
		opts = {
			defaults = {
				layout_config = {
					horizontal = {
						prompt_position = "bottom",
					},
				},
			},
			pickers = {
				oldfiles = {
					cwd_only = true,
				},
			},
		},
	},

	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	{
		"laytan/cloak.nvim",
		lazy = false,
		opts = {
			cloak_length = 12,
			patterns = {
				{
					-- Match any file starting with '.env'.
					-- This can be a table to match multiple file patterns.
					file_pattern = { ".env*", "passwd", "*.toml" },
					-- Match an equals sign and any character after it.
					-- This can also be a table of patterns to cloak,
					-- example: cloak_pattern = { ':.+', '-.+' } for yaml files.
					cloak_pattern = "=.+",
					-- A function, table or string to generate the replacement.
					-- The actual replacement will contain the 'cloak_character'
					-- where it doesn't cover the original text.
					-- If left empty the legacy behavior of keeping the first character is retained.
					replace = nil,
				},
			},
		},
	},

	{
		"echasnovski/mini.nvim",
		config = function()
			-- Better Around/Inside textobjects
			--
			-- Examples:
			--  - va)  - [V]isually select [A]round [)]paren
			--  - yinq - [Y]ank [I]nside [N]ext [']quote
			--  - ci'  - [C]hange [I]nside [']quote
			require("mini.ai").setup({ n_lines = 500 })

			-- Add/delete/replace surroundings (brackets, quotes, etc.)
			--
			-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
			-- - sd'   - [S]urround [D]elete [']quotes
			-- - sr)'  - [S]urround [R]eplace [)] [']
			require("mini.surround").setup()
		end,
	},

	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},

	{
		"vhyrro/luarocks.nvim",
		priority = 1000,
		config = true,
		opts = {
			rocks = { "lua-curl", "nvim-nio", "mimetypes", "xml2lua" },
		},
	},

	{
		"rest-nvim/rest.nvim",
		ft = "http",
		dependencies = { "luarocks.nvim" },
		config = function()
			require("rest-nvim").setup()
		end,
	},

	{
		"MeanderingProgrammer/render-markdown.nvim",
		lazy = false,
		opts = {},
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
	},

	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({})
		end,
	},

	{
		"zbirenbaum/copilot-cmp",
		opts = {
			-- https://github.com/zbirenbaum/copilot.lua#setup-and-configuration
			suggestion = {
				enable = false,
			},
			panel = {
				enable = false,
			},
		},
	},

	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{
				"zbirenbaum/copilot-cmp",
				config = function()
					require("copilot_cmp").setup()
				end,
			},
		},
		opts = {
			sources = {
				{ name = "copilot", group_index = 2 },
				{ name = "nvim_lsp", group_index = 2 },
				{ name = "luasnip", group_index = 2 },
				{ name = "buffer", group_index = 2 },
				{ name = "nvim_lua", group_index = 2 },
				{ name = "path", group_index = 2 },
			},
		},
	},

	{
		"CopilotC-Nvim/CopilotChat.nvim",
		lazy = false,
		branch = "canary",
		dependencies = {
			{ "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
			{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
		},
		build = "make tiktoken",
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
