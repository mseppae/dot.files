local status_ok, trouble = pcall(require, "trouble")
if not status_ok then
	return
end

local nnoremap = require("mseppae.keymap").nnoremap

trouble.setup()

nnoremap("<leader>xx", "<cmd>Trouble<cr>")
nnoremap("<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>")
nnoremap("<leader>xd", "<cmd>Trouble document_diagnostics<cr>")
nnoremap("<leader>xl", "<cmd>Trouble loclist<cr>")
nnoremap("<leader>xq", "<cmd>Trouble quickfix<cr>")
nnoremap("<leader>qR", "<cmd>Trouble lsp_references<cr>")
