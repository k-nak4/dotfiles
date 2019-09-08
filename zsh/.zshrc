export ZSH="/home/nakajima/.oh-my-zsh"
export PATH="$PATH:$HOME/.config/composer/vendor/bin"

# Golang
export GOPATH=$HOME/go
export PATH="$PATH:$GOPATH/bin"
export PATH="$PATH:/usr/local/go/bin"

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

# vi keybind
bindkey -v

# rbenv
export PATH="$PATH:$HOME/.rbenv/bin"

ZSH_THEME="ys"
plugins=(git)
source $ZSH/oh-my-zsh.sh
