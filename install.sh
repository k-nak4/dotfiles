#!/bin/sh

# 1 = Install
# 0 = Don't install
GIT=0
VIM=0
ZSH=0
TMUX=0
DOCS=0
SCREEN=0

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
    mkdir -p ${HOME}/.zsh
    ln -sfv ${DOT_DIR}/zsh/.zshenv ${HOME}/.zshenv
    ln -sfv ${DOT_DIR}/zsh/.zshenv ${HOME}/.zsh/.zshenv
    ln -sfv ${DOT_DIR}/zsh/.zshrc ${HOME}/.zsh/.zshrc
    ln -sfv ${DOT_DIR}/zsh/.zsh_main ${HOME}/.zsh/.zsh_main
    ln -sfv ${DOT_DIR}/zsh/.zsh_alias ${HOME}/.zsh/.zsh_alias
    ln -sfv ${DOT_DIR}/zsh/.zsh_option ${HOME}/.zsh/.zsh_option
else
    echo "skip: zsh"
fi

# tmux
if [ $TMUX = 1 ]; then
    ln -sfv ${DOT_DIR}/tmux/.tmux.conf ${HOME}/.tmux.conf
else
    echo "skip: tmux"
fi

# documents
if [ $DOCS = 1 ]; then
    ln -sfv ${DOT_DIR}/docs ${HOME}/docs
else
    echo "skip: doc"
fi

# screen
if [ $SCREEN = 1 ]; then
    ln -sfv ${DOT_DIR}/.screenrc ${HOME}/.screenrc
else
    echo "skip: screen"
fi
