# Zsh configuration http://www.gentoo.org/doc/en/zsh.xml
## History
  HISTFILE=~/.histfile
  HISTSIZE=1000
  SAVEHIST=1000

## Options
  setopt notify
  unsetopt beep
  # Show no duplicates on history searc
  setopt HIST_FIND_NO_DUPS

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

##
  alias glog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)%Creset' --abbrev-commit"

# Enable UTF-8 support on iTerm2
  export LC_ALL="en_US.UTF-8"

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

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

alias tmux="TERM=screen-256color-bce tmux"

alias vb-restart="sudo /Library/StartupItems/VirtualBox/VirtualBox restart"

# Rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# Android SDK
export PATH="$HOME/Development/android-sdk-macosx/platform-tools:$HOME/Development/android-sdk-macosx/tools:$PATH"

# iOS development
alias clear-cordova="rm -rf $HOME/Development/Cognita/reader-cordova/www; rm -rf $HOME/Development/Cognita/reader-cordova/platforms; rm -rf $HOME/Development/Cognita/reader-cordova/plugins"

# Lua game dev
alias love="/Applications/love.app/Contents/MacOS/love"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# https://github.com/wting/autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

export FZF_DEFAULT_COMMAND='rg --files --no-ignore-vcs --hidden'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
