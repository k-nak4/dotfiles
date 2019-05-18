#!/bin/sh

# 1 = Install
# 0 = Don't install
GIT=1
VIM=1
SCREEN=1
ZSH=1

# path
DOT_DIR="${HOME}/dotfiles"

# ---------------------------------------------------------------------------

# git
if [ $GIT = 1 ]; then
    ln -sfv ${DOT_DIR}/.gitconfig ${HOME}/.gitconfig
else
    echo "skip: git"
fi

# vim
if [ $VIM = 1 ]; then
    mkdir -p ${HOME}/.vim/rc
    mkdir -p ${HOME}/.vim/undo
    mkdir -p ${HOME}/.vim/colors
    ln -sfv ${DOT_DIR}/vim/.vimrc ${HOME}/.vimrc
    ln -sfv ${DOT_DIR}/vim/dein.toml ${HOME}/.vim/rc/dein.toml
    ln -sfv ${DOT_DIR}/vim/dein_lazy.toml ${HOME}/.vim/rc/dein_lazy.toml
    wget https://github.com/reedes/vim-colors-pencil/raw/master/colors/pencil.vim -P ${HOME}/.vim/colors
else
    echo "skip: vim"
fi

# zsh
if [ $ZSH = 1 ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
else
    echo "skip: zsh"
fi

# screen
if [ $SCREEN = 1 ]; then
    ln -sfv ${DOT_DIR}/.screenrc ${HOME}/.screenrc
else
    echo "skip: screen"
fi
