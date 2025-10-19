# --- General Settings --- #
if [ "$EUID" -eq 0 ]; then
    return # root default
fi

# Texlive
export PATH="/usr/local/texlive/2024/bin/x86_64-linux:$PATH"
# Node
export PATH="$HOME/.local/share/fnm:$PATH"
eval "$(fnm env)"
# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
# Golang
export GOPATH=$HOME/.go

export EDITOR=nvim
export READER=zathura
export BROWSER=Floorp
export TERMINAL=st

## Source .bashrc for interactive shells
if [[ $- == *i* ]]; then
  [[ -f ~/.bashrc ]] && source ~/.bashrc
fi

if [[ ! $DISPLAY ]] && [[ $XDG_VTNR -eq 1 ]]; then
  exec startx >/dev/null 2>&1   # remove the exec to remain logged in when your wm ends
fi
