require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

-- map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>cww", 'yiw<Esc>:%s/<c-r>"//gc<Left><Left><Left>', { desc = "Confirm replace nearest word" })
map("n", "<leader>cw'", "yi'<Esc>:%s/<c-r>\"//gc<Left><Left><Left>", { desc = "Confirm replace nearest '" })
map("n", '<leader>cw"', 'yi"<Esc>:%s/<c-r>"//gc<Left><Left><Left>', { desc = 'Confirm replace nearest "' })

-- Telescope
map("n", '<leader>fs', '<cmd>Telescope grep_string<CR>', { desc = 'Find string under cursor' })
map("n", '<leader>f<CR>', '<cmd>Telescope resume<CR>', { desc = 'Resume last search' })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
