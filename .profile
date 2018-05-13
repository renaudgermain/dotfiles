PATH=$HOME/usr/bin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/X11R6/bin:/usr/local/bin:/usr/local/sbin
ENV=$HOME/.kshrc
LANG=en_US.UTF-8
export PATH HOME TERM ENV LANG

if [ -n "$BASH" ]; then
  . $HOME/.bashrc
fi

