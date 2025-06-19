return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		dependencies = {
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{ "j-hui/fidget.nvim", opts = {} },
		},
		config = function()
			require("mason").setup()

			if vim.g.have_nerd_font then
				local signs = { ERROR = "", WARN = "", INFO = "", HINT = "" }
				local diagnostic_signs = {}
				for type, icon in pairs(signs) do
					diagnostic_signs[vim.diagnostic.severity[type]] = icon
				end
				vim.diagnostic.config({ signs = { text = diagnostic_signs } })
			end

			local ensure_installed = {
				"stylua",
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
