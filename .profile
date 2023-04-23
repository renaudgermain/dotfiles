PATH=$HOME/usr/bin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/X11R6/bin:/usr/local/bin:/usr/local/sbin:/usr/local/lib/surfraw
ENV=$HOME/.kshrc
LANG=C
EMAIL=renaud.germain@gmail.com
SURFRAW_browser=x-www-browser
LESSOPEN="|~/.lessfilter %s"
export PATH HOME TERM ENV LANG LESSOPEN EMAIL SURFRAW_browser
ulimit -c 0

if [ -n "$BASH" ]; then
  . $HOME/.bashrc
fi
