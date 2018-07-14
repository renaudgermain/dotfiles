alias bgg='boardgamegeek'
alias ls='ls -F'
alias su='su -'
alias e='emacs'
alias off="ssh delta env DISPLAY=$(ssh delta ps aux | grep gulf | grep xserver | sed -e 's/.* \(:[0-9]\) .*/\1/') xset dpms force off"
alias cp='cp -i'
alias mpv='mpv --vo=x11 --ao=sndio'
alias mv='mv -i'
alias pl='nq -c mpg321'
alias rm='rm -i'
alias tmux='tmux -u'
alias wp='wikipedia'

export PAGER='less'
export EDITOR='emacs'
export MANPATH=":$HOME/usr/share/man"
export NQDIR="$HOME/.cache/nq"
export PS1="[34m[[33m\u@\h [32m\w[34m]▶[0m "
export SENDER_WIDTH=$((COLUMNS - 125))
export SUBJECT_WIDTH=$((COLUMNS - 60))
export SURFRAW_browser=x-www-browser

bind -m '^L'='^U'clear'^J^Y'

function wttr { curl "http://wttr.in/${1:-montreal}?m"; }

# IFS='
# '
# set -A complete_pass init ls find show grep insert edit generate rm mv cp git help version \
#     $(cd ~/.password-store; find * -name '*.gpg' | sed -ne 's/^\(.*\)\.gpg$/\1/p')
# IFS=' '
