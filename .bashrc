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
		if [[ $x == *" "* ]]; then
			cmd+=" \"$x\""
			continue
		fi
		cmd+=" $x"
	done
	cmd+=" &> /dev/null"
	eval $cmd
}

source "/home/AH/.bash_functions"

# ALIASES
alias ls="ls -lah --color=auto --group-directories-first"
alias du="du -sh"
alias which="which -a"
alias startx="startx ~/.xinitrc"
alias tar="tar --auto-compress"
alias clock="tty-clock -t -s -c -C 5 -f '%A %B %d %Y'"
alias matrix="cmatrix -C magenta"
alias e="emacs_run"
alias code="nope vscodium"
alias viv="nope vivaldi-stable"
alias chromium="nope chromium"
alias fire="nope firefox"
alias tor_browser="nope chromium --incognito --proxy-server=socks://localhost:9050"
alias zath="nope zathura"
alias feh="feh -g 683x384 -q --scale-down -B black"
alias sxiv="sxiv -b"
alias xcolor="xcolor -s"
alias open="xdg-open"
alias clip="xclip -selection clipboard -rmlastnl"
alias xelatex="xelatex -interaction=nonstopmode"
alias toggle_nightmode="xsct --toggle"

# ADD TO PATH
PATH=~/.local/bin:$PATH

# Qt
export QT_QPA_PLATFORMTHEME=gtk2

# FZF Colors
export FZF_DEFAULT_OPTS="--color=marker:#a56c9e,spinner:#a56c9e,header:#a56c9e,pointer:#a56c9e,prompt:#a56c9e"

# Chrome path
export CHROME_PATH="/usr/bin/vivaldi-stable"

# initalizing ANDROID_HOME
export ANDROID_HOME="/opt/android-sdk"

# Wine 32bit prefix
export WINEPREFIX="~/.wine"

# clipmenu
export CM_SELECTIONS="clipboard"
export CM_HISTLENGTH="0"

# xsecurelock
export XSECURELOCK_NO_COMPOSITE=1
export XSECURELOCK_DISCARD_FIRST_KEYPRESS=1
export XSECURELOCK_PASSWORD_PROMPT="asterisks"
export XSECURELOCK_FONT="IBM Plex Mono:style=Regular"
export XSECURELOCK_SHOW_DATETIME=0
export XSECURELOCK_SHOW_KEYBOARD_LAYOUT=0
export XSECURELOCK_SHOW_DATETIME=0
export XSECURELOCK_SHOW_HOSTNAME=0
export XSECURELOCK_SHOW_USERNAME=0

export SUDO_PROMPT="sudo > "
figlet "AH"
# PS1="\[\e[38;5;140m\]\u·\h \W > \[\e[m\]"
PS1="\[\e[38;5;139m\]\u·\h \W > \[\e[m\]"
