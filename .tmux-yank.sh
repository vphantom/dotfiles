#!/bin/bash

set -eu

# get data either form stdin or from file
buf=$(cat "$@")

copy_use_osc52_fallback=$(tmux show-option -gvq "@copy_use_osc52_fallback")

# If no copy backends were eligible, decide to fallback to OSC 52 escape sequences
# Note, most terminals do not handle OSC
if [ "$copy_use_osc52_fallback" == "off" ]; then
  exit;
fi

# https://sunaku.github.io/tmux-yank-osc52.html
# The maximum length of an OSC 52 escape sequence is 100_000 bytes, of which
# 7 bytes are occupied by a "\033]52;c;" header, 1 byte by a "\a" footer, and
# 99_992 bytes by the base64-encoded result of 74_994 bytes of copyable text
maxlen=74994 

# build up OSC 52 ANSI escape sequence
esc="\033]52;p;$( printf %s "$buf" | head -c $maxlen | base64 | tr -d '\r\n' )\a"
esc="\033Ptmux;\033$esc\033\\"

# resolve target terminal to send escape sequence
# if we are on remote machine, send directly to SSH_TTY to transport escape sequence
# to terminal on local machine, so data lands in clipboard on our local machine
pane_active_tty=$(tmux list-panes -F "#{pane_active} #{pane_tty}" | awk '$1=="1" { print $2 }')
target_tty="${NFG_SSH_TTY:-$pane_active_tty}"

printf "$esc" > "$target_tty"
