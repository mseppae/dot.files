return {
	{
		-- https://github.com/catgoose/nvim-colorizer.lua
		"NvChad/nvim-colorizer.lua",
		event = "BufReadPre",
		opts = {
			user_default_options = {
				mode = "virtualtext",
				virtualtext_inline = true,
			},
		},
	},
}
