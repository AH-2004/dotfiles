#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Allows programs ran with nope to show no output and not block shell
nope () {
	local cmd="setsid $1"
	shift
	for x in "$@"; do
		if [[ $x == *' '* ]]; then
			cmd+=" \"$x\""
			continue
		fi
		cmd+=" $x"
	done
	cmd+=" &> /dev/null"
	eval $cmd
}

emacs_run() {
	emacsclient -n -e "(> (length (frame-list)) 1)" | grep -q t
	if [ "$?" == "1" ]; then
    	emacsclient -c -n -a "" "$@"
	else
    	emacsclient -n -a "" "$@"
	fi
}

init_cpp() { mkdir -p "./$1" && cp -r "/home/AH/code/cpp/makefile_template"/* "./$1"; }

# ALIASES
alias ls='ls -la --color=auto'
alias which='which -a'
alias startx='startx ~/.xinitrc'
alias clock='tty-clock -t -s -c -C 5 -f "%A %B %d %Y"'
alias matrix='cmatrix -C magenta'
alias e='emacs_run'
alias viv='nope vivaldi-stable'
alias lite='nope lite-xl'
alias code='nope vscodium'
alias fire='nope firefox'
alias zath='nope zathura'
alias xcolor='xcolor -s'
alias open='xdg-open'
alias clip='xclip -selection clipboard -rmlastnl'
alias emacs_restart='systemctl --user restart emacs.service'

# ADD TO PATH
PATH=~/.local/bin:~/bin:$PATH

# FZF Colors
export FZF_DEFAULT_OPTS='--color=marker:#a56c9e,spinner:#a56c9e,header:#a56c9e,pointer:#a56c9e,prompt:#a56c9e'

# Chrome path
export CHROME_PATH='/usr/bin/vivaldi-stable'

# initalizing ANDROID_HOME
export ANDROID_HOME='/opt/android-sdk'

# Wine 32bit prefix
export WINEPREFIX='/home/AH/.wine'

# clipmenu
export CM_SELECTIONS="clipboard"
export CM_HISTLENGTH="0"

PS1='\[\e[38;5;141m\]\u·\h \W > \[\e[m\]'
