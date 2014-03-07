# Zsh configuration http://www.gentoo.org/doc/en/zsh.xml
## History
  HISTFILE=~/.histfile
  HISTSIZE=1000
  SAVEHIST=1000

## Options
  setopt notify
  setopt hist_ignore_all_dups
  unsetopt beep

## Binds
  bindkey -e

## Autocompletion
  autoload -Uz compinit
  compinit

## Command prompt
  autoload -U promptinit
  promptinit
  export PS1="%n@%m %% "

## Styles
  zstyle :compinstall filename "$HOME/.zshrc"
  zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
  zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'

# Basic configuration
## Paths
  export PATH="/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:/usr/local/opt/curl/bin:$PATH"
  export NODE_PATH="/usr/local/lib/node_modules"

## RVM - This loads RVM into a shell session.
  [[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

## Aliases
  alias l="ls -l"
  alias la="ls -la"

### SSH
  alias ssh.reaper="ssh bsd.reaper.fi -p 28281"

### BlueReport project specific
  alias spec.blue="DEFER_GC_ENABLED= DB_SEED_ALREADY_DONE=1 bundle exec spec --drb -O spec/spec.opts"
  alias devploy="bundle exec cap devserver deploy"

##
  alias glog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)%Creset' --abbrev-commit"

# Enable UTF-8 support on iTerm2
  export LC_ALL="en_US.UTF-8"

# Git flow completion
  source ~/.git-flow-completion.zsh

# Functions
s()
{
 BUNDLE_GEMFILE="/Users/mseppae/Development/Cognita/cloud/Gemfile" bundle exec rake -f /Users/mseppae/Development/Cognita/cloud/Rakefile ssh\[$1\]
}

setopt prompt_subst
autoload -Uz vcs_info
vcs_info_wrapper() {
  vcs_info
  if [ -n "$vcs_info_msg_0_" ]; then
    echo "%{$fg[grey]%}${vcs_info_msg_0_}%{$reset_color%}$del"
  fi
}
RPROMPT=$'$(vcs_info_wrapper)'


PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

alias tmux="TERM=screen-256color-bce tmux"

alias vb-restart="sudo /Library/StartupItems/VirtualBox/VirtualBox restart"
