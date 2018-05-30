PATH=$HOME/usr/bin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/X11R6/bin:/usr/local/bin:/usr/local/sbin:/usr/local/lib/surfraw
ENV=$HOME/.kshrc
LANG=en_US.UTF-8
EMAIL=renaud.germain@gmail.com
export PATH HOME TERM ENV LANG EMAIL

if [ -n "$BASH" ]; then
  . $HOME/.bashrc
fi
