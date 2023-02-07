local nnoremap = require("mseppae.keymap").nnoremap
local vnoremap = require("mseppae.keymap").vnoremap
local inoremap = require("mseppae.keymap").inoremap

nnoremap("<Space>", ":nohlsearch<Bar>:echo<CR>")
nnoremap("<leader>r", ":%s/<C-r><C-w>//gc<Left><Left><Left>")

nnoremap("H", "^")
nnoremap("L", "$")
vnoremap("H", "^")
vnoremap("L", "$")

nnoremap("<leader>w", ":w<CR>")
nnoremap("<leader>q", ":q<CR>")

-- Move vertically by viasual line
nnoremap("j", "gj")
nnoremap("k", "gk")

nnoremap("<A-j>", ":m .+1<CR>==")
nnoremap("<A-k>", ":m .-2<CR>==")

inoremap("jk", "<esc>")
