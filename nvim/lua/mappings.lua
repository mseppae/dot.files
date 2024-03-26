require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>cww", 'yiw<Esc>:%s/<c-r>"//gc<Left><Left><Left>', { desc = "Confirm replace nearest word" })
map("n", "<leader>cw'", "yi'<Esc>:%s/<c-r>\"//gc<Left><Left><Left>", { desc = "Confirm replace nearest '" })
map("n", '<leader>cw"', 'yi"<Esc>:%s/<c-r>"//gc<Left><Left><Left>', { desc = 'Confirm replace nearest "' })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
