vim.pack.add({
  {
    src = "https://github.com/mrjones2014/smart-splits.nvim",
  }
})

require('smart-splits').setup(
  {
    opts = {
      multiplexer_integration = "wezterm", -- Enable Wezterm support
      at_edge = "wrap",                 -- Wrap to opposite side when at edge (or set to "stop")
      default_amount = 3,               -- Default resize amount
      ignored_filetypes = { "nofile", "quickfix", "prompt" },
      ignored_buftypes = { "NvimTree" },
      log_level = "info",
    },
  }
)

local smart_splits = require("smart-splits")
vim.keymap.set("n", "<C-h>", smart_splits.move_cursor_left, { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-j>", smart_splits.move_cursor_down, { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", smart_splits.move_cursor_up, { desc = "Move focus to the upper window" })
vim.keymap.set("n", "<C-l>", smart_splits.move_cursor_right, { desc = "Move focus to the right window" })
