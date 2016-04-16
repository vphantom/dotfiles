# My personalized X startup sequence

# Allow my other computer to open windows here.
#xhost +lis

# Help xdg-open along...
export DESKTOP_SESSION=gnome

# Load my X default resources (mostly to make xterm behave).
xrdb -merge ~/.Xdefaults

# Saving more energy (CPU, GPU and monitor) by using Xorg's built-in DPMS.
xset s on
xset s expose
xset s blank
xset s 900 900
xset dpms 1200 3600 0

# nVidia introduced severe tearing in video playback when Compositing was
# enabled.  Hence I dumped Compiz.  In OpenBox, the following enabled
# compositing.
#xcompmgr -CcfF -D2 &

# In Fluxbox, and possibly Openbox, use theme, not xsetroot if you use
# xcompmgr, but hsetroot helps.
xsetroot -solid black
hsetroot -solid "#000000"

~/bin/keyboard

# Mouse acceleration
#xset m 1 10
# http://xorg.freedesktop.org/wiki/Development/Documentation/PointerAcceleration
#
## HP Wireless Optical Mobile Mouse
##
## This gives a smooth ramp-up of acceleration at a scale suitable for my
## 1250cpi mouse.  Tried creating a class in xorg.conf but it was ignored, even
## though a similar keyboard class was useful.
#xinput set-prop "HP Wireless Optical Mobile Mouse" "Device Accel Profile" 2
#xinput set-prop "HP Wireless Optical Mobile Mouse" "Device Accel Constant Deceleration" 4
#xinput set-prop "HP Wireless Optical Mobile Mouse" "Device Accel Adaptive Deceleration" 1
#
# ImPS/2 Generic Wheel Mouse
#
# This is my hard-wired PS/2 HP mouse.
xinput set-prop "ImPS/2 Generic Wheel Mouse" "Device Accel Profile" 2
xinput set-prop "ImPS/2 Generic Wheel Mouse" "Device Accel Constant Deceleration" 2
xinput set-prop "ImPS/2 Generic Wheel Mouse" "Device Accel Adaptive Deceleration" 1

# Logitech QuickCam 9000 Pro
# If we want extended controls, here they are.
#sudo guvcview -a
# Confirm the new controls are in by listing them with:
# uvcdynctrl -c

# Change screen gamma based on time of day
# Location hard-coded to Sherbrooke, QC, Canada
# Apparent memory leak in gtk-redshift, so trying headless version.
# Commenting in favor of manual aliases "nightshift" and "dayshift"
#redshift -l 45.41770:-71.92608 -b 1.0:0.67 -t 6500:3700 &

# Task bar
# LXpanel crashes all the time, but it's otherwise been adjusted to my needs.
while true; do lxpanel; sleep 1; done &

# System monitor
gkrellm &

# My system's broken somehow:
/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &

# We're done!
exec /etc/alternatives/x-window-manager
#exec xterm
