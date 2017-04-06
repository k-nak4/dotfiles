#!/bin/sh

# Paramaters
GIT=1
VIM=1
ZSH=1
PREZTO=0
TMUX=1
VIMPERATOR=0
KEYMAP=0
CONKY=0

#
DIR_NAME="dotfiles"

# Git
if [ $GIT = 1 ]; then
    ln -sf ~/$DIR_NAME/.gitconfig ~/.gitconfig
else
    echo "skip: git"
fi

# Vim
if [ $VIM = 1 ]; then
    mkdir -p ~/.vim/rc
    mkdir -p ~/.vim/undo
    mkdir -p ~/.vim/colors
    ln -sf ~/$DIR_NAME/.vimrc ~/.vimrc
    ln -sf ~/$DIR_NAME/dein.toml ~/.vim/rc/dein.toml
    ln -sf ~/$DIR_NAME/dein_lazy.toml ~/.vim/rc/dein_lazy.toml
    if [ -e ~/.vim/colors/lucius.vim ]; then
        echo "skip : lucius.vim is already installed."
    else
        wget https://github.com/jonathanfilip/vim-lucius/raw/master/colors/lucius.vim -P ~/.vim/colors
    fi
else
    echo "skip: vim"
fi

# Zsh
if [ $ZSH = 1 ]; then
    ln -sf ~/$DIR_NAME/.zshrc ~/.zshrc
    ln -sf ~/$DIR_NAME/.zshenv ~/.zshenv
    ln -sf ~/$DIR_NAME/.zprofile ~/.zprofile
else
    echo "skip: zsh"
fi

# Prezto
if [ $PREZTO = 1 ]; then
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
    ln -sf ~/$DIR_NAME/.zpreztorc ~/.zpreztorc
else
    echo "skip: Prezto"
fi

# tmux
if [ $TMUX = 1 ]; then
    ln -sf ~/$DIR_NAME/.tmux.conf ~/.tmux.conf
    ln -sf ~/$DIR_NAME/.tmux-powerlinerc ~/.tmux-powerlinerc
    git clone git://github.com/erikw/tmux-powerline.git ~/tmux-powerline
else
    echo "skip: tmux"
fi

# Vimperator (firefox's add-on)
if [ $VIMPERATOR = 1 ]; then
    ln -sf ~/$DIR_NAME/.vimperatorrc ~/.vimperatorrc
    if [ -e ~/.vimperator/vimppm ]; then
        echo "skip : vimppm is already installed."
    else
        git clone git://github.com/cd01/vimppm ~/.vimperator/vimppm
    fi
else
    echo "skip: vimparator"
fi

# Keymap
if [ $KEYMAP = 1 ]; then
    ln -sf ~/$DIR_NAME/.Xmodmap ~/.Xmodmap
else
    echo "skip: keymap"
fi

# Conky
if [ $CONKY = 1 ]; then
    ln -sf ~/$DIR_NAME/.conkyrc ~/.conkyrc
else
    echo "skip: conky"
fi
