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
alias which='which -a'
alias clock='tty-clock -t -s -c -C 5 -f "%A %B %d %Y"'
alias matrix='cmatrix -C magenta'
alias aur='epiphany aur.archlinux.org'
alias emacs='nope emacsclient --create-frame'
alias e='emacsclient -nw' # Might remove this alias in the future.
alias viv='nope vivaldi-stable'
alias lite='nope lite-xl'
alias code='nope vscodium'
alias fire='nope firefox'
alias zath='nope zathura'
alias xcolor='xcolor -s'
alias open='xdg-open'

# ADD TO PATH
PATH=~/.local/bin:~/bin:$PATH

# FZF Colors
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'--color=marker:#a56c9e,spinner:#a56c9e,header:#a56c9e,pointer:#a56c9e,prompt:#a56c9e'

# Chrome path
export CHROME_PATH='/usr/bin/vivaldi-stable'

# Proton Prefix (For Rocket League)
export STEAM_COMPAT_DATA_PATH='/home/AH/.local/share/Steam/steamapps/compatdata/3198406695'
export STEAM_COMPAT_CLIENT_INSTALL_PATH='/home/AH/.local/share/Steam'

PS1='\[\e[38;5;141m\]\u·\h \W > \[\e[m\]'

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi
