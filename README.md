# Dot.files

User setup for ArchLinux and OSX.

## Prerequisities

### OSX with [homebrew](https://brew.sh/)

```
brew install coreutils starship git curl vivid zoxide wezterm fzf diff-so-fancy
```

### Deprecated: ArchLinux with pacman and yay on EndeavorOS with i3

```
sudo pacman -S starship vivid zoxide wezterm xclip fzf diff-so-fancy
```

```
yay -S rofi-greenclip
```

## Setup
Run the setup script, which creates the directories and links the files.

```
./setup.sh
```

### ArchLinux with Hyprland

Coming soon.

### Post setup

Use diff so fancy:

```
git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX
```

## Neovim

### Clearing lazy.nvim cache

If plugins aren't updating or disabled plugins still load, clear the cache:

```
rm -rf ~/.config/local/share/nvim/lazy/<plugin-name>
rm -f ~/.local/state/nvim/lazy/pkg-cache.lua
```

Then restart neovim completely (`:qa!` and reopen).
