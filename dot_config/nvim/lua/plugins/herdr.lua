-- herdr-nvim annotations: comment code and send it to the agent in a herdr pane.
-- The herdr side (sidebar, picker) is built from the same reviewed commit by
-- run_after_install-herdr-nvim-plugin.sh; bump both pins together.
return {
	"ChmaraX/herdr-nvim",
	commit = "26cd43e38126be8012b59f95fd41ef33574d0d08",
	-- Only inside herdr panes, which (like the sidebar daemon) set HERDR_TAB_ID.
	cond = vim.env.HERDR_TAB_ID ~= nil,
	-- <leader>a is taken by atone.nvim and claudecode.nvim.
	opts = { prefix = "<leader>h" },
}
