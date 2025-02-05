# --- General Settings --- #

## Paths
export PATH="$HOME/.local/bin:$HOME/.local/bin/statusbar:$PATH"
export PATH="/usr/local/texlive/2024/bin/x86_64-linux:$PATH"
# Flutter & Android
export PATH="$HOME/.local/share/flutter/bin:$PATH"
export ANDROID_HOME="$HOME/.local/share/android-sdk"
export PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"
export PATH="$ANDROID_HOME/platform-tools:$PATH"
# Dotnet
export DOTNET_ROOT="/opt/Dotnet"
export PATH="$HOME/.dotnet/tools:$PATH"
# Node
export PATH="$HOME/.local/share/fnm:$PATH"

export EDITOR=nvim
export READER=zathura

## fnm
eval "$(fnm env)"

## Source .bashrc for interactive shells
if [[ $- == *i* ]]; then
  [[ -f ~/.bashrc ]] && source ~/.bashrc
fi

if [[ ! $DISPLAY ]] && [[ $XDG_VTNR -eq 1 ]]; then
  exec startx >/dev/null 2>&1   # remove the exec to remain logged in when your wm ends
fi
