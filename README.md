# Dot.files

Personal dotfiles for macOS, Bazzite, and Arch Linux, managed with [chezmoi](https://www.chezmoi.io/).

## Bootstrap a new machine

Install chezmoi with your platform's package path. On macOS/Bazzite with Homebrew:

```bash
brew install chezmoi
```

On Arch (start with an up-to-date system):

```bash
sudo pacman -Syu --needed chezmoi git curl
```

Then initialize and apply on any supported platform:

```bash
chezmoi init --apply git@github.com:mseppae/dot.files.git
```

chezmoi will:

1. Use `~/development/dot.files` (or existing `~/Development/dot.files`) as its source directory
2. Apply all config files to their destinations
3. Clone zsh plugins via `.chezmoiexternal.toml`
4. Bootstrap tools using Homebrew on macOS/Bazzite or official pacman packages on Arch

All platforms use Bob for Neovim nightly and the native Claude Code installer.
mise uses Homebrew on macOS/Bazzite and its official installer on Arch.
Ghostty uses a Homebrew cask on macOS, COPR/rpm-ostree on Bazzite (reboot required),
and pacman on Arch. Arch bootstrap does not install Homebrew or an AUR helper.

Codex installation is optional per machine; the initialization prompt defaults to
false and saves `installCodex` in the local chezmoi config. Its native installer
runs non-interactively (`CODEX_NON_INTERACTIVE=1`). The same setting also installs
the desktop app with Codex, now distributed as ChatGPT: the `chatgpt` Homebrew
cask on macOS, OpenAI's official installer on Arch (adds its signed package
repository and prompts for a full system upgrade), and the official RPM layered
with rpm-ostree on Bazzite (reboot required). See the
[official desktop installation guide](https://learn.chatgpt.com/docs/linux/linux-app).
Existing CLI installations still receive the desktop app when it is missing.

On existing machines, regenerate config with `chezmoi init`, review `chezmoi diff`,
then run `chezmoi apply`. `run_once_` records successful rendered script contents:
a changed bootstrap (including a changed Codex choice) can run again on apply.

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

Topgrade is installed on macOS/Bazzite. Arch bootstrap omits it to avoid requiring
the AUR; use `sudo pacman -Syu`, `mise upgrade`, and `bob update` there.

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
