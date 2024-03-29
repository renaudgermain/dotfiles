alias bgg='boardgamegeek'
alias cabal='env TMPDIR=/usr/local/cabal/build/ cabal'
alias ls='colorls -G'
alias su='su -'
alias e='emacs'
alias feh='feh --scale-down --image-bg black --fullscreen --hide-pointer'
alias off="ssh delta env DISPLAY=$(ssh delta ps aux | grep gulf | grep xserver | sed -e 's/.* \(:[0-9]\) .*/\1/') xset dpms force off"
alias cp='cp -i'
alias mpv='mpv --vo=x11 --profile=sw-fast'
alias mv='mv -i'
alias rm='rm -i'
alias tmux='tmux -u'

export PAGER='less'
export EDITOR='emacs'
export HISTCONTROL=ignoredups:ignorespace
export HISTFILE=~/.ksh_history
export HISTSIZE=10000
export LSCOLORS="HxgxfxdxcxDxedCbCbHBbH"
export MANPATH=":$HOME/usr/share/man"
export NQDIR="$HOME/.cache/nq"
export PS1='$(test -d ~/Downloads && rmdir ~/Downloads)[34m[[33m\u@\h [32m\w[34m][$(($? == 0 ? 34 : 31))m▶[0m '
export SENDER_WIDTH=$(((COLUMNS - 30) * 2 / 5))
export SUBJECT_WIDTH=$(((COLUMNS - 30) * 3 / 5))

umask 077
ulimit -c 0

bind -m '^L'='^U clear^J^Y'

function wttr { curl "http://wttr.in/${1:-montreal}?m"; }
function i { for i in "$@"; do mediainfo --Inform=file://$HOME/.mediainforc "$i" | expand -30; done; }

function mz {
    cmd=$1
    shift
    case $cmd in
        play)
            for i in "$@"; do nq -c mpg321 "$i"; done
            ;;
        pause)
            current=$(find ~/.cache/nq/ -perm u+rwx -type f)
            pid=$(echo $current | sed -e 's/.*\.//')
            echo $pid > ~/.cache/mz.pid
            kill -s SIGSTOP $pid
            ;;
        resume)
            pid=$(cat ~/.cache/mz.pid)
            kill -s SIGCONT $pid
            ;;
        list)
            current=$(find ~/.cache/nq/ -perm u+rwx -type f)
            for f in $(ls -tr $(find ~/.cache/nq -anewer $current -type f)); do
                ps -p $(echo $f | sed -e 's/.*\.//') | tail -1
            done
            ;;
        clear)
            echo "Not implemented"
            ;;
        *)
            echo $cmd
            echo "mz {play|pause|resume|list|clear} my_song.mp3 ..."
            ;;
    esac
}

# IFS='
# '
# set -A complete_pass init ls find show grep insert edit generate rm mv cp git help version \
#     $(cd ~/.password-store; find * -name '*.gpg' | sed -ne 's/^\(.*\)\.gpg$/\1/p')
# IFS=' '
