local nvim_tree_status_ok, nvim_tree = pcall(require, "nvim-tree")
if not nvim_tree_status_ok then
	return
end

local nnoremap = require("mseppae.keymap").nnoremap

nvim_tree.setup({
	disable_netrw = true,
	hijack_netrw = true,
})

nnoremap("<leader>e", ":NvimTreeToggle<cr>")
