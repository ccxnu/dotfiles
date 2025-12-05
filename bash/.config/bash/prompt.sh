# Color
RED='\[\033[0;31m\]'
GREEN='\[\033[0;32m\]'
BLUE='\[\033[0;34m\]'
MAGENTA='\[\033[0;35m\]'
CYAN='\[\033[0;36m\]'
DEFAULT='\[\033[0m\]'

# Simple Prompt
promptcmd() {
    PREVRET=$?

    # Simple prompt for root
    if [ "$EUID" -eq 0 ]; then
        PS1="\u@\h:\w# "
        return
    fi

    PS1=""
    # Current directory
    PS1="${PS1}${BLUE}$(basename "$PWD")${DEFAULT} "
    # Git branch if available
    ref=$(git symbolic-ref HEAD 2>/dev/null)
    if [ $? -eq 0 ]; then
        PS1="${PS1}${MAGENTA}(${ref#refs/heads/})${DEFAULT} "
    fi
    # Error indicator
    if [ $PREVRET -ne 0 ]; then
        PS1="${PS1}${RED}✗${DEFAULT} "
    else
        PS1="${PS1}${GREEN}>${DEFAULT} "
    fi
}

PROMPT_COMMAND="promptcmd; history -a"
