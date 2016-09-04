#!/bin/sh
mkdir -p ~/.config/nvim/rc
mkdir -p ~/.vim/rc
mkdir -p ~/.vim/undo

# Vim
ln -sf ~/setting-files/.vimrc ~/.vimrc
ln -sf ~/setting-files/dein.toml ~/.vim/rc/dein.toml
ln -sf ~/setting-files/dein_lazy.toml ~/.vim/rc/dein_lazy.toml

# NeoVim
ln -sf ~/setting-files/init.vim ~/.config/nvim/init.vim
ln -sf ~/setting-files/init.vim ~/.nvimrc
ln -sf ~/setting-files/dein.toml ~/.config/nvim/rc/dein.toml
ln -sf ~/setting-files/dein_lazy.toml ~/.config/nvim/rc/dein_lazy.toml
#echo 'export XDG_CONFIG_HOME=$HOME/.config' >> $HOME/.bashrc

# Conky
ln -sf ~/setting-files/.conkyrc ~/.conkyrc
