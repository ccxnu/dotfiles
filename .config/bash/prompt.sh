# taken from =
#=========================================================
#Terminal Color Codes
#=========================================================
WHITE='\[\033[1;37m\]'
LIGHTGRAY='\[\033[0;37m\]'
GRAY='\[\033[1;30m\]'
BLACK='\[\033[0;30m\]'
RED='\[\033[0;31m\]'
LIGHTRED='\[\033[1;31m\]'
GREEN='\[\033[0;32m\]'
LIGHTGREEN='\[\033[1;32m\]'
BROWN='\[\033[0;33m\]' #Orange
YELLOW='\[\033[1;33m\]'
BLUE='\[\033[0;34m\]'
LIGHTBLUE='\[\033[1;34m\]'
PURPLE='\[\033[0;35m\]'
PINK='\[\033[1;35m\]' #Light Purple
CYAN='\[\033[0;36m\]'
LIGHTCYAN='\[\033[1;36m\]'
DEFAULT='\[\033[0m\]'

#=========================================================
# User Configuration
#=========================================================
# Colors
cERROR=$RED # Error block when previous command did not return 0
cSUCCESS=$GREEN  # When last command ran successfully and return 0
cSSH=$PINK # Color for brackets if session is an SSH session
cUSR=$LIGHTBLUE # Color of user
cUHS=$CYAN # Color of the user and hostname separator, probably '@'
cHST=$LIGHTGREEN # Color of hostname
cPWD=$BROWN # Color of current directory
cGIT=$PURPLE # Color of current directory
cCMD=$DEFAULT # Color of the command you type

# Enable block
eNL=1  # Have a newline between previous command output and new prompt
eSSH=1 # Track if session is SSH
eHOST=0 # Show user and host
ePWD=1 # Show current directory
eGIT=0 # Show git branch

# Block settings
UHS="@"

# Variables
FIRST_COMMAND_RAN=0

# Custom function
parse_git_branch() {
    ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    echo "("${ref#refs/heads/}")"
}

declare -A DIR_CLASSES=(
    ["$HOME/.config/nvim"]=""
    ["$HOME/Downloads"]=""
    ["$HOME/Documents"]="󰈙"
    ["$HOME/Pictures"]=""
    ["$HOME/Ists"]=""
    ["$HOME/Dev"]="󰅩"
)

# Function to get formatted directory name
get_short_dir() {
    local dir="$PWD"

    # Loop through directory mappings and apply icon if matched
    for key in "${!DIR_CLASSES[@]}"; do
        if [[ "$PWD" == "$key"* ]]; then
            local last_folder="$(basename "$PWD")"
            echo -e "${DIR_CLASSES[$key]} $last_folder"
            return
        fi
    done

    if [[ "$PWD" == "$HOME" ]]; then
        echo " ~"
        return
    fi

    # Default: show only the last folder
    echo "$(basename "$PWD")"
}

promptcmd()
{
        PREVRET=$?

        #=========================================================
        # check if user is in ssh session
        #=========================================================
        if [ $eSSH -eq 1 ]; then
                if [[ $SSH_CLIENT ]] || [[ $SSH2_CLIENT ]]; then
                        lSSH_FLAG=1
                else
                        lSSH_FLAG=0
                fi
        fi

        #=========================================================
        # Insert a new line to clear space from previous command
        #=========================================================
        if [ $eNL -eq 1 ] && [ $FIRST_COMMAND_RAN -eq 1 ]; then
            echo
        fi

        FIRST_COMMAND_RAN=1
        PS1=""

        #=========================================================
        # First Static block - User@host
        #=========================================================
        # set color for brackets if user is in ssh session
        if [ $eSSH -eq 1 ] && [ $lSSH_FLAG -eq 1 ] ; then
                sesClr="$cSSH"
        fi

        # Host Section
        if [ $eHOST -eq 1 ] || [ $lSSH_FLAG -eq 1 ] ; then   # Host is optional only without SSH
                PS1="${PS1}${sesClr}[${cUSR}\u${cUHS}${UHS}${cHST}\h${sesClr}]${cCMD} "
        fi

        #=========================================================
        # Second Static Block - Current Directory
        #=========================================================
        if [ $ePWD -eq 1 ]; then
                PS1="${PS1}${cPWD}$(get_short_dir)${cCMD} "
        fi

        #=========================================================
        # Third Static Block - Current Directory
        #=========================================================
        if [ $eGIT -eq 1 ]; then
                PS1="${PS1}${cGIT}$(parse_git_branch)${cCMD} "
        fi

        #=========================================================
        # Four Dynamic Block - Previous Command Error
        #=========================================================
        if [ $PREVRET -ne 0 ] ; then
                PS1="${PS1}${cERROR}${cCMD} "
        else
                PS1="${PS1}${cCMD}${cCMD} "
        fi
}

load_prompt () {
    # Get PIDs
    local parent_process=$(tr -d '\0' < /proc/$PPID/cmdline | cut -d \. -f 1)
    local my_process=$(tr -d '\0' < /proc/$$/cmdline | cut -d \. -f 1)

    if  [[ $parent_process == script* ]]; then
        PROMPT_COMMAND=""
        PS1="\t - \# - \u@\H { \w }\$ "
    elif [[ $parent_process == emacs* || $parent_process == xemacs* ]]; then
        PROMPT_COMMAND=""
        PS1="\u@\h { \w }\$ "
    else
        export DAY=$(date +%A)
        PROMPT_COMMAND=promptcmd
     fi
    export PS1 PROMPT_COMMAND
}

load_prompt
