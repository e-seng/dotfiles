#!/bin/sh

xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then







    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then







    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# remove base xinitrc values
# twm &
# xclock -geometry 50x50-1+1 &
# xterm -geometry 80x50+494+51 &
# xterm -geometry 80x20+494-0 &
# exec xterm -geometry 80x66+0+0 -name login

# set background
wal -R &
# enable the compositor
picom --config $HOME/.config/picom.conf --experimental-backends &
# set monitor arragement
xrandr --output DP1 --auto &
# enable mouse timeout
unclutter &
# enable polkit agent
# /usr/lib/lxpolkit/lxpolkit &
# lock the screen when necessary
light-locker &
# listen for notifs
dunst &
# set touchpad button map
xinput set-button-map `xinput | grep -iF 'touchpad' | cut -d'=' -f2 | cut -f1` 1 1 7 &
# set screen brightness on boot
echo 18000 > /sys/class/intel_backlight/brightness
exec dbus-launch i3
