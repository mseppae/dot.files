return {
	{
		"nvim-telescope/telescope.nvim",
		version = "*",
		-- :Telescope works before any Telescope key has loaded it.
		cmd = "Telescope",
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
		config = function()
			local telescope = require("telescope")
			-- File history: Enter opens a diff against that commit in a new tab
			-- instead of the default, which checks the file out at that commit.
			-- q closes that tab; the mapping is removed again with the tab, so the
			-- file keeps its normal q (macros).
			local function open_diff(prompt_bufnr)
				require("telescope.actions").select_tab(prompt_bufnr)
				local tab = vim.api.nvim_get_current_tabpage()
				local bufs = {}
				for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tab)) do
					local buf = vim.api.nvim_win_get_buf(win)
					bufs[#bufs + 1] = buf
					vim.keymap.set("n", "q", "<Cmd>tabclose<CR>", { buffer = buf, desc = "Close the history diff" })
				end
				vim.api.nvim_create_autocmd("TabClosed", {
					callback = function()
						if vim.api.nvim_tabpage_is_valid(tab) then
							return
						end
						for _, buf in ipairs(bufs) do
							if vim.api.nvim_buf_is_valid(buf) then
								pcall(vim.keymap.del, "n", "q", { buffer = buf })
							end
						end
						return true
					end,
				})
			end
			local history = {
				mappings = {
					i = { ["<cr>"] = open_diff },
					n = { ["<cr>"] = open_diff },
				},
			}
			telescope.load_extension("live_grep_args")
			telescope.load_extension("fzf")
			telescope.setup({
				pickers = {
					oldfiles = {
						cwd_only = true,
					},
					git_bcommits = history,
					git_bcommits_range = history,
				},
				extensions = {
					fzf = {},
					live_grep_args = {
						auto_quoting = false,
					},
				},
			})
		end,
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
			{ "<leader>gh", "<cmd>Telescope git_bcommits<cr>", desc = "File history" },
			{
				"<leader>gh",
				function()
					local first, last = vim.fn.line("v"), vim.fn.line(".")
					require("telescope.builtin").git_bcommits_range({
						from = math.min(first, last),
						to = math.max(first, last),
					})
				end,
				desc = "Selected lines history",
				mode = { "v" },
			},
		},
	},
}
