#!/bin/bash

# Needs to match the directory this repository is cloned to
project_root=$HOME/Development/dot.files
# Target home is here a variable so we can easily test linking
# and copying to some random test "home" directory
# target_home=$HOME/test
target_home=$HOME
target_root=${target_home}/.config

if [[ ! -d $project_root ]]; then
  echo "Expected dot files to be located in $project_root"
  exit 1
fi

. ./scripts/helpers.sh

#
# Scripts
#

create_directory ${target_root}/scripts
safe_symbolic_link "${project_root}/scripts/*.sh" ${target_root}/scripts

#
# Applications
# 
 
# dunst for doing desktop notifications
dunst_config_dir=${target_root}/dunst

create_directory $dunst_config_dir

safe_symbolic_link $project_root/dunst/dunstrc ${dunst_config_dir}/dunstrc

# i3wm
i3_config_dir=${target_root}/i3
i3_config_plugins_dir=${i3_config_dir}/plugins
i3_config_scripts_dir=${i3_config_dir}/scripts

create_directory $i3_config_plugins_dir
create_directory $i3_config_scripts_dir

if [[ ! -d ${i3_config_dir}/bumblebee-status ]]; then
  git clone "https://github.com/tobi-wan-kenobi/bumblebee-status" ${i3_config_dir}/bumblebee-status
else
  echo "bumblebee-status already cloned..."
fi

safe_symbolic_link $project_root/i3/config ${i3_config_dir}/config

symlink_pattern "$project_root/i3/scripts/*" $i3_config_scripts_dir

# neovim
neovim_dir=${target_root}/nvim
neovim_lsp_dir=${neovim_dir}/lsp
neovim_lua_dir=${neovim_dir}/lua
neovim_plugins_dir=${neovim_lua_dir}/plugins
neovim_configs_dir=${neovim_lua_dir}/config
neovim_custom_telescope_dir=${neovim_configs_dir}/telescope
neovim_custom_git_dir=${neovim_configs_dir}/custom

create_directory $neovim_lsp_dir
create_directory $neovim_plugins_dir
create_directory $neovim_configs_dir
create_directory $neovim_custom_telescope_dir
create_directory $neovim_custom_git_dir

symlink_pattern "$project_root/nvim/lsp/*.lua" $neovim_lsp_dir
symlink_pattern "$project_root/nvim/*.lua" $neovim_dir
symlink_pattern "$project_root/nvim/lua/*.lua" $neovim_lua_dir
symlink_pattern "$project_root/nvim/lua/plugins/*.lua" $neovim_plugins_dir
symlink_pattern "$project_root/nvim/lua/config/*.lua" $neovim_configs_dir
symlink_pattern "$project_root/nvim/lua/config/telescope/*.lua" $neovim_custom_telescope_dir
symlink_pattern "$project_root/nvim/lua/config/custom/*.lua" $neovim_custom_git_dir

# rofi application launcher
rofi_config_dir=${target_root}/rofi
rofi_theme_dir=$rofi_config_dir/themes

create_directory $rofi_config_dir

symlink_pattern "$project_root/rofi/*.rasi" $rofi_config_dir
symlink_pattern "$project_root/rofi/*.sh" $rofi_config_dir

create_directory $rofi_theme_dir
symlink_pattern "$project_root/rofi/themes/*.rasi" $rofi_theme_dir

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

# X11 graphical user interface
x11_config_dir=${target_root}/X11

safe_symbolic_link ${project_root}/X11/Xresources ${target_home}/.Xresources
safe_symbolic_link ${project_root}/X11/xprofile ${target_home}/.xprofile

# hyprland GUI
hyprland_config_dir=${target_root}/hypr

create_directory $hyprland_config_dir

safe_symbolic_link "$project_root/hypr/*.conf" $hyprland_config_dir

# waybar
waybar_config_dir=${target_root}/waybar

create_directory $waybar_config_dir

safe_symbolic_link "${project_root}/waybar/*.jsonc" $waybar_config_dir
safe_symbolic_link "${project_root}/waybar/*.css" $waybar_config_dir
 
# Wallpapers for the eye candy
wallpapers_dir=${target_root}/Wallpapers

create_directory $wallpapers_dir

safe_symbolic_link "$project_root/Wallpapers/*" ${wallpapers_dir}

# greenclip for a copy paste history via dmenu
safe_symbolic_link $project_root/greenclip.toml ${target_root}/greenclip.toml

# picom as a compositor for X11
safe_symbolic_link $project_root/picom.conf ${target_root}/picom.conf

# starship as a cross shell prompt
safe_symbolic_link $project_root/starship.toml ${target_root}/starship.toml

# asdf default versions

safe_symbolic_link $project_root/.tool-versions ${target_home}/.tool-versions
