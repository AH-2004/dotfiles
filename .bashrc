#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Allows programs ran with nope to show no output and not block shell
nope() {
    setsid $@ &> /dev/null
}

alias ls='ls --color=auto'
alias shutdown='shutdown -P now'
alias clock='tty-clock -t -s -c -C 5 -f "%A %B %d %y"'
alias matrix='cmatrix -C magenta'
alias viv='nope vivaldi-stable'
alias fire='nope firefox'
alias zath='nope zathura'
alias lite='nope lite-xl'
alias emacs='emacs -nw'
alias code='nope vscodium'
alias xcolor='xcolor -s'

#Add to PATH
PATH=$PATH:~/.local/bin

#FZF Colors
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'--color=marker:#a56c9e,spinner:#a56c9e,header:#a56c9e,pointer:#a56c9e,prompt:#a56c9e'

#PS1='\e[0;35m\u·\h \W > \e[m'
PS1='\u·\h \W > '

# figlet
figlet AH | lolcat
