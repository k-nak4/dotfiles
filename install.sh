#!/bin/sh

# Param
GIT=1
VIM=0
NVIM=0
ZSH=0
ZPLUG=0
TMUX=0
XMODMAP=0

# Vars
DOT_DIR="${HOME}/dotfiles"

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

    if [ -e ${HOME}/.vim/colors/lucius.vim ]; then
        echo "skip : lucius.vim is already installed."
    else
        wget https://github.com/jonathanfilip/vim-lucius/raw/master/colors/lucius.vim -P ${HOME}/.vim/colors
    fi
else
    echo "skip: vim"
fi

# neovim
if [ $NVIM = 1 ]; then
    mkdir -p ${HOME}/.config
    ln -sfv ${HOME}/.vim ${HOME}/.config/nvim
    ln -sfv ${DOT_DIR}/vim/.vimrc ${HOME}/.config/nvim/init.vim
else
    echo "skip: neovim"
fi

# zsh
if [ $ZSH = 1 ]; then
    mkdir -p ${HOME}/.zsh/plugins
    ln -sfv ${DOT_DIR}/zsh/.zshenv ${HOME}/.zshenv
    ln -sfv ${DOT_DIR}/zsh/.zshenv ${HOME}/.zsh/.zshenv
    ln -sfv ${DOT_DIR}/zsh/.zshrc ${HOME}/.zsh/.zshrc
    ln -sfv ${DOT_DIR}/zsh/.zsh_main ${HOME}/.zsh/.zsh_main
    ln -sfv ${DOT_DIR}/zsh/.zsh_alias ${HOME}/.zsh/.zsh_alias
    ln -sfv ${DOT_DIR}/zsh/.zsh_option ${HOME}/.zsh/.zsh_option
else
    echo "skip: zsh"
fi

# zplug
if [ $ZPLUG = 1 ]; then
    git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
    git clone https://github.com/yonchu/zsh-python-prompt.git ~/.zsh/plugins/zsh-python-prompt
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
else
    echo "skip: zplug"
fi

# tmux
if [ $TMUX = 1 ]; then
    ln -sfv ${DOT_DIR}/tmux/.tmux.conf ${HOME}/.tmux.conf
    ln -sfv ${DOT_DIR}/tmux/.tmux-powerlinerc ${HOME}/.tmux-powerlinerc
    git clone git://github.com/erikw/tmux-powerline.git ${HOME}/tmux-powerline
else
    echo "skip: tmux"
fi

# xmodmap
if [ $XMODMAP = 1 ]; then
    ln -sfv ${DOT_DIR}/.Xmodmap ~/.Xmodmap
else
    echo "skip: xmodmap"
fi
