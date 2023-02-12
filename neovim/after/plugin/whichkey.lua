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
	["w"] = { ":w<CR>", "Save" },
	["q"] = { ":q<CR>", "Quit" },
	["x"] = { ":nohlsearch<Bar>:echo<CR>", "Clear search" },

	-- There is probably a better way to do this
	["r"] = { ":%s/<C-r><C-w>//gc<Left><Left><Left>", "Replace word" },

	p = {
		name = "Project navigator",
		e = { ":NvimTreeToggle<cr>", "Toggle the tree" },
		f = { ":NvimTreeFindFile<cr>", "Find file in tree" },
	},

	F = {
		name = "Find",
		f = { "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>", "Find in current buffer" },
	},

	G = {
		name = "Git",
		b = {
			function()
				require("gitsigns").blame_line({ full = true })
			end,
			"Blame",
		},
	},

	D = {
		name = "Database",
		u = { "<Cmd>DBUIToggle<Cr>", "Toggle UI" },
		f = { "<Cmd>DBUIFindBuffer<Cr>", "Find buffer" },
		r = { "<Cmd>DBUIRenameBuffer<Cr>", "Rename buffer" },
		q = { "<Cmd>DBUILastQueryInfo<Cr>", "Last query info" },
	},

	P = {
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
