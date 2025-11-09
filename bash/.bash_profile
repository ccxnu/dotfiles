# --- General Settings --- #

# User
export PATH="$HOME/.local/bin:$PATH"
# Texlive
export PATH="/usr/local/texlive/2024/bin/x86_64-linux:$PATH"
# Adb
export PATH="$HOME/.local/share/platform-tools:$PATH"
# Node
export PATH="$HOME/.local/share/fnm:$PATH"
eval "$(fnm env)"
# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
# Golang
export GOPATH=$HOME/.go
export PATH="$GOPATH/bin:$PATH"

export EDITOR=nvim
export VISUAL=nvim
export READER=zathura
export BROWSER=Floorp
export TERMINAL=st

## Source .bashrc for interactive shells
[[ -f ~/.bashrc ]] && source ~/.bashrc

# Start X on tty1
if [[ -z $DISPLAY ]] && [[ $XDG_VTNR -eq 1 ]]; then
    exec startx >/dev/null 2>&1   # remove the exec to remain logged in when your wm ends
fi
