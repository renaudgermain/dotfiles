case $(hostname):$1 in
    alpha:)
        xrandr --output qxl-0 --mode 1440x900
        xrdb ~/.Xresources
        exec ratpoison
        ;;
    delta:alpha)
        export QEMU_AUDIO_DRV=alsa
        qemu-system-x86_64 -m 2G -machine type=pc,accel=kvm -cpu host -enable-kvm \
            -vga qxl -hda ~/.qemu/alpha.img -smp 2 -netdev user,id=network0,hostfwd=tcp:127.0.0.1:8922-:22 \
            -device rtl8139,netdev=network0 -virtfs local,id=home,path=/home/rcog/media,security_model=none,mount_tag=media \
            -virtfs local,id=doc,path=/home/rcog/doc,security_model=none,mount_tag=doc \
            -soundhw ac97 -device virtio-serial-pci -device virtserialport,chardev=spicechannel0,name=com.redhat.spice.0 \
            -chardev spicevmc,id=spicechannel0,name=vdagent -spice unix,addr=/tmp/vm_spice.socket,disable-ticketing \
            -display none -daemonize # -display sdl,gl=on
        exec remote-viewer --full-screen spice+unix:///tmp/vm_spice.socket
        ;;
    delta:gulf)
        export QEMU_AUDIO_DRV=alsa
        exec qemu-system-x86_64 -full-screen -no-frame -m 4G -machine pc,accel=kvm -cpu kvm64 -enable-kvm -usb -usbdevice mouse \
             -netdev user,id=mynet0,hostfwd=tcp:127.0.0.1:7922-:22 -device e1000,netdev=mynet0 -smp 4 -vga vmware -soundhw ac97 ~/.qemu/gulf.img
        ;;
    delta:)
        feh --bg-center --no-fehbg ~/.wallpaper.jpg
        xrdb ~/.Xresources # -merge ?
        xsetroot -cursor_name left_ptr
        xset r rate 500 90
        x-terminal-emulator &
        setxkbmap -layout us,ca -variant ,multix -option grp:caps_toggle -option ctrl:swap_lwin_lctl -option ctrl:swap_rwin_rctl
        exec ssh-agent x-window-manager
        ;;
    delta:echo)
        exec qemu-system-x86_64 -full-screen -no-frame ~/.qemu/echo.img -machine type=pc,accel=kvm -m 1G -cpu host -enable-kvm \
             -vga virtio -netdev user,id=network0 -device rtl8139,netdev=network0
        ;;
    gulf*)
        xrandr --output default --mode 1440x900
        export LC_CTYPE="en_US.UTF-8"
        xset +fp /usr/local/share/fonts/inconsolata
        xrdb ~/.Xresources # -merge ?
        feh --bg-center --no-fehbg ~/.wallpaper.jpg
        setxkbmap -layout us,ca -variant ,multix -option grp:caps_toggle -option ctrl:swap_lwin_lctl -option ctrl:swap_rwin_rctl
        xset r rate 500 90
        # export TABBED_XID=$(tabbed -g 1440x900+0+0 -d)
        urxvt &
        firefox &
        exec ssh-agent cwm
        ;;
    hotel*)
        exec /opt/X11/bin/quartz-wm
        ;;
    *)
        echo "cannot start $(hostname):$1" > ~/.xsession-errors
        ;;
esac
