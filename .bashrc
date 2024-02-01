[ -z "$PS1" ] && return

## The following should be in ~/.profile but I don't want to restart X every time I change them

pathadd() {
	if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
		PATH="${1}${PATH:+":$PATH"}"
	fi
}
pathadd "$HOME/perl5/bin"
pathadd "$HOME/.node_modules_global/bin"
pathadd "$HOME/bin"

# 500 is WAY too short for me
export HISTFILESIZE=10000000
export HISTCONTROL="ignorespace:ignoredups:erasedups"
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
shopt -s histappend
shopt -s checkwinsize
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac
if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
fi
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

alias netstat="netstat -tuw"
alias ls="ls --color=auto --group-directories-first"
alias ll="ls --time-style=long-iso -hlptr"
alias dir="ls -hAl"
alias dri="dir"
alias idr="dir"
alias rdir="dir"
alias free="free -m"

titlepng() {
	if [ ".$2." = ".." ]; then echo "Usage: titlepng png_file 'title'"; return 1; fi
	convert "$1" -pointsize 36 "label:$2" +swap -gravity Center -append "${1}-titled.png"
}

alias df="df -h --total"
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"
alias grep="grep --color"
#alias relirc="sudo /etc/init.d/lirc stop ; sudo rmmod lirc_serial lirc_dev ; sudo /etc/init.d/lirc start"
#alias tv="ircat tvsh |ssh 192.168.5.1 /video/tmp/tv-remote.sh"
#alias tv="hdhomerun_config 1033FBCF"
#alias tvlc="vlc udp://@:5000/ &"
# Somehow the Canopus is always "Playing paused" and I have to use dvgrab
# interactively and hit "p" to un-pause it before I can capture.  Every time.
##alias canopus="dvgrab --format dv2 --opendml --guid 0020110102002000 --noavc --size 500 --buffers 1000 --interactive capture"
#alias canopus="dvgrab --format dv2 --opendml --guid 0020110102002000 --nostop --size 500 --buffers 1000 --interactive capture"
alias dayshift="redshift -vox"
alias nightshift="redshift -v -P -o -b 0.67 -O 3700"
alias dayshade="redshift -v -P -o -b 1.0 -O 5000"
alias godim="redshift -v -P -o -b 0.67 -O 6500"

## Search excluding binaries and SVN files
#alias sgrep='grep -Ir --exclude="*\.svn*"'

# Help with ls (coreutils 8.25+ dictate crazy defaults)
unset LC_ALL
export LC_COLLATE="POSIX"
export LC_CTYPE="$LANG"
export LC_MESSAGES="$LANG"
export LC_MONETARY="$LANG"
export LC_NUMERIC="$LANG"
export LC_TIME="$LANG"
export QUOTING_STYLE=literal

# Help with ridiculously unfriendly disappearing scrollbars
export GTK_OVERLAY_SCROLLING=0
export LIBOVERLAY_SCROLLBAR=0
gsettings set org.gnome.desktop.interface overlay-scrolling false 2>/dev/null
gdbus call --session --dest org.freedesktop.DBus --object-path /org/freedesktop/DBus --method org.freedesktop.DBus.UpdateActivationEnvironment '{"GTK_OVERLAY_SCROLLING": "0"}' >/dev/null
gdbus call --session --dest org.freedesktop.DBus --object-path /org/freedesktop/DBus --method org.freedesktop.DBus.UpdateActivationEnvironment '{"LIBOVERLAY_SCROLLBAR": "0"}' >/dev/null

export PERL5LIB="$HOME/bin/lib:$HOME/perl5/lib/perl5${PERL5LIB+:}${PERL5LIB}"
export PERL_LOCAL_LIB_ROOT="/home/lis/perl5${PERL_LOCAL_LIB_ROOT+:}${PERL_LOCAL_LIB_ROOT}"
export PERL_MB_OPT="--install_base \"/home/lis/perl5\""
export PERL_MM_OPT="INSTALL_BASE=/home/lis/perl5"

GPG_TTY=`tty`
export GPG_TTY

export GTK_IM_MODULE=xim
export QT_IM_MODULE=xim

# ibus recommends:
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus

# Unscrap GNOME scrollbars
export GTK_OVERLAY_SCROLLING=0
gdbus call --session --dest org.freedesktop.DBus --object-path /org/freedesktop/DBus --method org.freedesktop.DBus.UpdateActivationEnvironment '{"GTK_OVERLAY_SCROLLING": "0"}' >/dev/null

# Android hacking
if [ -d "$HOME/bin/android/platform-tools" ] ; then
	export PATH="$HOME/bin/android/platform-tools:$PATH"
fi

# OPAM configuration
. /home/lis/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

# FZF
source /usr/share/doc/fzf/examples/key-bindings.bash

# GNU Make
export MAKEFLAGS="-j$(nproc)"

function vig {
	vi $(git ls-files --modified)
}

function clean_history {
	local IN=~/.bash_history
	local TMP=~/.bash_history-bak
	rm -f $TMP && mv $IN $TMP && tac $TMP |awk '!x[$0]++' |tac >$IN
}
