#!/bin/bash
set -euo pipefail

# Agent/CLI tokens moved from zsh-only ~/.config/zsh/.zshwork to
# ~/.config/shell/secrets.sh, which both zsh and bash load. Move an existing
# file once (mv keeps its permissions); never overwrite the new one.

config="${XDG_CONFIG_HOME:-$HOME/.config}"
old="$config/zsh/.zshwork"
new="$config/shell/secrets.sh"

[[ -e "$old" ]] || exit 0

if [[ -e "$new" ]]; then
  echo "Both $old and $new exist; only $new is loaded now. Merge them by hand." >&2
  exit 0
fi

mkdir -p "$(dirname "$new")"
mv "$old" "$new"
echo "Moved $old to $new"
