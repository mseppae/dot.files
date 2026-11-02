local servers = {
  "lua_ls",
  "gopls",
  "ruby_lsp",
--  "sorbet",
  "ts_ls",
  "zig",
  "odin",
}

-- Servers can run project code, so only start them in trusted projects
-- (see lua/config/trust.lua, :Trust).
local trust = require("config.trust")
for _, name in ipairs(servers) do
  trust.gate_lsp(name)
end

vim.lsp.enable(servers)

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
      local opts = { noremap = true, silent = true, buffer = ev.buf }
      -- Neovim's defaults cover the rest: K hover, grn rename, gra code
      -- action, grr references, gri implementation, grt type definition,
      -- gO document symbols, and <C-s> signature help in insert mode.
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)  -- Go to definition
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)  -- Go to declaration

      -- Completion pops up as you type; <C-x><C-o> asks for it by hand.
      vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'fuzzy', 'popup' }
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end

    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
      -- Off by default; toggle per-buffer with <leader>uh
      vim.keymap.set('n', '<leader>uh', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf }), { bufnr = ev.buf })
      end, { buffer = ev.buf, desc = 'Toggle inlay hints' })
    end
  end,
})

vim.diagnostic.config({
  virtual_text = false, -- handled by tiny-inline-diagnostic
  underline = true,
  virtual_lines = false,
})
