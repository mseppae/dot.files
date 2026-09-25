#!/bin/bash
set -euo pipefail

# zsh used to point XDG_DATA_HOME/XDG_CACHE_HOME into ~/.config (local/share,
# cache) and now uses the defaults, ~/.local/share and ~/.cache. History moved
# from zhistory (Linux; macOS /etc/zshrc forced .zsh_history) to .zsh_history.

zdotdir="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
old_data="$HOME/.config/local/share"
new_data="$HOME/.local/share"

if [[ -f "$zdotdir/zhistory" ]]; then
  echo "Merging $zdotdir/zhistory into .zsh_history"
  if [[ -f "$zdotdir/.zsh_history" ]]; then
    cat "$zdotdir/zhistory" >>"$zdotdir/.zsh_history"
    rm "$zdotdir/zhistory"
  else
    mv "$zdotdir/zhistory" "$zdotdir/.zsh_history"
  fi
fi

[[ -d "$old_data" ]] || exit 0

# Small user data moves as is (recent directories for zsh-autocomplete).
if [[ -f "$old_data/zsh/chpwd-recent-dirs" && ! -e "$new_data/zsh/chpwd-recent-dirs" ]]; then
  mkdir -p "$new_data/zsh"
  mv "$old_data/zsh/chpwd-recent-dirs" "$new_data/zsh/"
fi

# mise installs embed absolute paths (shebangs, symlinks), so reinstall them
# at the new location instead of moving them. Ignore this apply's inherited
# environment, which may still carry the old XDG paths. Also drop mise shims
# from PATH: a build step (luarocks runs `lua`) would otherwise hit a shim that
# waits on this very install's lock and deadlocks.
if command -v mise >/dev/null 2>&1; then
  echo "Installing mise tools into $new_data/mise..."
  path_without_shims="$(printf '%s' "$PATH" | tr ':' '\n' | grep -v '/mise/shims$' | paste -sd: -)"
  env -u XDG_DATA_HOME -u XDG_CACHE_HOME -u MISE_DATA_DIR PATH="$path_without_shims" mise install
fi

echo "Old data remains in ~/.config/local/share and ~/.config/cache."
echo "Neovim reinstalls plugins and Mason tools on its next start; delete the"
echo "old directories once new shells and Neovim work."
