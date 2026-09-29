# Dot.files

Personal dotfiles for macOS, Bazzite, and Arch Linux (including Omarchy), managed with [chezmoi](https://www.chezmoi.io/).

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
4. Install zsh and mise using Homebrew on macOS/Bazzite or official pacman packages on Arch
5. Install runtimes and CLI tools with `mise install`

mise installs the same CLI tools everywhere (gh, topgrade, bob, starship,
zoxide, vivid, ripgrep, plus Claude Code, Codex, and Pi when enabled), declared in
`dot_config/mise/conf.d/`. chezmoi does not manage `~/.config/mise/config.toml`,
so `mise use -g` (and Omarchy's tool wrappers) can write to it freely; a tool
pinned there overrides the `conf.d` version. Bob installs Neovim nightly.
Ghostty uses a Homebrew cask on macOS, COPR/rpm-ostree on Bazzite (reboot required),
and pacman on Arch. Arch bootstrap does not install Homebrew or an AUR helper.

Claude, Codex, Pi, and Blender are optional per machine. `chezmoi init` asks once
for each and saves `installClaude` (default true), `installCodex`, `installPi`, and
`installBlender` (default false) in the local chezmoi config. The first three
install their CLI with mise; Claude and Codex also install their desktop app with
the OS package manager (mise does not manage desktop apps), and Pi is CLI-only.
Blender is a desktop app only:

| Desktop app | macOS | Omarchy | Arch | Bazzite |
|---|---|---|---|---|
| Claude Desktop | `claude` cask | `claude-desktop` (Omarchy repo) | not installed (AUR only) | not installed (no Fedora package) |
| Blender | `blender` cask | `blender` (pacman) | `blender` (pacman) | `org.blender.Blender` from Flathub (no reboot) |
| ChatGPT with Codex | `chatgpt` cask | `openai-codex-desktop` (Omarchy repo) | OpenAI's signed pacman repository, key fingerprint pinned (prompts for a full system upgrade) | OpenAI's signed RPM repository via rpm-ostree (reboot required) |

Omarchy's packages update with `omarchy-update`. See Claude's
[download page](https://claude.com/download) and OpenAI's
[desktop installation guide](https://learn.chatgpt.com/docs/linux/linux-app).
Existing CLI installations still receive the desktop app when it is missing.
With Blender enabled, `run_after_install-blender-extensions.sh` also keeps the
LoopTools extension installed on every apply.

On existing machines, regenerate config with `chezmoi init`, review `chezmoi diff`,
then run `chezmoi apply`. `run_once_` records successful rendered script contents:
a changed bootstrap (including a changed Claude or Codex choice) can run again on apply.
A changed Pi choice only edits mise's `conf.d`; run `mise install` to add Pi.

## Daily use

```bash
# Pull latest dotfiles, review, then apply (run_ scripts may use sudo)
chezmoi git pull -- --ff-only
chezmoi diff
chezmoi apply

# Edit a dotfile (opens in $EDITOR, re-applies on save)
chezmoi edit ~/.config/zsh/.zshrc

# After manually editing a file in ~/development/dot.files
chezmoi apply
```

## Tool updates

chezmoi manages config files, not tool lifecycles. Update tools with:

```bash
topgrade       # upgrades brew, mise tools, Neovim (bob), and system (Bazzite/Omarchy)
```

topgrade deliberately skips its chezmoi step, which would pull and apply
dotfiles without review.

On Omarchy, topgrade runs `omarchy-update`, which upgrades system packages and
mise tools, instead of its own mise step. On plain Arch, upgrade system packages
with `sudo pacman -Syu`.

## Neovim

### Clearing lazy.nvim cache

If plugins aren't updating or disabled plugins still load, clear the cache:

```bash
rm -rf ~/.local/share/nvim/lazy/<plugin-name>
rm -f ~/.local/state/nvim/lazy/pkg-cache.lua
```

Then restart neovim completely (`:qa!` and reopen).

## Notes

- Config files live under `dot_config/` in this repo (mirrors `~/.config/`)
- `dot_zshenv` → `~/.zshenv` (XDG bootstrap for zsh)
- `nvim/lazy-lock.json` is tracked, so every machine installs the same plugin
  commits. After `:Lazy update`, check `chezmoi diff`, then
  `chezmoi re-add ~/.config/nvim/lazy-lock.json` and commit
- zsh plugins in `.chezmoiexternal.toml` are pinned to a commit and checksum;
  update both together
- On Omarchy, Ghostty loads Omarchy's packaged defaults (theme, font) and applies personal settings on top; `xdg-terminals.list` makes it the default terminal (Super+Return)
- Shell: zsh on macOS, Bazzite, and Arch; Omarchy keeps bash with its own defaults
  (aliases, fzf, mise, starship, zoxide). `dot_bashrc` (Omarchy only) layers personal
  settings on top; zsh config and plugins are not deployed there
- GNOME configs (gtk-3.0, gtk-4.0, gnome-shell) are Bazzite-only
