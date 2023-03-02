local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end

local nnoremap = require("mseppae.keymap").nnoremap

telescope.setup(
  {
    pickers = {
      buffers = {
        ignore_current_buffer = true,
        sort_mru = true,
      }
    }
  }
)

nnoremap("<C-f>f", "<cmd>Telescope find_files<cr>")
nnoremap("<C-f>g", "<cmd>Telescope live_grep<cr>")
nnoremap("<C-f>b", "<cmd>Telescope buffers<cr>")
nnoremap("<C-f>h", "<cmd>Telescope help_tags<cr>")
nnoremap("<C-f>r", "<cmd>Telescope resume<cr>")
