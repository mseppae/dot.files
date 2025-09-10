return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	lazy = false,
	enabled = true,
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		{
			"nvim-telescope/telescope-live-grep-args.nvim",
			-- This will not install any breaking changes.
			-- For major updates, this must be adjusted manually.
			version = "^1.0.0",
		},
	},
	keys = {
		{ "<leader>sf", "<cmd>Telescope find_files<cr>", desc = "Search files" },
		{ "<leader>s.", "<cmd>Telescope oldfiles<cr>", desc = "Search old files" },
		{
			"<leader>sw",
			"<cmd>lua require('telescope-live-grep-args.shortcuts').grep_word_under_cursor()<CR>",
			desc = "Search word",
		},
		{
			"<leader>sw",
			"<cmd>lua require('telescope-live-grep-args.shortcuts').grep_visual_selection()<CR>",
			desc = "Search visual",
			mode = { "v" },
		},
		{
			"<leader>sg",
			"<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
			desc = "Search by grep",
		},
		{ "<leader>sr", "<cmd>Telescope resume<cr>", desc = "Resume search" },
		{ "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Search help" },
		{ "<leader><leader>", "<cmd>Telescope buffers<cr>", desc = "Existing buffers" },
	},
	init = function()
		local telescope = require("telescope")
		telescope.load_extension("live_grep_args")
		telescope.load_extension("fzf")
		-- local lga_actions = require("telescope-live-grep-args.actions")
		telescope.setup({
			pickers = {
				oldfiles = {
					cwd_only = true,
				},
			},
			extensions = {
				fzf = {},
				live_grep_args = {
					auto_quoting = false, -- enable/disable auto-quoting
					-- define mappings, e.g.
					-- mappings = { -- extend mappings
					-- 	i = {
					-- 		["<C-k>"] = lga_actions.quote_prompt(),
					-- 		["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
					-- 		-- freeze the current list and start a fuzzy search in the frozen list
					-- 		["<C-space>"] = lga_actions.to_fuzzy_refine,
					-- 	},
					-- },
					-- ... also accepts theme settings, for example:
					-- theme = "dropdown", -- use dropdown theme
					-- theme = { }, -- use own theme spec
					-- layout_config = { mirror=true }, -- mirror preview pane
				},
			},
		})
	end,
	config = function()
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc, mode)
					mode = mode or "n"
					vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				--  To jump back, press <C-t>.
				map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

				map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

				map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

				map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

				map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

				map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

				map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

				-- Execute a code action, usually your cursor needs to be on top of an error
				-- or a suggestion from your LSP for this to activate.
				map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })

				map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

				--    See `:help CursorHold` for information about when this is executed
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
					local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.document_highlight,
					})

					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						group = highlight_augroup,
						callback = vim.lsp.buf.clear_references,
					})

					vim.api.nvim_create_autocmd("LspDetach", {
						group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
						callback = function(event2)
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
						end,
					})
				end

				if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
					map("<leader>th", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
					end, "[T]oggle Inlay [H]ints")
				end
			end,
		})
	end,
}
