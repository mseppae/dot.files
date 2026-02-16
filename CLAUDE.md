# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code)
when working with code in this repository.

## What This Is

Personal dotfiles for ArchLinux and macOS. Manages configs
for shell (zsh), terminal emulators (WezTerm, Alacritty),
window managers (i3, Hyprland), Neovim, and supporting
tools.

## Setup

```
./setup.sh
```

Symlinks config files into `~/.config/` and `~/`, clones
zsh plugins, copies the nvim directory, and installs tools
via Homebrew (macOS) or provides instructions for manual
install (Linux). Expects the repo at
`~/development/dot.files`.

## Repository Structure

- `nvim/` — Neovim config (has its own `CLAUDE.md`)
- `zsh/` — Shell config: `zshenv-compatible` bootstraps
  XDG paths (symlinked to `~/.zshenv`), `zshenv` sets
  editor/fzf/history vars, `zshrc` loads plugins/aliases
- `wezterm/` — Terminal config with Neovim-aware split
  navigation (`Ctrl+hjkl`) and leader key (`Ctrl+\`)
- `scripts/` — Setup helpers: `helpers.sh` (symlink/mkdir
  utilities), `installenvironment.sh` (Homebrew + mise +
  tool install), `symlinklinux.sh` (Linux-only symlinks)
- `mise/config.toml` — Default language versions
  (node, python, ruby, go, lua, rust)
- Linux-specific: `hypr/`, `waybar/`, `rofi/`, `i3/`,
  `dunst/`, `X11/`
- macOS-specific: `alacritty/`

## Key Patterns

- **Symlinks, not copies**: `setup.sh` uses
  `safe_symbolic_link` (skips if target exists) so
  editing files in this repo updates the live config.
  Exception: `nvim/` is copied, not symlinked.
- **XDG-compliant zsh**: `ZDOTDIR` is set to
  `~/.config/zsh` so zsh config lives under `~/.config/`
  rather than `~/`.
- **Shell style**: 2-space indentation,
  `set -euo pipefail` in scripts.
- **Lua style**: Tabs for indentation in Neovim/WezTerm
  Lua files.