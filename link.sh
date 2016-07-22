#!/bin/sh
#mkdir -p ~/.config/nvim/rc
#echo 'export XDG_CONFIG_HOME=$HOME/.config' >> $HOME/.bashrc

ln -sf ~/setting-files/init.vim ~/.config/nvim/init.vim
ln -sf ~/setting-files/dein.toml ~/.config/nvim/rc/dein.toml
ln -sf ~/setting-files/dein_lazy.toml ~/.config/nvim/rc/dein_lazy.toml
