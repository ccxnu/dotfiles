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
function Find_Edit() {
    local file=$(
        fd -t f -H --no-ignore-vcs | \
            fzf --query="$1" --no-multi --select-1 --exit-0 \
                --preview 'bat --color=always --style=numbers,changes --line-range :500 {}'
    )
    mimetype=$(file  --dereference --brief --mime-type  "$file" )
    case "$mimetype" in
        image/*)                          feh "$file" & disown ;;
        application/pdf)                  zathura "$file" & disown ;;
        text/* | application/* | */xml)   $EDITOR "$file" ;;
        video/*)                          mpv "$file" & disown ;;
        audio/*)                          ncmpcpp "$file" & disown ;;
        *) ;;
    esac
    zle reset-prompt
}

# Find Directory and Change
function Change_Directory() {
    local dir=$(
    cd && \
        fd -t d -H --no-ignore-vcs | \
            fzf --query="$1" --no-multi --select-1 --exit-0 \
                --preview 'tree -C {} | head -100'
    )
    if [[ -n $dir ]]; then
        cd && cd "$dir"
    fi
    zle accept-line
    zle reset-prompt
}

# fh - repeat history
function fh() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -E 's/ *[0-9]*\*? *//' | sed -E 's/\\/\\\\/g')
}

function Prepend_Sudo {
  if [[ $BUFFER != "sudo "* ]]; then
    BUFFER="sudo $BUFFER"; CURSOR+=5
  fi
}

# Widgets
zle -N Prepend_Sudo
zle -N Change_Directory
zle -N Find_Edit

# BindKeys
bindkey -M vicmd s Prepend_Sudo
bindkey '^f' Change_Directory
bindkey '^g' Find_Edit
bindkey -s '^r' 'fh^M'
