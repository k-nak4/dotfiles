#!/bin/sh
mkdir -p ~/.vim/rc
mkdir -p ~/.vim/undo

# Vim
ln -sf ~/setting-files/.vimrc ~/.vimrc
ln -sf ~/setting-files/dein.toml ~/.vim/rc/dein.toml
ln -sf ~/setting-files/dein_lazy.toml ~/.vim/rc/dein_lazy.toml

# Vimparator (firefox's add-on)
ln -sf ~/setting-files/.vimperatorrc ~/.vimperatorrc

# Zsh (oh-my-zsh)
ln -sf ~/setting-files/.zshrc ~/.zshrc

# Conky
ln -sf ~/setting-files/.conkyrc ~/.conkyrc
