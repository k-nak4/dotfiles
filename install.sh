#!/bin/sh
mkdir -p ~/.vim/rc
mkdir -p ~/.vim/undo
mkdir -p ~/.vim/colors

# Vim
ln -sf ~/setting-files/.vimrc ~/.vimrc
ln -sf ~/setting-files/dein.toml ~/.vim/rc/dein.toml
ln -sf ~/setting-files/dein_lazy.toml ~/.vim/rc/dein_lazy.toml
if [ -e ~/.vim/colors/lucius.vim ]; then
    echo "lucius.vim is already instaled"
else
    wget https://github.com/jonathanfilip/vim-lucius/raw/master/colors/lucius.vim -P ~/.vim/colors
fi

# Zsh
ln -sf ~/setting-files/.zshrc ~/.zshrc
ln -sf ~/setting-files/.zprofile ~/.zprofile

# Vimparator (firefox's add-on)
# ln -sf ~/setting-files/.vimperatorrc ~/.vimperatorrc

# Conky
# ln -sf ~/setting-files/.conkyrc ~/.conkyrc

# capslock to control
# ln -sf ~/setting-files/.Xmodmap ~/.Xmodmap
# echo -e "\n# Caps_Lock -> Control\nxmodmap ~/.Xmodmap" >> ~/.profile
