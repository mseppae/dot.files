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
				backdrop = 30,
				keys = {
					claude_hide = {
						toggle_key,
						function(self)
							vim.cmd("stopinsert")
							self:hide()
						end,
						mode = "t",
						desc = "Hide",
					},
				},
			},
		},
		diff_opts = {
			keep_terminal_focus = false, -- jump to diff when it opens
			auto_close_on_accept = true,
			vertical_split = true,
			open_in_current_tab = true,
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
