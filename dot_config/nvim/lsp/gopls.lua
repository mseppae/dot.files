return {
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	root_markers = { "go.work", "go.mod" },
	-- https://github.com/golang/tools/blob/master/gopls/doc/settings.md
	settings = {
		gopls = {
			-- We do gofumpt and goimports-reviser in conform.nvim
			gofumpt = false,
			-- Enable all staticcheck checks
			staticcheck = true,
		},
	},
}
