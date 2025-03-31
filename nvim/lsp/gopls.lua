return {
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	root_markers = { "go.work", "go.mod" },
	-- https://github.com/golang/tools/blob/master/gopls/doc/settings.md
	settings = {
		gopls = {
			-- Just as fast debugging thing that the settings structure is correct
			analyses = {
				appends = true,
			},
			gofumpt = true,
		},
	},
}
