vim.pack.add({
  {
    src = "https://github.com/nvim-telescope/telescope.nvim",
    version = "0.1.x",
  },
  "https://github.com/nvim-lua/plenary.nvim",
})

vim.pack.add({
  {
    src = "https://github.com/nvim-telescope/telescope-live-grep-args.nvim",
    -- This will not install any breaking changes.
    -- For major updates, this must be adjusted manually.
    version = vim.version.range('1'),
  },
})

local telescope = require("telescope")
telescope.load_extension("live_grep_args")

telescope.setup({
  pickers = {
    oldfiles = {
      cwd_only = true,
    },
  },
  extensions = {
    fzf = {},
    live_grep_args = {
      auto_quoting = false, -- enable/disable auto-quoting
      -- define mappings, e.g.
      -- mappings = { -- extend mappings
      -- 	i = {
      -- 		["<C-k>"] = lga_actions.quote_prompt(),
      -- 		["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
      -- 		-- freeze the current list and start a fuzzy search in the frozen list
      -- 		["<C-space>"] = lga_actions.to_fuzzy_refine,
      -- 	},
      -- },
      -- ... also accepts theme settings, for example:
      -- theme = "dropdown", -- use dropdown theme
      -- theme = { }, -- use own theme spec
      -- layout_config = { mirror=true }, -- mirror preview pane
    },
  },
})

local map = vim.keymap.set
map("n", "<leader>sf", "<cmd>Telescope find_files<cr>", { desc = "Search files" })
map("n", "<leader>s.", "<cmd>Telescope oldfiles<cr>", { desc = "Search old files" })
map("n", "<leader>sw", "<cmd>lua require('telescope-live-grep-args.shortcuts').grep_word_under_cursor()<CR>", { desc = "Search word" })
map("v", "<leader>sw", "<cmd>lua require('telescope-live-grep-args.shortcuts').grep_visual_selection()<CR>", { desc = "Search visual" })
map("n", "<leader>sg", "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", { desc = "Search by grep" })
map("n", "<leader>sr", "<cmd>Telescope resume<cr>", { desc = "Resume search" })
map("n", "<leader>sh", "<cmd>Telescope help_tags<cr>", { desc = "Search help" })
map("n", "<leader><leader>", "<cmd>Telescope buffers<cr>", { desc = "Existing buffers" })
