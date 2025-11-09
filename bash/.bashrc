# Bash Config

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# History
HISTCONTROL=ignoreboth:eraseboth     # no duplicate entries, no start with space
HISTSIZE=100000                      # big big history
HISTFILESIZE=100000                  # big big history
shopt -s histappend                  # append to history, don't overwrite it
shopt -s globstar                   # pattern "**" match all

# Fix double paste issue
bind 'set enable-bracketed-paste off'

# Completition - install bash-completion
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  fi
fi

# Load Aliases, fzf, prompt and scripts
source $HOME/.config/bash/alias.sh
source $HOME/.config/bash/prompt.sh
source $HOME/.config/bash/fzf.sh
source $HOME/.config/bash/script.sh
