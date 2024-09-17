#!/bin/sh

userresources=$HOME/.config/x/.Xresources
usermodmap=$HOME/.config/x/.Xmodmap

# merge in defaults and keymaps
if [ -f "$userresources" ]; then
	xrdb -merge "$userresources"
fi
if [ -f "$usermodmap" ]; then
	xmodmap "$usermodmap"
fi

# --- General Settings --- #
## variables
PATH=$HOME/.local/bin:$HOME/.local/bin/statusbar:$PATH
PATH=/usr/local/texlive/2024/bin/x86_64-linux:$PATH
export PATH
export EDITOR=nvim
export READER=zathura

# fnm
export PATH="$HOME/.local/share/fnm:$PATH"
eval "$(fnm env)"

## Background
/usr/bin/feh --no-fehbg --bg-fill "$HOME/Pictures/wallpaper/gato.png"
## Programs
tmux has-session -t me || st -n me -e tmux new -s me &
xss-lock slock &
xbindkeys &
xbanish &
xcompmgr -nC &
dwmblocks &
exec dwm
