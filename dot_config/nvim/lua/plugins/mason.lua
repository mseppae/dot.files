return {
	{
		"https://github.com/mason-org/mason.nvim",
		lazy = false,
		dependencies = {
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{ "j-hui/fidget.nvim", opts = {} },
		},
		config = function()
			require("mason").setup()
			local ensure_installed = {
				"stylua",
				"lua-language-server",
				"prettierd",
				"eslint_d",
				"typescript-language-server",

				-- Go lang
				"gopls",
				"gofumpt",
				"goimports-reviser",
				"staticcheck",
				"gomodifytags",
				"gotests",
				"iferr",

				-- Ruby
				"ruby-lsp",
				"sorbet",

				-- Zig
				"zls",
			}

			require("mason-tool-installer").setup({
				ensure_installed = ensure_installed,
				integrations = {
					["mason-lspconfig"] = false,
					["mason-null-ls"] = false,
					["mason-nvim-dap"] = false,
				},
			})
		end,
	},
}
