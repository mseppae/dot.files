local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

return packer.startup(function(use)
	-- Packer plugin management and some base supporting plugins
	use({ "wbthomason/packer.nvim", commit = "4dedd3b08f8c6e3f84afbce0c23b66320cd2a8f2" })
	use({ "nvim-lua/plenary.nvim", commit = "31807eef4ed574854b8a53ae40ea3292033a78ea" })

	-- Syntax highlighting
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end,
		commit = "e7b5e92d46355919e96e78f596bd5297c9ef77dd",
	})

	-- Colorscheme and outlooks
	use({ "folke/tokyonight.nvim", commit = "8223c970677e4d88c9b6b6d81bda23daf11062bb" })
	use({ "kyazdani42/nvim-web-devicons", commit = "2d02a56189e2bde11edd4712fea16f08a6656944" })
	use({ "nvim-lualine/lualine.nvim", commit = "7b4b864af7e3f528f3bfdb4ab0512d2fcff3c39d" })
	use({ "lewis6991/gitsigns.nvim", tag = "release" })

	-- Completion
	use({ "hrsh7th/nvim-cmp", commit = "983453e32cb35533a119725883c04436d16c0120" })
	use({ "hrsh7th/cmp-buffer", commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa" })
	use({ "hrsh7th/cmp-path", commit = "447c87cdd6e6d6a1d2488b1d43108bfa217f56e1" })
	use({ "hrsh7th/cmp-cmdline", commit = "9c0e331fe78cab7ede1c051c065ee2fc3cf9432e" })
	use({ "saadparwaiz1/cmp_luasnip", commit = "b10829736542e7cc9291e60bab134df1273165c9" })
	use({ "hrsh7th/cmp-nvim-lsp", commit = "affe808a5c56b71630f17aa7c38e15c59fd648a8" })

	-- Snippets
	use({ "L3MON4D3/LuaSnip", commit = "faa525713e1244551877a4d89646a10f3c3fa31e" })
	use({ "rafamadriz/friendly-snippets", commit = "6227548c97d7bd7d2f5f0897814c16649fcce368" })

	-- Language Server Protocol
	use({ "williamboman/mason.nvim", commit = "00437b8fb48a19fdbe65afcdf53fd0a911b13f04" })
	use({ "williamboman/mason-lspconfig.nvim", commit = "d9365e72afb2f876a62cd3cade555dc1a95031d9" })
	use({ "neovim/nvim-lspconfig", commit = "ae2d6161e1b0c7610ad271e68ffb9afdacebe209" })
	use({ "jose-elias-alvarez/null-ls.nvim", commit = "5b745e5fa2a18a2c0df8966080f4321fad4f42d7" })

	-- Fuzzy finder
	use({ "nvim-telescope/telescope.nvim", tag = "0.1.0" })
	-- File explorer
	use({ "kyazdani42/nvim-tree.lua", commit = "9fd7b7ae2920cc349644b5d45785e2a655ffdfe9" })
	-- Terminal toggle in vim
	use({ "akinsho/toggleterm.nvim", tag = "v2.1.0" })

	-- Helpful things
	-- Close opening {} [] {} '' ""
	use({ "windwp/nvim-autopairs", commit = "b7672cd49e7c59114ad455205709f918b5430413" })
	-- Quick commenting
	use({ "numToStr/Comment.nvim", commit = "ba5903b88c0a43fdc94abe79ade2b8291ff661ed" })
	use({ "JoosepAlviste/nvim-ts-context-commentstring", commit = "a0fdebebb1f72492948292398558d5713b54e9f1" })

	-- Vimwiki
	use({ "vimwiki/vimwiki", commit = "63af6e72dd3fa840bffb3ebcb8c96970c02e0913" })

	use({ "folke/trouble.nvim", commit = "da61737d860ddc12f78e638152834487eabf0ee5" })
end)
