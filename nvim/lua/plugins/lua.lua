return {
	{
		-- A plugin designed to speed up LuaLS setup for Neovim by lazily updating
		-- workspace libraries and providing faster auto-completion, since only the
		-- modules you require in open Neovim files will be loaded.
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},

	{ "Bilal2453/luvit-meta", lazy = true },
}
