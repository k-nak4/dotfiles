#!/bin/sh

# Param
GIT=0
VIM=0
ZSH=1
TMUX=0
KEYMAP=0

# Vars
DIR_NAME="dotfiles"

# git
if [ $GIT = 1 ]; then
    ln -sf ~/$DIR_NAME/.gitconfig ~/.gitconfig
else
    echo "skip: git"
fi

# vim
if [ $VIM = 1 ]; then
    mkdir -p ~/.vim/rc
    mkdir -p ~/.vim/undo
    mkdir -p ~/.vim/colors
    ln -sf ~/$DIR_NAME/vim/.vimrc ~/.vimrc
    ln -sf ~/$DIR_NAME/vim/dein.toml ~/.vim/rc/dein.toml
    ln -sf ~/$DIR_NAME/vim/dein_lazy.toml ~/.vim/rc/dein_lazy.toml
    if [ -e ~/.vim/colors/lucius.vim ]; then
        echo "skip : lucius.vim is already installed."
    else
        wget https://github.com/jonathanfilip/vim-lucius/raw/master/colors/lucius.vim -P ~/.vim/colors
    fi
else
    echo "skip: vim"
fi

# zsh
if [ $ZSH = 1 ]; then
    mkdir -p ${HOME}/.zsh
    ln -sf ~/$DIR_NAME/zsh/.zshenv ~/.zshenv
    ln -sf ~/$DIR_NAME/zsh/.zshenv ~/.zsh/.zshenv
    ln -sf ~/$DIR_NAME/zsh/.zshrc ~/.zsh/.zshrc
    ln -sf ~/$DIR_NAME/zsh/.zsh_main ~/.zsh/.zsh_main
    ln -sf ~/$DIR_NAME/zsh/.zsh_option ~/.zsh/.zsh_option
    ln -sf ~/$DIR_NAME/zsh/.zsh_alias ~/.zsh/.zsh_alias
else
    echo "skip: zsh"
fi

# tmux
if [ $TMUX = 1 ]; then
    ln -sf ~/$DIR_NAME/tmux/.tmux.conf ~/.tmux.conf
    ln -sf ~/$DIR_NAME/tmux/.tmux-powerlinerc ~/.tmux-powerlinerc
    git clone git://github.com/erikw/tmux-powerline.git ~/tmux-powerline
else
    echo "skip: tmux"
fi

# keymap
if [ $KEYMAP = 1 ]; then
    ln -sf ~/$DIR_NAME/.Xmodmap ~/.Xmodmap
else
    echo "skip: keymap"
fi
