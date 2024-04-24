require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

-- map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>cww", 'yiw<Esc>:%s/<c-r>"//gc<Left><Left><Left>', { desc = "Confirm replace nearest word" })
map("n", "<leader>cw'", "yi'<Esc>:%s/<c-r>\"//gc<Left><Left><Left>", { desc = "Confirm replace nearest '" })
map("n", '<leader>cw"', 'yi"<Esc>:%s/<c-r>"//gc<Left><Left><Left>', { desc = 'Confirm replace nearest "' })

-- Telescope
map("n", "<leader>fs", "<cmd>Telescope grep_string<CR>", { desc = "Find string under cursor" })
map("n", "<leader>f<CR>", "<cmd>Telescope resume<CR>", { desc = "Resume last search" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

require("cloak").setup {
  cloak_length = 12,
  patterns = {
    {
      -- Match any file starting with '.env'.
      -- This can be a table to match multiple file patterns.
      file_pattern = { ".env*", "passwd", "*.toml" },
      -- Match an equals sign and any character after it.
      -- This can also be a table of patterns to cloak,
      -- example: cloak_pattern = { ':.+', '-.+' } for yaml files.
      cloak_pattern = "=.+",
      -- A function, table or string to generate the replacement.
      -- The actual replacement will contain the 'cloak_character'
      -- where it doesn't cover the original text.
      -- If left empty the legacy behavior of keeping the first character is retained.
      replace = nil,
    },
  },
}

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
