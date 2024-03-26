require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map(
  "n",
  "<leader>cw",
  '<Esc>:%s/<c-r>"//gc<Left><Left><Left>',
  { desc = 'Confirm replace " register with new content' }
)

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
