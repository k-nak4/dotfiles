#!/bin/sh

# fishermanをインストール
curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisherman

# promptをscorphishに変更
fisher omf/theme-scorphish | fish
