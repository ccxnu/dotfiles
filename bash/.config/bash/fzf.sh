# Options to fzf command
export FZF_DEFAULT_OPTS="--height 70% \
  --border \
  --gutter=' ' \
  --info=inline \
  --no-mouse \
  --layout=reverse \
  --color=border:#31748F \
  --color=hl+:#c94c16 \
  --color=hl:#c94c16 \
  --color=info:#5F8484 \
  --color=pointer:#8787AF \
  --color=prompt:#8787AF"

# Kill a process
fkill() { #{{{
    local pid
    if [ "$UID" != "0" ]; then
        pid=$(ps -f -u $UID | sed 1d | fzf -m --exact | awk '{print $2}')
    else
        pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
    fi

    if [ "x$pid" != "x" ]
    then
        echo $pid | xargs kill -${1:-9}
    fi
}
#}}}

# Find File and Edit
ffe() { #{{{
    local file=$(
        fd -t f -H --no-ignore-vcs | \
            fzf --query="$1" --exact --no-multi --select-1 --exit-0 \
                --preview 'mimetype=$(file --dereference --brief --mime-type {}); [[ $mimetype == text/* || $mimetype == application/json || $mimetype == *xml ]] && cat {} || file --dereference --brief {}'
    )
    if [[ -n "$file" ]]; then
        local mimetype=$(file --dereference --brief --mime-type "$file")
        case "$mimetype" in
            image/*)                          feh "$file" & disown ;;
            application/pdf)                  zathura "$file" & disown ;;
            text/* | application/* | */xml)   "$EDITOR" "$file" ;;
            video/*)                          mpv "$file" & disown ;;
            audio/*)                          ncmpcpp "$file" & disown ;;
            *) ;;
        esac
    fi
}
#}}}

# Find Directory and Change
fcd() { #{{{
    local dir=$(
    cd && \
        fd -t d -H --no-ignore-vcs | \
            fzf --query="$1" --exact --no-multi --select-1 --exit-0 \
                --preview 'tree -C {} | head -100'
    )

    if [[ -n "$dir" ]]; then
        cd && cd "$dir"
    fi
}

# fh - repeat history
fh() {
    READLINE_LINE=$(history | fzf +s --tac --exact | sed -E 's/ *[0-9]*\*? *//' | sed -E 's/\\/\\\\/g')
    READLINE_POINT=${#READLINE_LINE}
}
#}}}

# BindKeys
#bind -x '"\C-f": fcd' # There's a problem. It don't update the prompt to shows the current folder
bind -x '"\C-g": ffe'
bind -x '"\C-r": fh'
