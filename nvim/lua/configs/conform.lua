local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    ruby = { "rubocop" },
    go = { "goimports", "gofmt" },
    css = { "prettier", "prettierd" },
    html = { "prettier", "prettierd" },
  },

  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
}

require("conform").setup(options)
