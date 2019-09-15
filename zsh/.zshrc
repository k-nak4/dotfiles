# starship
# eval "$(starship init zsh)"

# --- oh-my-zsh ---

if [ -e $HOME/.oh-my-zsh ]; then
  export ZSH="/home/nakajima/.oh-my-zsh"
  ZSH_THEME="ys"
  plugins=(git)
  source $ZSH/oh-my-zsh.sh
fi

# --- general settings ---

bindkey -v

# --- typeset ---

typeset -U PATH path

# --- export ---

# PATH
export PATH="$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

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

# Driver
if [ -e $HOME/driver ]; then
  export PATH="$PATH:$HOME/driver"
fi

# --- command ---

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

# --- alias ---

alias spath="sed -e 's/:/\n/g'"

if type lsof > /dev/null 2>&1; then
  alias show_listen="lsof -i -P | grep 'LISTEN'"
fi
