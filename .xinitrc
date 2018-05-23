case $(uname):$(tty) in
    OpenBSD:*)
        export LC_CTYPE="en_US.UTF-8"
        xset +fp /usr/local/share/fonts/inconsolata
        xrdb ~/.Xresources # -merge ?
        feh --bg-center --no-fehbg ~/.wallpaper.jpg
        setxkbmap -layout us,ca -variant ,multix -option grp:caps_toggle -option ctrl:swap_lwin_lctl -option ctrl:swap_rwin_rctl
        xrandr -s 1
        xset r rate 500 90
        urxvt &
        xid=$(mktemp /tmp/tabbed.XXXXXXXXXXXX)
        tabbed -g 1024x768+0+0 -d > $xid
        surf -e $(< $xid)
        exec ssh-agent env TABBED_XID=$(< $xid) cwm
        ;;
    Linux:/dev/tty1)
        exec qemu-system-x86_64 -full-screen -no-frame -m 2048 -machine pc,accel=kvm -cpu kvm64 -enable-kvm -netdev user,id=mynet0,hostfwd=tcp:127.0.0.1:7922-:22 -device e1000,netdev=mynet0 -smp 4 ~/.qemu/gulf.img
        ;;
    Linux:*)
        feh --bg-center --no-fehbh ~/.wallpaper.jpg
        xrdb ~/.Xresources # -merge ?
        xsetroot -cursor_name left_ptr
        xset r rate 500 90
        urxvt &
        setxkbmap -layout us,ca -variant ,multix -option grp:caps_toggle -option ctrl:swap_lwin_lctl -option ctrl:swap_rwin_rctl
        exec ssh-agent xmonad
        ;;
esac
