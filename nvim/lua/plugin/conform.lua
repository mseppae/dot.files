vim.pack.add({
  {
    src = "https://github.com/stevearc/conform.nvim"
  }
})

vim.api.nvim_create_autocmd("BufWritePre", {
  desc = "Format on save",
  callback = function()
    require("conform").format({ async = true, lsp_format = "fallback" })
  end,
})

vim.keymap.set(
  "n",
  "<leader>f",
  ":lua require('conform').format({ async = true, lsp_format = 'fallback' })<CR>",
  {
    silent = true
  }
)

require('conform').setup({
  notify_on_error = true,
  format_on_save = function(bufnr)
    local disable_filetypes = { c = true, cpp = true }
    local lsp_format_opt
    if disable_filetypes[vim.bo[bufnr].filetype] then
      lsp_format_opt = "never"
    else
      lsp_format_opt = "fallback"
    end
    return {
      timeout_ms = 1500,
      lsp_format = lsp_format_opt,
    }
  end,

  formatters_by_ft = {
    lua        = { "stylua" },
    ruby       = { "rubocop" },
    zig        = { "zigfmt" },
    go         = { "goimports-reviser", "gofumpt" },
    json       = { "prettierd" },
    css        = { "prettierd" },
    html       = { "prettierd" },
    javascript = { "prettierd" },
    typescript = { "prettierd" },
  },

  formatters = {
    ["goimports-reviser"] = {
      prepend_args = { "-rm-unused", "-format" },
    },
  },
})
