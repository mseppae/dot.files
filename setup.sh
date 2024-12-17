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

function safe_symbolic_link {
  if [[ -z $1 ]]; then
    echo "source file not provided"
    exit 1
  fi
  
  if [[ -z $2 ]]; then
    echo "target file not provided"
    exit 1
  fi
  
  if [[ -f $2 ]]; then
    echo "File $2 exists, skipping..."
  else
    echo "Linking file $1 to $2"
    ln -s $1 $2
  fi
}

function create_directory {
  if [[ -z $1 ]]; then
    echo "directory name not provided"
    exit 1
  fi
  
  if [[ ! -d $1 ]]; then
    echo "Creating directory $1"
    mkdir -p $1
  fi
}

function symlink_pattern {
  if [[ -z $1 ]]; then
    echo "no source pattern provided"
    exit 1
  fi
  
  if [[ -z $2 ]]; then
    echo "no target location provided"
    exit 1
  fi

  target_directory=$2
  
  for filename in $1; do
    if [[ -z $filename ]]; then
      continue
    fi
    basename="$(basename $filename)"

    safe_symbolic_link $filename ${target_directory}/$basename
  done
}

#
# Applications
# 

 
# dunst for doing desktop notifications
dunst_config_dir=${target_root}/dunst

create_directory $dunst_config_dir

safe_symbolic_link $project_root/dunst/dunstrc ${dunst_config_dir}/dunstrc

# i3wm for handling the windows
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

# neovim for editing any kind of text
neovim_dir=${target_root}/nvim
neovim_lua_dir=${neovim_dir}/lua
neovim_plugins_dir=${neovim_lua_dir}/plugins
neovim_configs_dir=${neovim_lua_dir}/config
neovim_custom_telescope_dir=${neovim_configs_dir}/telescope

create_directory $neovim_plugins_dir
create_directory $neovim_configs_dir
create_directory $neovim_custom_telescope_dir

symlink_pattern "$project_root/nvim/*.lua" $neovim_dir
symlink_pattern "$project_root/nvim/lua/*.lua" $neovim_lua_dir
symlink_pattern "$project_root/nvim/lua/plugins/*.lua" $neovim_plugins_dir
symlink_pattern "$project_root/nvim/lua/config/*.lua" $neovim_configs_dir
symlink_pattern "$project_root/nvim/lua/config/telescope/*.lua" $neovim_custom_telescope_dir

# rofi as an application launcher
rofi_config_dir=${target_root}/rofi

create_directory $rofi_config_dir

symlink_pattern "$project_root/rofi/*.rasi" $rofi_config_dir

# zsh as a shell
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

safe_symbolic_link $project_root/zsh/zshenv ${target_home}/.zshenv
safe_symbolic_link $project_root/zsh/zshrc ${zsh_config_dir}/.zshrc

# wezterm as a terminal emulator
wezterm_config_dir=${target_root}/wezterm

create_directory $wezterm_config_dir

safe_symbolic_link $project_root/wezterm/wezterm.lua ${wezterm_config_dir}/wezterm.lua

# X11 as a graphical user interface
x11_config_dir=${target_root}/X11

safe_symbolic_link ${project_root}/X11/Xresources ${target_home}/.Xresources
safe_symbolic_link ${project_root}/X11/xprofile ${target_home}/.xprofile

# greenclip for a copy paste history via dmenu
safe_symbolic_link $project_root/greenclip.toml ${target_root}/greenclip.toml

# picom as a compositor for X11
safe_symbolic_link $project_root/picom.conf ${target_root}/picom.conf

# starship as a cross shell prompt
safe_symbolic_link $project_root/starship.toml ${target_root}/starship.toml
 
# Wallpapers for the eye candy
wallpapers_dir=${target_root}/Wallpapers

create_directory $wallpapers_dir
