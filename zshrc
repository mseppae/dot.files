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
	export PATH="/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:$PATH"
        export NODE_PATH="/usr/local/lib/node_modules"

## RVM - This loads RVM into a shell session.
	[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
## Aliases
	alias l="ls -l"
	alias la="ls -la"
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
        alias cd.bluereport="cd ~/Development/Cognita/bluereport && rvm use 1.8.7@bluereport"
        alias spec.blue="bundle exec spec --drb -O spec/spec.opts"
        alias sc="script/console"

### Comet project specific
        alias cd.comet="cd ~/Development/Cognita/comet && rvm use 1.9.2@comet"
        alias spec.comet="bundle exec rspec --drb"
        alias rco="rails console"
        alias rdbco="rails dbconsole -p"

# Enable UTF-8 support on iTerm2
export LC_ALL="en_US.UTF-8"

# Git flow completion
source ~/.git-flow-completion.zsh

# Vi shell & start in Vi command mode
# bindkey -v
# zle-line-init() { zle -K vicmd; }
# zle -N zle-line-init

# Functions
rake-ssh()
{
 BUNDLE_GEMFILE="/Users/mseppae/Development/Cognita/cloud/Gemfile" rake -f /Users/mseppae/Development/Cognita/cloud/Rakefile ssh\[$1\]
}
