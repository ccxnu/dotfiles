# Personal scripts

# Detach from terminal.
# @url: https://www.reddit.com/r/bash/comments/1e5ddvr/looking_for_a_bash_configuration/
d() {
	setsid -f -- "$@" 0<&- &>/dev/null
}

de() {
	d "$@"; exit
}

generate_password() {
    openssl rand -base64 $1
}

show_colors_256() { #{{{
    echo -e "\n\033[1;37m256-Color Palette:\033[0m"
    for i in {0..255}; do
        printf "\033[38;5;${i}m%4d " "$i" ## [48 background; [38 foreground;
        if (( (i + 1) % 16 == 0 )); then echo; fi
    done
    echo -e "\e[0m"
}
#}}}

# Took from https://gist.github.com/simlei/032470cfcd23641987f97a96749128d7
decompress() { #{{{
    local opt
    local OPTIND=1
    while getopts "hv" opt; do
        case "$opt" in
            h)
                cat <<End-Of-Usage
Usage: ${FUNCNAME[0]} [option] <archives>
    options:
        -h  show this message and exit
        -v  verbosely list files processed
End-Of-Usage
                return
                ;;
            v)
                local -r verbose='v'
                ;;
            ?)
                decompress -h >&2
                return 1
                ;;
        esac
    done
    shift $((OPTIND-1))

    [ $# -eq 0 ] && decompress -h && return 1
    while [ $# -gt 0 ]; do
	    if [ -f "$1" ]; then
		    case "$1" in
                *.tar.bz2|*.tbz|*.tbz2) tar "x${verbose}jf" "$1" ;;
                *.tar.gz|*.tgz) tar "x${verbose}zf" "$1" ;;
                *.tar.xz) xz --decompress "$1"; set -- "$@" "${1:0:-3}" ;;
                *.tar.Z) uncompress "$1"; set -- "$@" "${1:0:-2}" ;;
                *.bz2) bunzip2 "$1" ;;
                *.deb) dpkg-deb -x${verbose} "$1" "${1:0:-4}" ;;
                *.pax.gz) gunzip "$1"; set -- "$@" "${1:0:-3}" ;;
                *.gz) gunzip "$1" ;;
                *.pax) pax -r -f "$1" ;;
                *.pkg) pkgutil --expand "$1" "${1:0:-4}" ;;
                *.rar) unrar x "$1" ;;
                *.rpm) rpm2cpio "$1" | cpio -idm${verbose} ;;
                *.tar) tar "x${verbose}f" "$1" ;;
                *.txz) mv "$1" "${1:0:-4}.tar.xz"; set -- "$@" "${1:0:-4}.tar.xz" ;;
                *.xz) xz --decompress "$1" ;;
                *.zip|*.war|*.jar) unzip "$1" ;;
                *.Z) uncompress "$1" ;;
                *.7z) 7za x "$1" ;;
                *) echo "'$1' cannot be decompressed via decompress" >&2;;
		    esac
        else
		    echo "decompress: '$1' is not a valid file" >&2
	    fi
        shift
    done
}
#}}}
