#
# Executes commands at login pre-zshrc.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# ------------------------------------------------------------------------
# Paths
# ------------------------------------------------------------------------

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

# Set the list of directories that Zsh searches for programs.
path=(
  /usr/local/{bin,sbin}
  $path
)

# ------------------------------------------------------------------------
# Golang
# ------------------------------------------------------------------------
export GOPATH=$HOME/dev
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:/usr/local/go/bin

# ------------------------------------------------------------------------
# Python3
# ------------------------------------------------------------------------
#PYENV_ROOT=~/.pyenv
#export PATH=$PATH:$PYENV_ROOT/bin
#eval "$(pyenv init -)"
#eval "$(pyenv virtualenv-init -)"

# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS='-F -g -i -M -R -S -w -X -z-4'

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

# ------------------------------------------------------------------------
# Temporary Files
# ------------------------------------------------------------------------

if [[ ! -d "$TMPDIR" ]]; then
  export TMPDIR="/tmp/$LOGNAME"
  mkdir -p -m 700 "$TMPDIR"
fi

TMPPREFIX="${TMPDIR%/}/zsh"
