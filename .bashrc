#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Allows programs ran with nope to show no output and not block shell 
nope() {
    setsid $@ &> /dev/null
}

emacs_run() {
	emacsclient -n -e "(> (length (frame-list)) 1)" | grep -q t
	if [ "$?" = "1" ]; then
    	emacsclient -c -n -a "" "$@"
	else
    	emacsclient -n -a "" "$@"
	fi
}

# ALIASES
alias ls='ls -la --color=auto'
alias which='which -a'
alias startx='startx ~/.xinitrc'
alias clock='tty-clock -t -s -c -C 5 -f "%A %B %d %Y"'
alias matrix='cmatrix -C magenta'
alias e='emacs_run'
# alias e='nope emacsclient'
# alias e='nope emacs'
alias viv='nope vivaldi-stable'
alias lite='nope lite-xl'
alias code='nope vscodium'
alias fire='nope firefox'
alias zath='nope zathura'
alias xcolor='xcolor -s'
alias open='xdg-open'
alias clip='xclip -selection clipboard -rmlastnl'

# ADD TO PATH
PATH=~/.local/bin:~/bin:$PATH

# FZF Colors
export FZF_DEFAULT_OPTS='--color=marker:#a56c9e,spinner:#a56c9e,header:#a56c9e,pointer:#a56c9e,prompt:#a56c9e'

# Chrome path
export CHROME_PATH='/usr/bin/vivaldi-stable'

# Wine 32bit prefix
export WINEPREFIX='/home/AH/.wine'

export XSECURELOCK_PASSWORD_PROMPT=asterisks

PS1='\[\e[38;5;141m\]\u·\h \W > \[\e[m\]'

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi
