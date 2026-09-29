# Shared zsh/bash config, sourced from dot_config/zsh/dot_zshrc and dot_bashrc.
# Keep this POSIX-compatible; anything zsh- or bash-specific belongs in its
# own rc.

export EDITOR="nvim"
export VISUAL="nvim"
export SUDO_EDITOR="$EDITOR"

export FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

if command -v fd >/dev/null 2>&1; then
  export FZF_ALT_C_COMMAND="fd --type d --hidden --exclude .git"
fi

# LS_COLORS themes with vivid (installed by mise)
# https://github.com/sharkdp/vivid
if command -v vivid >/dev/null 2>&1; then
  export LS_COLORS="$(vivid generate nord)"
fi

# Neovim from bob (installed by mise). bob keeps its nvim proxy in its data
# directory, which on macOS is ~/Library/Application Support/bob regardless of
# XDG variables, and ~/.local/share/bob on Linux.
case "$(uname -s)" in
  Darwin) bob_nvim_bin="${HOME}/Library/Application Support/bob/nvim-bin" ;;
  *) bob_nvim_bin="${XDG_DATA_HOME:-${HOME}/.local/share}/bob/nvim-bin" ;;
esac
if [ -d "$bob_nvim_bin" ]; then
  case ":${PATH}:" in
    *":${bob_nvim_bin}:"*) ;;
    *) export PATH="${bob_nvim_bin}:${PATH}" ;;
  esac
fi
unset bob_nvim_bin

# Same ls as Omarchy's defaults on every machine: eza, installed by the OS
# package manager (it publishes no macOS binaries for mise to verify).
# Note: eza's -t takes a field, so `ls -ltr` becomes `ls -l -s modified -r`.
# Functions rather than aliases, so eza is only used at a terminal. Pipes,
# scripts and agents get plain ls: without a terminal on stdin eza reads file
# names from it (printing nothing), and eza's flags break e.g. `ls -lt`.
# Drop Omarchy's aliases first, as a separate command: shells expand aliases
# while reading, so the `if` below must not be read while `ls` is an alias.
for name in ls lsa lt lta; do
  unalias "$name" 2>/dev/null
done
unset name
if command -v eza >/dev/null 2>&1; then
  ls() {
    if [ -t 0 ] && [ -t 1 ]; then
      eza -lh --group-directories-first --icons=auto "$@"
    else
      command ls "$@"
    fi
  }
  lsa() { ls -a "$@"; }
  lt() {
    if [ -t 0 ] && [ -t 1 ]; then
      eza --tree --level=2 --long --icons --git "$@"
    else
      command ls -R "$@"
    fi
  }
  lta() { lt -a "$@"; }
else
  alias ls='ls --color=auto'
fi
alias vim="nvim"
alias vi="nvim"

if command -v fastfetch >/dev/null 2>&1; then
  fastfetch
fi
