#!/bin/bash
set -euo pipefail

# Language runtimes moved from ~/.config/mise/config.toml to conf.d/languages.toml.
# chezmoi no longer manages config.toml but leaves the old copy behind, and its
# entries override conf.d. Remove only the lines chezmoi used to write, unchanged,
# so pins added later by `mise use -g` or Omarchy are kept.

config="${XDG_CONFIG_HOME:-$HOME/.config}/mise/config.toml"
[[ -f "$config" ]] || exit 0

legacy_lines='node = "lts"
python = "latest"
ruby = "latest"
go = "latest"
lua = "5.4.8"
rust = "latest"
odin = "latest"
"npm:yarn" = "1.22.22"'

filtered="$(grep -vxF -e "$legacy_lines" "$config" || true)"
if [[ "$filtered" != "$(cat "$config")" ]]; then
  echo "Removing legacy chezmoi-managed tools from $config"
  printf '%s\n' "$filtered" >"$config"
fi
