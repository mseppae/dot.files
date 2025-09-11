vim.pack.add({
  {
    src = 'https://github.com/MeanderingProgrammer/render-markdown.nvim',
  },
  -- dependencies
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/nvim-tree/nvim-web-devicons",
})

require('render-markdown').setup({ latex = { enabled = false } })
