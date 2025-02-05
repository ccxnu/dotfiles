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

## Background
/usr/bin/feh --no-fehbg --bg-fill "$HOME/Pictures/wallpaper/internationalSpace.jpg"
## Programs
tmux has-session -t me || st -n me -e tmux new -s me &
xss-lock slock &
xbindkeys &
xbanish &
xcompmgr -nC &
dwmblocks &
exec dwm
