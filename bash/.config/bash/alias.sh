alias vi="nvim"
alias svi="sudo -E nvim"
alias xi="sudo xbps-install"
alias xr="sudo xbps-remove -R"
alias xq="xbps-query"
alias im="nsxiv"

alias gp='git push'
alias gpu='git push -u origin main'
alias ga='git add'
alias gaa='git add .'
alias gc="git commit -m"
alias gao='git remote add origin'
alias gso='git remote set-url origin'
alias guisw='git update-index --skip-worktree'

alias ls='ls -F'     # This adds indicators
alias la='ls -A'     #long list,show almost all,show type,human readable
alias ll='ls -lAh'   #long list
alias lh='ls -ld .*'
alias lt='ls -l'

alias nmount="sudo mount /dev/sdb1 /media -o uid=1000,gid=1000"
alias nwmount="sudo mount -t exfat -o uid=1000,gid=1000 /dev/sdb1 /media"
alias unmount="sudo umount /dev/sdb1"

# Update grub config
alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"

alias tme="tmux a -t me"

alias za="zathura"

alias count="find . -type f | wc -l"

alias e="exit"
alias c="clear"

alias mpvall="mpv --no-terminal . &"

alias cs="xclip -selection clipboard"
alias vs="xclip -o -selection clipboard"
