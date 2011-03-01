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
	export PATH="/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:$PATH" # /opt/local/lib/postgresql84/bin:$PATH"
        export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
## RVM - This loads RVM into a shell session.
	[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
## Aliases
	alias l="ls -l"
	alias la="ls -la"
        alias sc="script/console"
### SSH
	alias ssh.reaper="ssh bsd.reaper.fi -p 28281"
	alias ssh.dev="cd $HOME/Development/Cognita/cloud/ && rake ssh\[dev\]"
### Apache2
	alias apache.start="sudo apachectl start"
	alias apache.stop="sudo apachectl stop"
	alias apache.restart="sudo apachectl restart"
### Postgresql
        alias psql.start="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start"
        alias psql.stop="pg_ctl -D /usr/local/var/postgres stop -s -m fast"
### Redis
	alias redis.start="sudo redis-server /usr/local/etc/redis.conf"
### BlueReport project specific
#### Spec
        alias spec.run="bundle exec spec -O spec/spec.opts"
#### Logs
	alias bluereport.logs="/var/log/bluereport/"

# Enable UTF-8 support on iTerm2
export LC_ALL="en_US.UTF-8"

# Git flow completion
source ~/.git-flow-completion.zsh
