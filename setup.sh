#!/bin/bash

set -euo pipefail

OS="$(uname -s)"

# Needs to match the directory this repository is cloned to
project_root=$HOME/development/dot.files
# Target home is here a variable so we can easily test linking
# and copying to some random test "home" directory
# target_home=$HOME/test
target_home=$HOME
target_root=${target_home}/.config

. ./scripts/helpers.sh

# Scripts

create_directory ${target_root}/scripts

# Enable nullglob (so the glob expands to nothing if no matches)
shopt -s nullglob

# Glob **only regular files** (skip directories, symlinks, etc.)
for file in "${project_root}/scripts/*.sh"; do
    # Skip if it's not a regular file
    [[ -f "${file}" ]] || continue

    # Call the function with the full path
    safe_symbolic_link "${file}" "${target_root}/scripts/${file}"
done

# turn nullglob back off
shopt -u nullglob

# OS specific setup
. ./scripts/installenvironment.sh
. ./scripts/symlinklinux.sh

# Applications

## neovim
neovim_src_dir=${project_root}/nvim
neovim_trg_dir=${target_root}/nvim

[[ -d ${neovim_trg_dir} ]] && mv ${neovim_trg_dir} "${neovim_trg_dir}.$(date +%Y%m%d-%H%M%S)"
create_directory $neovim_trg_dir
cp -r ${neovim_src_dir} ${target_root}

# zsh shell
zsh_config_dir=${target_root}/zsh
zsh_plugins_dir=${zsh_config_dir}/plugins

create_directory $zsh_plugins_dir

if [[ ! -d ${zsh_plugins_dir}/zsh-autocomplete ]]; then
  git clone "https://github.com/marlonrichert/zsh-autocomplete" ${zsh_plugins_dir}/zsh-autocomplete
else
  echo "zsh-autocomplete already cloned..."
fi

if [[ ! -d ${zsh_plugins_dir}/zsh-completions ]]; then
  git clone "https://github.com/zsh-users/zsh-completions.git" ${zsh_plugins_dir}/zsh-completions
else
  echo "zsh-completions already cloned..."
fi

if [[ ! -d ${zsh_plugins_dir}/zsh-syntax-highlighting ]]; then
  git clone "https://github.com/zsh-users/zsh-syntax-highlighting.git" ${zsh_plugins_dir}/zsh-syntax-highlighting
else
  echo "zsh-syntax-highlighting already cloned..."
fi

safe_symbolic_link $project_root/zsh/zshenv-compatible ${target_home}/.zshenv
safe_symbolic_link $project_root/zsh/zshenv ${zsh_config_dir}/.zshenv
safe_symbolic_link $project_root/zsh/zshrc ${zsh_config_dir}/.zshrc

# wezterm terminal emulator
wezterm_config_dir=${target_root}/wezterm

create_directory $wezterm_config_dir

safe_symbolic_link $project_root/wezterm/wezterm.lua ${wezterm_config_dir}/wezterm.lua

# Alacritty terminal emulator
alacritty_config_dir=${target_root}/alacritty

create_directory $alacritty_config_dir

safe_symbolic_link $project_root/alacritty/alacritty.toml ${alacritty_config_dir}/alacritty.toml

# starship as a cross shell prompt
safe_symbolic_link $project_root/starship.toml ${target_root}/starship.toml

# mise default versions

create_directory ${target_root}/mise
safe_symbolic_link $project_root/mise/config.toml ${target_root}/mise/config.toml

echo "Setup complete!"
