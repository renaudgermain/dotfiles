if [ -n "$BASH" ]; then
    . /etc/bash.bashrc
    . ~/.bashrc
fi

export PATH="$PATH:/sbin:/usr/sbin:$HOME/usr/bin:"
