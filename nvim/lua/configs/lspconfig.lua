local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local util = require "lspconfig/util"

local servers = {
  html = {},
  cssls = {},
  ruby_lsp = {
    cmd = {
      vim.fn.expandcmd "~/.asdf/shims/ruby-lsp",
    },
  },
  sorbet = {
    cmd = {
      "bundle",
      "exec",
      "srb",
      "tc",
      "--lsp",
    },
    root_dir = util.root_pattern "sorbet/",
  },
  tsserver = {},
  -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#gopls
  gopls = {
    -- https://github.com/golang/tools/blob/master/gopls/doc/settings.md
    settings = {
      gopls = {
        -- Just as fast debugging thing that the settings structure is correct
        analyses = {
          appends = true,
        },
        gofumpt = true,
      },
    },
  },
}

-- lsps with default config
for server, options in pairs(servers) do
  local localoptions = {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
  local combinedoptions = vim.tbl_deep_extend("force", localoptions, options)
  lspconfig[server].setup(combinedoptions)
end
