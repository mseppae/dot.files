local toggle_key = "<C-,>"

return {
	"coder/claudecode.nvim",
	dependencies = { "folke/snacks.nvim" },
	opts = {
		terminal = {
			provider = "snacks",
			snacks_win_opts = {
				position = "float",
				width = 0.85,
				height = 0.85,
				border = "rounded",
				backdrop = false,
				keys = {
					claude_hide = {
						toggle_key,
						function(self)
							self:hide()
						end,
						mode = "t",
						desc = "Hide",
					},
				},
			},
		},
		diff_opts = {
			keep_terminal_focus = true, -- Keep focus on Claude terminal
			auto_close_on_accept = true, -- Close diff windows after accepting
			vertical_split = true, -- Use vertical splits for diffs
			open_in_current_tab = false, -- Don't create new tabs
			open_in_new_tab = false, -- Don't create new tabs
		},
	},
	keys = {
		{ toggle_key, "<cmd>ClaudeCodeFocus<cr>", desc = "Toggle Claude", mode = { "n", "v" } },
		{ "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
		{ "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
		{ "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add buffer" },
		{ "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send selection" },
	},
}
