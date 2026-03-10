# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code)
when working with code in this repository.

## What This Is

Personal dotfiles for ArchLinux and macOS, managed with
[chezmoi](https://www.chezmoi.io/). Manages configs for
shell (zsh), terminal emulators (WezTerm, Alacritty),
window managers (i3, Hyprland), Neovim, and supporting
tools.

## Setup

```
chezmoi init --apply git@github.com:mseppae/dot.files.git
```

Deploys config files to `~/.config/` and `~/`, clones zsh
plugins via `.chezmoiexternal.toml`, and runs
`run_once_install-environment.sh.tmpl` to bootstrap
Homebrew, mise, bob, and other tools on first apply.
Repo is pinned to `~/development/dot.files` via
`.chezmoi.toml.tmpl`.

## Repository Structure

Files are organized to mirror their destination paths
(chezmoi convention). `dot_` prefix → `.` in destination.

- `dot_config/nvim/` — Neovim config (has its own `CLAUDE.md`)
- `dot_config/zsh/` — Shell config: `dot_zshenv` sets
  editor/fzf/history vars, `dot_zshrc` loads plugins/aliases
- `dot_zshenv` — Bootstraps XDG paths, sets `ZDOTDIR`
  (deployed to `~/.zshenv`)
- `dot_config/wezterm/` — Terminal config with Neovim-aware
  split navigation (`Ctrl+hjkl`) and leader key (`Ctrl+\`)
- `dot_config/mise/config.toml` — Default language versions
  (node, python, ruby, go, lua, rust)
- `run_once_install-environment.sh.tmpl` — Bootstraps
  Homebrew, zsh, bob (Neovim), mise, Claude Code on first apply
- `.chezmoiexternal.toml` — Declares zsh plugin repos to clone
- `.chezmoiignore.tmpl` — Excludes Linux-only configs on macOS,
  and excludes `nvim/lazy-lock.json` (machine-local)
- Linux-specific: `dot_config/hypr/`, `dot_config/waybar/`,
  `dot_config/rofi/`, `dot_config/i3/`, `dot_config/dunst/`
- macOS-specific: `dot_config/alacritty/`

## Key Patterns

- **chezmoi applies, not symlinks**: `chezmoi apply` copies
  files to their destination. Edit via `chezmoi edit <file>`
  or edit in `~/development/dot.files` then `chezmoi apply`.
- **XDG-compliant zsh**: `ZDOTDIR` is set to
  `~/.config/zsh` so zsh config lives under `~/.config/`
  rather than `~/`.
- **Shell style**: 2-space indentation,
  `set -euo pipefail` in scripts.
- **Lua style**: Tabs for indentation in Neovim/WezTerm
  Lua files.
- **Tool updates are manual**: chezmoi manages config files
  only. Run `brew upgrade`, `mise upgrade`, `bob update`
  separately for tool lifecycle.
