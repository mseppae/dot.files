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

if [ -f "${HOME}/.local/share/bob/env/env.sh" ]; then
  . "${HOME}/.local/share/bob/env/env.sh"
fi

alias ls="ls --color=always"
alias vim="nvim"
alias vi="nvim"

if command -v fastfetch >/dev/null 2>&1; then
  fastfetch
fi
