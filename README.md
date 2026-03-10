# Dot.files

Personal dotfiles for ArchLinux and macOS, managed with [chezmoi](https://www.chezmoi.io/).

## Bootstrap a new machine

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply mseppae
```

Or if chezmoi is already installed:

```bash
chezmoi init --apply git@github.com:mseppae/dot.files.git
```

chezmoi will:
1. Clone this repo to `~/development/dot.files`
2. Apply all config files to their destinations
3. Clone zsh plugins via `.chezmoiexternal.toml`
4. Run `run_once_install-environment.sh` to install Homebrew, tools, and language runtimes

## Daily use

```bash
# Pull latest dotfiles and apply
chezmoi update

# Preview what would change before applying
chezmoi diff

# Edit a dotfile (opens in $EDITOR, re-applies on save)
chezmoi edit ~/.config/zsh/.zshrc

# After manually editing a file in ~/development/dot.files
chezmoi apply
```

## Tool updates

chezmoi manages config files, not tool lifecycles. Update tools manually:

```bash
topgrade       # upgrades brew, mise runtimes, and Neovim (bob)
```

## Neovim

### Clearing lazy.nvim cache

If plugins aren't updating or disabled plugins still load, clear the cache:

```bash
rm -rf ~/.config/local/share/nvim/lazy/<plugin-name>
rm -f ~/.local/state/nvim/lazy/pkg-cache.lua
```

Then restart neovim completely (`:qa!` and reopen).

## Notes

- Config files live under `dot_config/` in this repo (mirrors `~/.config/`)
- `dot_zshenv` → `~/.zshenv` (XDG bootstrap for zsh)
- `nvim/lazy-lock.json` is excluded from chezmoi tracking (machine-local)
- Linux-only configs (hypr, waybar, rofi, i3, dunst, X11) are excluded on macOS via `.chezmoiignore.tmpl`
