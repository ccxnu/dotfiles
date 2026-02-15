#!/bin/sh

userresources=$HOME/.config/x/.Xresources

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

## Background
/usr/bin/feh --no-fehbg --bg-center "$HOME/Pictures/wallpaper/spaceCraftCenter.webp"

## Daemons & Programs
pgrep -f sy-clipboard >/dev/null || sy-clipboard &
xss-lock slock &
xbanish &
# xcompmgr -nC &
dwmblocks &
exec dwm
