local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    ruby = { "solargraph" },
    go = { "goimports", "gofmt" },
    css = { { "prettierd", "prettier" } },
    html = { { "prettierd", "prettier" } },
  },

  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
}

require("conform").setup(options)
