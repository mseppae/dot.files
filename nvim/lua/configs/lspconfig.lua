-- EXAMPLE
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = { "html", "cssls", "solargraph", "sorbet", "tsserver" }

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#gopls
lspconfig.gopls.setup {
  on_attach = on_attach,
  on_init = on_init,
  -- https://github.com/golang/tools/blob/master/gopls/doc/settings.md
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      gofumpt = true,
    },
  },
}
-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end
