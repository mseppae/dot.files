#!/bin/bash

set -euo pipefail

if [[ "$DISTRO" == "arch" ]]; then
  # dunst for doing desktop notifications
  #
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

  # rofi application launcher
  rofi_config_dir=${target_root}/rofi
  rofi_theme_dir=$rofi_config_dir/themes

  create_directory $rofi_config_dir

  symlink_pattern "$project_root/rofi/*.rasi" $rofi_config_dir
  symlink_pattern "$project_root/rofi/*.sh" $rofi_config_dir

  create_directory $rofi_theme_dir
  symlink_pattern "$project_root/rofi/themes/*.rasi" $rofi_theme_dir

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
fi
