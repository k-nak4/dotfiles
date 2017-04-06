#!/bin/sh

GIT=1
VIM=1
ZSH=1
PREZTO=0
TMUX=1
VIMPERATOR=0
KEYMAP=0
CONKY=0

# Git
if [ $GIT = 1 ]; then
    ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
else
    echo "skip: git"
fi

# Vim
if [ $VIM = 1 ]; then
    mkdir -p ~/.vim/rc
    mkdir -p ~/.vim/undo
    mkdir -p ~/.vim/colors
    ln -sf ~/dotfiles/.vimrc ~/.vimrc
    ln -sf ~/dotfiles/dein.toml ~/.vim/rc/dein.toml
    ln -sf ~/dotfiles/dein_lazy.toml ~/.vim/rc/dein_lazy.toml
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
    ln -sf ~/dotfiles/.zshrc ~/.zshrc
    ln -sf ~/dotfiles/.zshenv ~/.zshenv
    ln -sf ~/dotfiles/.zprofile ~/.zprofile
else
    echo "skip: zsh"
fi

# Prezto
if [ $PREZTO = 1 ]; then
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
    ln -sf ~/dotfiles/.zpreztorc ~/.zpreztorc
else
    echo "skip: Prezto"
fi

# tmux
if [ $TMUX = 1 ]; then
    ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
    ln -sf ~/dotfiles/.tmux-powerlinerc ~/.tmux-powerlinerc
    git clone git://github.com/erikw/tmux-powerline.git ~/tmux-powerline
else
    echo "skip: tmux"
fi

# Vimperator (firefox's add-on)
if [ $VIMPERATOR = 1 ]; then
    ln -sf ~/dotfiles/.vimperatorrc ~/.vimperatorrc
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
    ln -sf ~/dotfiles/.Xmodmap ~/.Xmodmap
else
    echo "skip: keymap"
fi

# Conky
if [ $CONKY = 1 ]; then
    ln -sf ~/dotfiles/.conkyrc ~/.conkyrc
else
    echo "skip: conky"
fi
