# 500 is WAY too short for me
export HISTFILESIZE=100000
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
export HISTCONTROL=ignoreboth
shopt -s histappend
shopt -s checkwinsize

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

alias netstat="netstat -tuw"
alias ls="ls --color=auto"
alias ll="ls --time-style=long-iso --group-directories-first -hlptr"
alias dir="ls -hAl"
alias dri="dir"
alias idr="dir"
alias rdir="dir"
alias free="free -m"
#alias cf="loadkeys cf"
#alias us="loadkeys us"
alias usage="du -bh --max-depth=1 |sort -h"
alias df="df -h --total"
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"
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
alias tv="hdhomerun_config 1033FBCF"
alias tvlc="vlc udp://@:5000/ &"
alias gmail="mutt -f $HOME/Secure/mail/gmail-since-201102"
# Somehow the Canopus is always "Playing paused" and I have to use dvgrab
# interactively and hit "p" to un-pause it before I can capture.  Every time.
#alias canopus="dvgrab --format dv2 --opendml --guid 0020110102002000 --noavc --size 500 --buffers 1000 --interactive capture"
alias canopus="dvgrab --format dv2 --opendml --guid 0020110102002000 --nostop --size 500 --buffers 1000 --interactive capture"
alias dayshift="redshift -v -o -b 1.0 -O 6500"
alias nightshift="redshift -v -o -b 0.67 -O 3700"
alias dayshade="redshift -v -o -b 1.0 -O 4200"
alias godim="redshift -v -o -b 0.67 -O 6500"

# Help with ls sort order
export LC_COLLATE="POSIX"

export GREP_OPTIONS="--color=auto"

PATH="./:/home/lis/perl5/bin${PATH+:}${PATH}"; export PATH;
PERL5LIB="/home/lis/perl5/lib/perl5${PERL5LIB+:}${PERL5LIB}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/lis/perl5${PERL_LOCAL_LIB_ROOT+:}${PERL_LOCAL_LIB_ROOT}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/lis/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/lis/perl5"; export PERL_MM_OPT;
