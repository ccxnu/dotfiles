# Options to fzf command
export FZF_DEFAULT_OPTS="--height 70% \
  --border \
  --info=inline \
  --layout=reverse \
  --prompt '∷ ' \
  --pointer ▶   \
  --marker ⇒ \
  --color=gutter:-1"

# Find File and Edit
ffe() {
    local file=$(
        fd -t f -H --no-ignore-vcs | \
            fzf --query="$1" --exact --no-multi --select-1 --exit-0 \
                --preview 'cat {}'
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

# Find Directory and Change
fcd() {
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

# BindKeys
#bind -x '"\C-f": fcd' # There's a problem it don't update the prompt, shows the last folder
bind -x '"\C-g": ffe'
bind -x '"\C-r": fh'
