# Dot.files

All the dot.files, forever work in progress.

## Prerequisities

OSX with homebrew

```
brew install coreutils starship git curl vivid zoxide wezterm
```

## ZSH

ZSH is loading the environment and setting global variables in the .dotenv file, structure:

Currently used plugins (clone inside plugins/):
- [zsh-autocomplete](https://github.com/marlonrichert/zsh-autocomplete)
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)

```
~/.zshenv
~/.config/zsh/plugins/
~/.config/zsh/.zshrc
```

## i3wm

Arch linux setup, heavily based on [EndeavorOS](https://github.com/endeavouros-team/endeavouros-i3wm-setup) setup with i3wm, with some modifications.

```
yay -S rofi-greenclip
```

```
sudo pacman -S xclip
```

Clone [bumblebee-status](https://github.com/tobi-wan-kenobi/bumblebee-status) into ~/.config/i3/

Expected layout:

```
~/.config/i3/bumblebee-status
~/.config/i3/scripts/
~/.config/i3/config
```
