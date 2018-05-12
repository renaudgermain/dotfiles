exec qemu-system-x86_64 -full-screen -no-frame -m 2048 -machine pc,accel=kvm -cpu kvm64 -enable-kvm -netdev user,id=mynet0,hostfwd=tcp:127.0.0.1:7922-:22 -device e1000,netdev=mynet0 -smp 4 /home/rcog/.qemu/gulf.img


# feh --bg-center /home/rcog/.wallpaper.jpg
# xsetroot -cursor_name left_ptr
# xset r rate 500 90
# urxvt &
# fetchmail
# setxkbmap -layout us,ca -variant ,multix -option grp:caps_toggle -option ctrl:swap_lwin_lctl -option ctrl:swap_rwin_rctl
# exec xmonad


# old old
# vvvvvvv

# -*- shell-script -*-
# 
# add 'Modes "640x480"' to the depth 16 section and then,
# startx -- :1 -depth 16
# 
# trying to force a config or a logfile as such:
#    startx -- :1 -config xorg_vbox.confg -logfile /home/rcog/tmp/Xorg.log
# makes Xorg drop root privilege, which sucks big time
# 
# has to startx from console, as specified in /etc/X11/Xwrapper.config

exec vboxsdl --hostkey 312 0 --startvm winxp
