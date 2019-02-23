[ -z "$PS1" ] && return
export PERL5LIB=$HOME/bin/lib

## The following should be in ~/.profile but I don't want to restart X every time I change them

# Personal addition for user-level global NodeJS stuff
if [ -d "$HOME/.node_modules_global/bin" ]; then
	export PATH="$HOME/.node_modules_global/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# 500 is WAY too short for me
export HISTFILESIZE=1000000
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
export HISTCONTROL=ignoreboth
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
alias ls="ls --color=auto"
alias ll="ls --time-style=long-iso --group-directories-first -hlptr"
alias dir="ls -hAl"
alias dri="dir"
alias idr="dir"
alias rdir="dir"
alias free="free -m"

# An alias no longer cuts it
usage() {
	du -bh --max-depth=1 "${1:-.}" |sort -h
}
titlepng() {
	if [ ".$2." = ".." ]; then echo "Usage: titlepng png_file 'title'"; return 1; fi
	convert "$1" -pointsize 36 "label:$2" +swap -gravity Center -append "${1}-titled.png"
}

alias mux="tmux new-session -A -D -s local"
alias df="df -h --total"
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"
alias relirc="sudo /etc/init.d/lirc stop ; sudo rmmod lirc_serial lirc_dev ; sudo /etc/init.d/lirc start"
alias tt="TODOTXT_FINAL_FILTER='t.filter-relevance' t"
alias mp="mplayer"
alias mplayerhifi="mplayer -ac hwdts,hwac3,"
alias mplayerfast="mplayer -af scaletempo"
alias mplayerpal="mplayer -aspect 4:3 -af scaletempo=speed=pitch -speed 0.96"
alias np="mplayer -ao alsa"
alias npfast="mplayerfast -ao alsa"
alias pp="mplayerfast -ao alsa:device=plughw=1"
alias hmplayer="mplayer -display :0.1 -fs"
alias hmplayerpal="mplayerpal -display :0.1 -fs"
alias hnplayer="mplayer -ao alsa -display :0.1 -fs"
alias hmplayerhifi="mplayerhifi -display :0.1 -fs"
alias hmplayerfast="mplayerfast -display :0.1 -fs"
# Disable menu and -vf screenshot, as they interfere with VDPAU decoding
alias hmplayerhd="hmplayerhifi -nomenu -vf-del 0 -vo vdpau:deint=3 -vc ffh264vdpau,ffmpeg12vdpau, -cache 8192 -correct-pts"
# Needed 5.1 pass-through (needs re-encoding for endian-ness sometimes) and
# inverted de-interlacing from the usual hmplayerhd.
alias hmplayerf1="mplayer -display :0.1 -fs -nomenu -vf-del 0 -field-dominance 0 -vo vdpau:deint=3 -vc ffh264vdpau,ffmpeg12vdpau, -cache 8192 -correct-pts -channels 6 -af lavcac3enc=1,format=ac3le"
#alias tv="ircat tvsh |ssh 192.168.5.1 /video/tmp/tv-remote.sh"
alias tv="hdhomerun_config 1033FBCF"
alias tvlc="vlc udp://@:5000/ &"
alias gmail="mutt -f $HOME/Secure/mail/gmail-since-201102"
# Somehow the Canopus is always "Playing paused" and I have to use dvgrab
# interactively and hit "p" to un-pause it before I can capture.  Every time.
#alias canopus="dvgrab --format dv2 --opendml --guid 0020110102002000 --noavc --size 500 --buffers 1000 --interactive capture"
alias canopus="dvgrab --format dv2 --opendml --guid 0020110102002000 --nostop --size 500 --buffers 1000 --interactive capture"
alias dayshift="redshift -vox"
alias nightshift="redshift -v -P -o -b 0.67 -O 3700"
alias dayshade="redshift -v -P -o -b 1.0 -O 4200"
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

PATH="./:/home/lis/perl5/bin${PATH+:}${PATH}"; export PATH;
PERL5LIB="/home/lis/perl5/lib/perl5${PERL5LIB+:}${PERL5LIB}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/lis/perl5${PERL_LOCAL_LIB_ROOT+:}${PERL_LOCAL_LIB_ROOT}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/lis/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/lis/perl5"; export PERL_MM_OPT;

GPG_TTY=`tty`
export GPG_TTY

export GTK_IM_MODULE=xim
export QT_IM_MODULE=xim

# ibus recommends:
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus

# OPAM configuration
. /home/lis/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

# FZF
source /usr/share/doc/fzf/examples/key-bindings.bash


# In how many hours will $2 hours be reached if we've done $1 already?
function eta {
	if [ -z "$2" ]; then echo "Usage: eta done target"; return; fi
	NOW=`date +%s`
	DONE="$1"
	TARGET="$2"
	LEFT=`echo "$TARGET - $DONE" |bc`
	DONESTAMP=`echo "$NOW + (($TARGET - $DONE) * 3600)" |bc |cut -d. -f1`
	echo "$LEFT hours left"
	echo "ETA @ `date --date @$DONESTAMP '+%H:%M:%S'`"
}
