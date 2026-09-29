#!/bin/bash
set -euo pipefail

# Keep directories holding credentials, agent sessions, and editor state
# private (0700). macOS homes are world-readable (755) by default, so without
# this other local users could read them. Runs on every apply to also cover
# directories created later (e.g. when an agent is first installed). Only the
# directory itself changes: without access to it, nothing inside is reachable.

private_dirs=(
  "$HOME/.claude"      # Claude Code sessions, history, shell snapshots
  "$HOME/.codex"       # Codex auth token and sessions
  "$HOME/.pi"          # Pi agent sessions
  "$HOME/.docker"      # container registry credentials
  "$HOME/.local/state" # Neovim undo history and trusted-projects list
  "$HOME/.ssh"
  "$HOME/.gnupg"
)

for dir in "${private_dirs[@]}"; do
  [[ -d "$dir" && ! -L "$dir" ]] || continue
  if [[ -n "$(find "$dir" -maxdepth 0 \( -perm -001 -o -perm -002 -o -perm -004 -o -perm -010 -o -perm -020 -o -perm -040 \))" ]]; then
    chmod go-rwx "$dir"
    echo "Made private: $dir"
  fi
done
