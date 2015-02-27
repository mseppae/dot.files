#!/bin/sh

# TODO: Check if stuff is already done!
(cd ~/.vim && git submodule init && git submodule update)
(cd ~/.vim/bundle/YouCompleteMe && ./install.sh --clang-completer)
# TODO: Check on what system you are runnign in and above of course
(brew install node && npm install -g jshint)
ln -nfs ~/.vim/zshrc ~/.zshrc
ln -nfs ~/.vim/vimrc ~/.vimrc
ln -nfs ~/.vim/gvimrc ~/.gvimrc
ln -nfs ~/.vim/tmux.conf ~/.tmux.conf
ln -nfs ~/.vim/git/git-flow-completion/git-flow-completion.zsh ~/.git-flow-completion.zsh
