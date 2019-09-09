# starship
# eval "$(starship init zsh)"

# oh-my-zsh
export ZSH="/home/nakajima/.oh-my-zsh"
ZSH_THEME="ys"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# typeset
typeset -U PATH path

# vi keybind
bindkey -v

# PATH
export PATH="$PATH:/bin:/usr/bin:/usr/local/bin:/usr/sbin:/sbin"

# $HOME/bin
export PATH="$PATH:$HOME/bin"

# Composer
if [ -e $HOME/.config/composer/vendor/bin ]; then
  export PATH="$PATH:$HOME/.config/composer/vendor/bin"
fi

# Golang
if [ -e $HOME/go ]; then
  export GOPATH=$HOME/go
  export PATH="$PATH:$GOPATH/bin"
  export PATH="$PATH:/usr/local/go/bin"
fi

# peco + ghq
function peco-src () {
    local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-src
bindkey '^]' peco-src

# alias
alias sp="sed -e 's/:/\n/g' | sort"
