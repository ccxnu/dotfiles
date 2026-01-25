#!/bin/sh

## Background
/usr/bin/feh --no-fehbg --bg-center "$HOME/Pictures/wallpaper/spaceCraftCenter.webp"

## Daemons & Programs
pgrep -f sy-clipboard >/dev/null || sy-clipboard &
xss-lock slock &
xbanish &
# xcompmgr -nC &
dwmblocks &
exec dwm
