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
## Autocorrection
#	setopt correctall
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
	export PATH="/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:/opt/local/lib/postgresql84/bin:$PATH"
	export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
## RVM - This loads RVM into a shell session.
	[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
## Aliases
	alias l="ls -l"
	alias la="ls -la"

### SSH
	alias ssh.reaper="ssh bsd.reaper.fi -p 28281"
	alias ssh.dev="cd $HOME/Development/Cognita/cloud/ && rake ssh\[dev\]"

### Apache2
	alias apache2.start="sudo /opt/local/apache2/bin/apachectl start"
	alias apache2.stop="sudo /opt/local/apache2/bin/apachectl stop"
	alias apache2.restart="sudo /opt/local/apache2/bin/apachectl restart"

### Redis
	alias redis.start="sudo redis-server /opt/local/etc/redis.conf"

### BlueReport project specific
#### Spec
        alias spec.run="bundle exec spec -O spec/spec.opts"
#### Logs
	alias bluereport.logs="/var/log/bluereport/"

# Enable UTF-8 support on iTerm2
export LC_ALL="en_US.UTF-8"

# Git flow completion
source ~/.git-flow-completion.zsh

# RVM
rvm use 1.8.7
