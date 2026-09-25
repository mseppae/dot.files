return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>f",
				function()
					local trust = require("config.trust")
					if not trust.buf_trusted(0) then
						trust.notify_untrusted(trust.project_root(0))
						return
					end
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = "",
				silent = true,
				desc = "[F]ormat buffer",
			},
		},
		opts = {
			notify_on_error = true,
			format_on_save = function(bufnr)
				-- Formatters like prettierd and rubocop load project code.
				local trust = require("config.trust")
				if not trust.buf_trusted(bufnr) then
					trust.notify_untrusted(trust.project_root(bufnr))
					return nil
				end
				local disable_filetypes = { c = true, cpp = true }
				local lsp_format_opt
				if disable_filetypes[vim.bo[bufnr].filetype] then
					lsp_format_opt = "never"
				else
					lsp_format_opt = "fallback"
				end
				return {
					timeout_ms = 1500,
					lsp_format = lsp_format_opt,
				}
			end,
			formatters_by_ft = {
				lua = { "stylua" },
				json = { "prettierd" },
				ruby = { "rubocop" },
				go = {
					"goimports-reviser",
					"gofumpt",
				},
				odin = { "odinfmt" },
				css = { "prettierd" },
				html = { "prettierd" },
				javascript = { "prettierd" },
			},
		},
	},
}
