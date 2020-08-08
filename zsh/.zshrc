source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
# -------- zinit --------

# Prompt
zinit light romkatv/powerlevel10k

# shell
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# -------------------------------------------------------------------- #

# PATH
PATH="$PATH:$HOME/.local/bin"
PATH="$PATH:$HOME/go/1.14.3/bin"

# Alias
alias ll="ls -l"
alias lv='ls -lv'

# Key bind
bindkey '^]' peco-src

# Function
function peco-src() {
  local src=$(ghq list --full-path | peco --query "$LDBUFFER")
  if [ -n "$src" ]; then
    BUFFER="cd $src"
    zle accept-line
  fi
  zle -R -c
}
zle -N peco-src
