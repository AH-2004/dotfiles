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

# Commands to compress, decompress, list archives
zip_tar () {
	TARNAME="${!#}"
	set -- "${@:1:$#-1}"
	bsdtar -cf $TARNAME "$@"
}

unzip_tar () {
	BASENAME="${2:-$(cut -d . -f 1 <<< "$1")}"
	mkdir -p $BASENAME
	bsdtar -xf $1 -C $BASENAME
}

ls_tar () { bsdtar -tf $1; }

# init C++ program
init_cpp() { mkdir -p "./$1" && cp -r "/home/AH/code/cpp/makefile_template"/* "./$1"; }

# init C program
init_c() { mkdir -p "./$1" && cp -r "/home/AH/code/c/makefile_template"/* "./$1"; }

emacs_run() {
	emacsclient -n -e "(> (length (frame-list)) 1)" | grep -q t
	if [ "$?" == "1" ]; then
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
PATH=~/.local/bin:$PATH

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

# xsecurelock
export XSECURELOCK_NO_COMPOSITE=1
export XSECURELOCK_DISCARD_FIRST_KEYPRESS=1
export XSECURELOCK_PASSWORD_PROMPT="asterisks"
export XSECURELOCK_FONT="IBM Plex Mono:style=Regular"
export XSECURELOCK_SHOW_DATETIME=1
export XSECURELOCK_SHOW_KEYBOARD_LAYOUT=0
export XSECURELOCK_SHOW_DATETIME=0
export XSECURELOCK_SHOW_HOSTNAME=0
export XSECURELOCK_SHOW_USERNAME=0

PS1='\[\e[38;5;141m\]\u·\h \W > \[\e[m\]'
