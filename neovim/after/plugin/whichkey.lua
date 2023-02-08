local status_ok, whichkey = pcall(require, "which-key")
if not status_ok then
	return
end

local conf = {
	window = {
		border = "single", -- none, single, double, shadow
		position = "bottom", -- bottom, top
	},
}

local opts = {
	mode = "n", -- Normal mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = false, -- use `nowait` when creating keymaps
}

local mappings = {
	D = {
		name = "Database",
		u = { "<Cmd>DBUIToggle<Cr>", "Toggle UI" },
		f = { "<Cmd>DBUIFindBuffer<Cr>", "Find buffer" },
		r = { "<Cmd>DBUIRenameBuffer<Cr>", "Rename buffer" },
		q = { "<Cmd>DBUILastQueryInfo<Cr>", "Last query info" },
	},
	z = {
		name = "Packer",
		c = { "<cmd>PackerCompile<cr>", "Compile" },
		i = { "<cmd>PackerInstall<cr>", "Install" },
		s = { "<cmd>PackerSync<cr>", "Sync" },
		S = { "<cmd>PackerStatus<cr>", "Status" },
		u = { "<cmd>PackerUpdate<cr>", "Update" },
	},
}

whichkey.setup(conf)
whichkey.register(mappings, opts)
