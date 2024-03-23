# Dot.files

User setup for ArchLinux and OSX.

## Prerequisities

OSX with [homebrew](https://brew.sh/)

```
brew install coreutils starship git curl vivid zoxide wezterm fzf diff-so-fancy
```

ArchLinux with pacman and yay on EndeavorOS with i3

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

### Post setup

Use diff so fancy:

```
git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX
```
