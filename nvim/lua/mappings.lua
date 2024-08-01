-- NOTE: Imported from nvchad since I only want subset of them
-- and rest by if I seem to use them
local map = vim.keymap.set

map("i", "<C-b>", "<ESC>^i", { desc = "Move Beginning of line" })
map("i", "<C-e>", "<End>", { desc = "Move End of line" })
map("i", "<C-h>", "<Left>", { desc = "Move Left" })
map("i", "<C-l>", "<Right>", { desc = "Move Right" })
map("i", "<C-j>", "<Down>", { desc = "Move Down" })
map("i", "<C-k>", "<Up>", { desc = "Move Up" })

map("n", "<Esc>", "<cmd>noh<CR>", { desc = "General Clear highlights" })

map("n", "<C-h>", "<C-w>h", { desc = "Switch Window left" })
map("n", "<C-l>", "<C-w>l", { desc = "Switch Window right" })
map("n", "<C-j>", "<C-w>j", { desc = "Switch Window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Switch Window up" })

map("n", "<C-s>", "<cmd>w<CR>", { desc = "File Save" })

map("n", "<leader>n", "<cmd>set nu!<CR>", { desc = "Toggle Line number" })
map("n", "<leader>rn", "<cmd>set rnu!<CR>", { desc = "Toggle Relative number" })
map("n", "<leader>ch", "<cmd>NvCheatsheet<CR>", { desc = "Toggle NvCheatsheet" })

-- global lsp mappings
map("n", "<leader>lf", vim.diagnostic.open_float, { desc = "Lsp floating diagnostics" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Lsp prev diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Lsp next diagnostic" })
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Lsp diagnostic loclist" })

-- Comment
map("n", "<leader>/", "gcc", { desc = "Comment Toggle", remap = true })
map("v", "<leader>/", "gc", { desc = "Comment Toggle", remap = true })

-- nvimtree
map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "Nvimtree Toggle window" })
map("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "Nvimtree Focus window" })

-- terminal
map("t", "<C-x>", "<C-\\><C-N>", { desc = "Terminal Escape terminal mode" })

map({ "n", "t" }, "<A-i>", function()
  require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end, { desc = "Terminal Toggle Floating term" })

map("t", "<ESC>", function()
  local win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_close(win, true)
end, { desc = "Terminal Close term in terminal mode" })

-- whichkey
map("n", "<leader>wK", "<cmd>WhichKey <CR>", { desc = "Whichkey all keymaps" })

map("n", "<leader>wk", function()
  vim.cmd("WhichKey " .. vim.fn.input "WhichKey: ")
end, { desc = "Whichkey query lookup" })

-- NOTE: Start of own keymaps

-- Inspired by kickstarter.nvim
-- Transition to [S]earch from [F]ind
-- See `:help telescope.builtin`
local builtin = require "telescope.builtin"
-- local wk = require "which-key"
-- wk.add {
--   { "<leader>s", group = "Search" },
--   { "<leader>sh", builtin.help_tags, desc = "[S]earch [H]elp" },
--   { "<leader>sk", builtin.keymaps, desc = "[S]earch [K]eymaps" },
--   { "<leader>sf", builtin.find_files, desc = "[S]earch [F]iles" },
--   { "<leader>ss", builtin.builtin, desc = "[S]earch [S]elect Telescope" },
--   { "<leader>sw", builtin.grep_string, desc = "[S]earch current [W]ord" },
--   { "<leader>sg", builtin.live_grep, desc = "[S]earch by [G]rep" },
--   { "<leader>sd", builtin.diagnostics, desc = "[S]earch [D]iagnostics" },
--   { "<leader>sr", builtin.resume, desc = "[S]earch [R]esume" },
--   { "<leader>s.", builtin.oldfiles, desc = '[S]earch Recent Files ("." for repeat)' },
--   { "<leader>st", "<cmd>Telescope themes<CR>", desc = "[S]earch [T]hemes" },
--   { "<leader>sn", "<cmd>TodoTelescope<CR>", desc = "[S]earch [N]otes" },
--   { "<leader><leader>", builtin.buffers, desc = "[ ] Find existing buffers" },
--   {
--     "<leader>s/",
--     function()
--       builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
--         winblend = 10,
--         previewer = false,
--       })
--     end,
--     desc = "[/] Fuzzily search in current buffer",
--   },
-- }

vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set("n", "<leader>st", "<cmd>Telescope themes<CR>", { desc = "[S]earch [T]hemes" })
vim.keymap.set("n", "<leader>sn", "<cmd>TodoTelescope<CR>", { desc = "[S]earch [N]otes" })
vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

-- Slightly advanced example of overriding default behavior and theme
vim.keymap.set("n", "<leader>s/", function()
  -- You can pass additional configuration to Telescope to change the theme, layout, etc.
  builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = "[/] Fuzzily search in current buffer" })

-- map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>cww", 'yiw<Esc>:%s/<c-r>"//gc<Left><Left><Left>', { desc = "Confirm replace nearest word" })
map("n", "<leader>cw'", "yi'<Esc>:%s/<c-r>\"//gc<Left><Left><Left>", { desc = "Confirm replace nearest '" })
map("n", '<leader>cw"', 'yi"<Esc>:%s/<c-r>"//gc<Left><Left><Left>', { desc = 'Confirm replace nearest "' })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

local harpoon = require "harpoon"
harpoon:setup()

map("n", "<leader>ha", function()
  harpoon:list():add()
end, { desc = "Add to harpoon list" })
map("n", "<leader>hd", function()
  harpoon:list():remove()
end, { desc = "Remove from harpoon list" })
map("n", "<leader>hc", function()
  harpoon:list():clear()
end, { desc = "Clear the harpoon list" })
map("n", "<C-e>", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end)

map("n", "<C-1>", function()
  harpoon:list():select(1)
end)
map("n", "<C-2>", function()
  harpoon:list():select(2)
end)
map("n", "<C-3>", function()
  harpoon:list():select(3)
end)
map("n", "<C-4>", function()
  harpoon:list():select(4)
end)

-- Toggle previous & next buffers stored within Harpoon list
map("n", "<C-a>", function()
  harpoon:list():prev()
end)
map("n", "<C-s>", function()
  harpoon:list():next()
end)

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- TODO: should only be enabled for .http filetype
map("n", "<leader>rr", "<cmd>Rest run<CR>", { desc = "REST run" })
