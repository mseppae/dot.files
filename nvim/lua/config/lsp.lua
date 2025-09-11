vim.lsp.enable(
  {
    "lua_ls",
    "gopls",
    "ruby_lsp",
--    "sorbet",
    "zig",
  }
)

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
      local opts = { noremap = true, silent = true }
      -- Keymaps for LSP features (only active in buffers with LSP attached)
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)  -- Go to definition
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)  -- Go to declaration
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)  -- Go to implementation
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)  -- Hover info
      vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)  -- Signature help
      vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)  -- Rename
      vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, opts)  -- Code actions
      vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)  -- Find refere

      vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'fuzzy', 'popup' }
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
      vim.keymap.set('i', '<esc>', function()
        vim.lsp.completion.get()
      end)
    end
  end,
})

vim.diagnostic.config({
  virtual_text = {
    source = true,
    prefix = "●",
    spacing = 2,
  },
  underline = true,
  virtual_lines = false,
})
