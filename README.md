# Dot.files

Personal dotfiles for Bazzite, macOS, and Arch Linux (untested), managed with [chezmoi](https://www.chezmoi.io/).

## Bootstrap a new machine

Install chezmoi via Homebrew, then apply:

```bash
brew install chezmoi
chezmoi init --apply git@github.com:mseppae/dot.files.git
```

chezmoi will:
1. Clone this repo to `~/development/dot.files`
2. Apply all config files to their destinations
3. Clone zsh plugins via `.chezmoiexternal.toml`
4. Run `run_once_install-environment.sh` to install Homebrew/Linuxbrew, tools, and language runtimes

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

chezmoi manages config files, not tool lifecycles. Update tools with:

```bash
topgrade       # upgrades brew, mise runtimes, Neovim (bob), and system (Bazzite)
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
- Tiling WM configs (hypr, waybar, rofi, i3, dunst, X11) are excluded on macOS and Bazzite via `.chezmoiignore.tmpl`
- GNOME configs (gtk-3.0, gtk-4.0, gnome-shell) are Bazzite-only
