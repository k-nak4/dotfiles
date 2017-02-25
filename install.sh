#!/bin/sh

VIM=0
ZSH=0
PREZTO=0
TMUX=0
VIMPERATOR=0
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

# Prezto
if [ $PREZTO = 1 ]; then
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
    ln -sf ~/setting-files/.zpreztorc ~/.zpreztorc
else
    echo "skip: Prezto"
fi

# tmux
if [ $TMUX = 1 ]; then
    ln -sf ~/setting-files/.tmux.conf ~/.tmux.conf
    ln -sf ~/setting-files/.tmux-powerlinerc ~/.tmux-powerlinerc
    git clone git://github.com/erikw/tmux-powerline.git ~/tmux-powerline.git
else
    echo "skip: tmux"
fi

# Vimperator (firefox's add-on)
if [ $VIMPERATOR = 1 ]; then
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
