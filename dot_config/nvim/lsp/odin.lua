return {
	-- ols = the Odin Language Server (github.com/DanielGavin/ols).
	-- `odin` on its own is the compiler, not an LSP server.
	cmd = { "ols" },
	filetypes = { "odin" },
	root_markers = { "ols.json", ".git" },
	-- Global OLS settings, applied to every Odin project. A project-local
	-- ols.json still overrides these. The base/core/vendor/shared collections
	-- are auto-resolved by OLS via `odin root`, so no machine paths are needed.
	init_options = {
		enable_semantic_tokens = true,
		enable_document_symbols = true,
		enable_hover = true,
		enable_format = true,
		enable_references = true,
		enable_document_links = true,
		enable_inlay_hints_params = true,
		enable_inlay_hints_default_params = true,
		enable_inlay_hints_implicit_return = true,
	},
}
