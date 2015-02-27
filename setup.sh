#!/bin/sh

(cd ~/.vim && git submodule init && git submodule update)
ln -nfs ~/.vim/zshrc ~/.zshrc
ln -nfs ~/.vim/vimrc ~/.vimrc
ln -nfs ~/.vim/gvimrc ~/.gvimrc
ln -nfs ~/.vim/tmux.conf ~/.tmux.conf
ln -nfs ~/.vim/git/git-flow-completion/git-flow-completion.zsh ~/.git-flow-completion.zsh
