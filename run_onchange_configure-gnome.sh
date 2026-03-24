#!/bin/bash
set -euo pipefail

# Only run on Bazzite (GNOME)
variant_id="$(. /etc/os-release 2>/dev/null && echo "${VARIANT_ID:-}" || true)"
[[ "$variant_id" == bazzite-gnome* ]] || exit 0

# Require GNOME schemas (not present in minimal containers)
gsettings list-schemas &>/dev/null || { echo "GNOME schemas not installed, skipping"; exit 0; }

# Dash-to-dock: auto-hide behavior
if gsettings list-schemas | grep -q 'org.gnome.shell.extensions.dash-to-dock'; then
  gsettings set org.gnome.shell.extensions.dash-to-dock autohide true
  gsettings set org.gnome.shell.extensions.dash-to-dock intellihide true
  gsettings set org.gnome.shell.extensions.dash-to-dock intellihide-mode 'FOCUS_APPLICATION_WINDOWS'

  # Dash-to-dock: animation timing
  gsettings set org.gnome.shell.extensions.dash-to-dock animation-time 0.2
  gsettings set org.gnome.shell.extensions.dash-to-dock hide-delay 0.2
  gsettings set org.gnome.shell.extensions.dash-to-dock show-delay 0.1
fi

# Keyboard: Caps Lock as Ctrl
gsettings set org.gnome.desktop.input-sources xkb-options "['caps:ctrl_modifier', 'lv3:ralt_switch']"

