#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Allows programs ran with nope to show no output and not block shell 
nope() {
    setsid $@ &> /dev/null
}

# ALIASES
alias ls='ls -la --color=auto'
alias clock='tty-clock -t -s -c -C 5 -f "%A %B %d %Y"'
alias matrix='cmatrix -C magenta'
alias aur='epiphany aur.archlinux.org'
alias emacs='emacs -nw'
alias viv='nope vivaldi-stable'
alias lite='nope lite-xl'
alias code='nope vscodium'
alias fire='nope firefox'
alias zath='nope zathura'
alias netmap='sudo nmap -sP 192.168.10.0/24'
alias xcolor='xcolor -s'

# ADD TO PATH
PATH=~/.local/bin:~/bin:$PATH

# FZF Colors
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'--color=marker:#a56c9e,spinner:#a56c9e,header:#a56c9e,pointer:#a56c9e,prompt:#a56c9e'

# Chrome path
export CHROME_PATH='/usr/bin/vivaldi-stable'

# Wine 32bit prefix
export WINEPREFIX='/home/AH/.wine'

PS1='\e[38;5;141m\u·\h \W > \e[m'
# PS1='\u·\h \W > '

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi
