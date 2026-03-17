#!/bin/bash
set -euo pipefail

# Only run on Bazzite (KDE Plasma)
variant_id="$(. /etc/os-release 2>/dev/null && echo "${VARIANT_ID:-}" || true)"
[[ "$variant_id" == "bazzite" ]] || exit 0

# Require kwriteconfig6 (KDE config tool)
command -v kwriteconfig6 &>/dev/null || { echo "kwriteconfig6 not found, skipping"; exit 0; }

# Keyboard: Caps Lock as Ctrl
kwriteconfig6 --file kxkbrc --group Layout --key LayoutList "us"
kwriteconfig6 --file kxkbrc --group Layout --key Options "ctrl:nocaps"
kwriteconfig6 --file kxkbrc --group Layout --key ResetOldOptions "true"
kwriteconfig6 --file kxkbrc --group Layout --key Use "true"

# Default terminal: Ghostty
kwriteconfig6 --file kdeglobals --group General --key TerminalApplication "ghostty"
kwriteconfig6 --file kdeglobals --group General --key TerminalService "ghostty.desktop"

# Notify KWin to reload config (picks up kxkbrc changes)
if command -v qdbus &>/dev/null; then
  qdbus org.kde.KWin /KWin reconfigure &>/dev/null && echo "KWin reconfigured." || true
elif command -v dbus-send &>/dev/null; then
  dbus-send --session --print-reply --dest=org.kde.KWin /KWin org.kde.KWin.reconfigure &>/dev/null || true
fi
