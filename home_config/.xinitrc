#!/bin/sh

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

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/?*.sh; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

xrdb -merge ~/.Xresources

# Keyboard layout
setxkbmap us &

# Display resolution
xrandr --output eDP-1 --mode 1920x1080 &

# Compositor
picom --config $HOME/.config/picom/picom.conf &

# Notification
dunst &

# Keybindings
sxhkd &

# Mouse
xinput --set-prop "pointer:Meetion Wireless" "libinput Accel Speed" -0.25 &
imwheel -b "45" &

# Wallpaper
wallpaper-changer &

# Problems with Java applications
wmname LG3D &
export _JAVA_AWT_WM_NONREPARENTING=1
# export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true'

# Execute DWM
exec dwm
