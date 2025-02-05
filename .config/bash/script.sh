# Personal scripts

# Detach from terminal.
# @url: https://www.reddit.com/r/bash/comments/1e5ddvr/looking_for_a_bash_configuration/
d() {
	setsid -f -- "$@" 0<&- &>/dev/null
}

de() {
	d "$@"; exit
}

# Kill a process
fkill() {
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

#
