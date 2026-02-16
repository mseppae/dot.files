# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when
working with code in this repository.

## What This Is

Personal Neovim configuration targeting the **nightly build**. Uses
Neovim's native LSP client (not nvim-lspconfig) and lazy.nvim for
plugin management.

## Architecture

**Entry point**: `init.lua` loads config modules in order:
globals → lazy → commands → options → mappings → lsp

**Key directories**:
- `lua/config/` — Core configuration (options, keymaps, LSP setup,
  lazy.nvim bootstrap)
- `lua/plugins/` — Plugin specs loaded automatically by lazy.nvim
  via `{ import = "plugins" }`
- `lsp/` — Native LSP server configs (Neovim 0.11+
  `vim.lsp.enable()` style, NOT nvim-lspconfig)

**LSP approach**: Uses Neovim's built-in LSP support with
`vim.lsp.enable()` and files in `lsp/` directory. Each file in
`lsp/` exports a table with `cmd`, `root_markers`, and `settings`.
Mason installs the actual language server binaries. Formatting is
handled separately by conform.nvim (not the LSP servers).

**Leader key**: Space (`<leader>` = `" "`)

## Active LSPs

lua_ls, gopls, ruby_lsp, ts_ls, zls (sorbet is commented out)

## Important Patterns

- Plugin files return a lazy.nvim spec table (or array of tables)
- Indentation is tabs in Lua files, 2-space width
- Window navigation uses smart-splits.nvim with Wezterm multiplexer
  integration (`<C-h/j/k/l>`)
- Colorscheme is `vague.nvim` with custom dark palette
- Copilot is disabled; Claude Code integration (claudecode.nvim)
  is active
- Format-on-save is enabled via conform.nvim (1500ms timeout,
  LSP fallback)
- Go formatting: goimports-reviser + gofumpt (via conform,
  not gopls)

## Testing Changes

No test suite. To validate changes, open Neovim and verify
behavior. Use `:checkhealth` for diagnostics. Use `:Lazy` to
manage plugins.