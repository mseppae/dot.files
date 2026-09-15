# AGENTS.md

## Repository

This is my personal chezmoi dotfiles repository.

Supported environments are macOS, Bazzite, and Arch Linux.
macOS and Bazzite use Homebrew/Linuxbrew; Arch uses official pacman packages
without Homebrew or a required AUR helper. Bob manages Neovim nightly everywhere.
Claude Code uses its native installer; Codex is optional via `installCodex`.

## Important

- This repository is managed with chezmoi.
- Do not edit files in the target home directory directly when the corresponding source file is managed by chezmoi.
- Prefer modifying the source files in this repository.
- Preserve support for all three environments and machine-specific behavior.
- Do not introduce machine-specific paths or assumptions unless they are explicitly conditional.

## Chezmoi

- `.tmpl` files are chezmoi templates.
- `.chezmoi.toml.tmpl` controls machine-specific chezmoi configuration.
- Use chezmoi template functions rather than shell prompts for machine-specific choices.
- Be careful when modifying `run_once_` and `run_onchange_` scripts because their execution semantics matter.
- `run_once_` tracks successfully executed rendered contents; edits can trigger another run.
- chezmoi copies files, not symlinks. Edit source here or use `chezmoi edit`.
- Source lives in `~/development/dot.files` (or existing `~/Development/dot.files`).

## Repository map

- `dot_` becomes `.` in the destination; `dot_config/` mirrors `~/.config/`.
- `dot_zshenv` sets XDG paths and `ZDOTDIR`; shell config lives in `dot_config/zsh/`.
- `.chezmoiexternal.toml` clones zsh plugins during apply.
- `dot_config/nvim/` has additional guidance in its own `AGENTS.md`.
- `dot_config/wezterm/` has Neovim-aware `Ctrl+hjkl` navigation and `Ctrl+\` leader.
- `dot_config/mise/config.toml` declares language runtimes and tools.
- `.chezmoiignore.tmpl` gates platform configs and excludes machine-local `nvim/lazy-lock.json`.
- Tiling WM configs target Arch; GNOME/KDE configs target Bazzite.
- `Library/LaunchAgents/` is macOS-only; `dot_config/systemd/user/` is Linux-only.
  Service scripts reload and enable user units.
- Bootstrap is `run_once_install-environment.sh.tmpl`; ongoing updates use the
  platform package manager, `mise upgrade`, and `bob update` (or topgrade where installed).

## Testing

Before committing changes:

1. Run `chezmoi diff`.
2. Verify the rendered template where appropriate.
3. Run `chezmoi apply` when testing installation/configuration changes.
4. Do not overwrite unrelated user configuration.

Also use `chezmoi diff` and render affected templates when validating changes.
Validate rendered shell scripts with `bash -n`. Use an isolated destination and
mock installers for bootstrap tests that would otherwise change the host.

## Git

- Keep commit messages concise and descriptive.
- Do not rewrite existing commits unless explicitly asked.
- Do not force-push.
- Do not push changes unless explicitly requested.
- Do not commit unless explicitly requested.

## General

- Inspect the existing implementation before introducing a new pattern.
- Prefer small, idiomatic changes.
- Preserve existing conventions in the repository.
- Prefer 2-space shell indentation and `set -euo pipefail` where applicable.
- Preserve Lua formatting (generally tabs in Neovim/WezTerm); follow nearby code.
- Make no unrelated changes.
