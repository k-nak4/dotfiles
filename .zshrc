# 少し凝った zshrc
# License : MIT
# http://mollifier.mit-license.org/
########################################

umask 022
limit coredumpsize 0
bindkey -d

# 色を使用出来るようにする
autoload -Uz colors
colors

# 補完機能を有効にする
autoload -Uz compinit
compinit

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Prompt
PROMPT='[%{${fg[yellow]}%}%D %T%{${reset_color}%}]%{${fg[cyan]}%}%~%{${reset_color}%}$ '
RPROMPT=''

########################################
# オプション
# 日本語ファイル名を表示可能にする
setopt print_eight_bit

# beep を無効にする
setopt no_beep

# '#' 以降をコメントとして扱う
setopt interactive_comments

# cd したら自動的にpushdする
setopt auto_pushd

# 重複したディレクトリを追加しない
setopt pushd_ignore_dups

# 同時に起動したzshの間でヒストリを共有する
setopt share_history

# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups

# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space

# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks

# 高機能なワイルドカード展開を使用する
setopt extended_glob

# エイリアス
alias l='ls'
alias ll='ls -lUF'
alias la='ls -alU'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'


# sudo の後のコマンドでエイリアスを有効にする
alias sudo='sudo '

########################################
# User command                         #
########################################

# Peco
bindkey '^]' peco-src

function peco-src() {
    local src=$(ghq list --full-path | peco --query "$LBUFFER")
    if [ -n "$src" ]; then
        BUFFER="cd $src"
        zle accept-line
    fi
    zle -R -c
}
zle -N peco-src

# Keyboard 無効化 (MacOS Sierra)
alias macos_keyboard_disable='sudo kextunload /System/Library/Extensions/AppleUSBTopCase.kext/Contents/PlugIns/AppleUSBTCKeyboard.kext/'
alias macos_keyboard_enable='sudo kextload /System/Library/Extensions/AppleUSBTopCase.kext/Contents/PlugIns/AppleUSBTCKeyboard.kext/'
