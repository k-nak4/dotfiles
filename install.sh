#!/bin/sh

VIM=1
ZSH=1
TMUX=1
VIMPARATOR=0
KEYMAP=0
CONKY=0

# Vim
if [ $VIM = 1 ]; then
    mkdir -p ~/.vim/rc
    mkdir -p ~/.vim/undo
    mkdir -p ~/.vim/colors
    ln -sf ~/setting-files/.vimrc ~/.vimrc
    ln -sf ~/setting-files/dein.toml ~/.vim/rc/dein.toml
    ln -sf ~/setting-files/dein_lazy.toml ~/.vim/rc/dein_lazy.toml
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
    ln -sf ~/setting-files/.zshrc ~/.zshrc
    ln -sf ~/setting-files/.zshenv ~/.zshenv
    ln -sf ~/setting-files/.zprofile ~/.zprofile
else
    echo "skip: zsh"
fi

# tmux
if [ $TMUX = 1 ]; then
    ln -sf ~/setting-files/.tmux.conf ~/.tmux.conf
else
    echo "skip: tmux"
fi

# Vimparator (firefox's add-on)
if [ $VIMPARATOR = 1 ]; then
    ln -sf ~/setting-files/.vimperatorrc ~/.vimperatorrc
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
    ln -sf ~/setting-files/.Xmodmap ~/.Xmodmap
else
    echo "skip: keymap"
fi

# Conky
if [ $CONKY = 1 ]; then
    ln -sf ~/setting-files/.conkyrc ~/.conkyrc
else
    echo "skip: conky"
fi
