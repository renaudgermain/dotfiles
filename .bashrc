shopt -s histappend
shopt -s cmdhist

alias emx="emacs -batch -l"
alias pl="moosic add -s"
alias clisp="clisp -q"
alias chromium="chromium --disable-gpu --disable-software-rasterizer"
alias frde='dict -d fd-fra-deu'
alias defr='dict -d fd-deu-fra'
alias octave='octave -q'
alias ls='ls -Bh --color=auto'
alias grep="grep --color=auto --exclude=.svn --exclude=.git"
alias su='su -'
alias swipl='swipl -q'
alias symbols="xpdf ~/doc/apps/TeX/symbols.pdf &"
alias sml="sml -Cprint.depth=100"
alias e='edit'
alias v='see'
alias mixer='ssh -t foxtrot alsamixer -c 0'
alias f='perl -lpe'
alias strings='strings -a'
alias inferno="emu -g1280x1024 -c1 /dis/wm/wm.dis wm/logon"
alias mplayer="mplayer -zoom -mixer-channel Master -really-quiet"
alias feh='feh -B black -F'

function i {
    for i in "$@"; do
        mediainfo --Inform=file:///home/rcog/.mediainforc "$i" | expand -30
    done
}

function fork {
    nohup $* >/dev/null 2>&1 &
    disown $!
}

function smv {
    a=($@)
    dst=${a[-1]}
    unset a[-1]
    for i in ${a[@]}; do
        scp $i $dst && rm -f $i
    done
}

function map {
    cmd=$1
    shift
    for i in $@; do $cmd $i; done
}

function startvm {
    startx $HOME/.xinitrc $1
}

# export LC_MESSAGES="de_DE.UTF-8"
# export LANGUAGE="de_DE.UTF-8"
export LS_COLORS=$LS_COLORS:'*.mp4=00;35:*.mkv=00;35:*.svg=00;35:*.pdf=00;32:*.txt=00;32:*.nfo=00;32:*.epub=00;32:*.ps=00;32:*.iso=00;31:*.log=00;32:*.rar=00;31'
export PROMPT_COMMAND='foo=$? && [ $foo != 0 ] && echo "Exit $foo"; history -a; history -n; test -d ~/Desktop && rmdir ~/Desktop'
export FIGNORE="~:.svn:.git"
export GREP_COLORS='ms=01;31:mc=01;31:sl=:cx=:fn=35:ln=32:bn=32:se=36:ne=:'
export PATH=$PATH:/home/rcog/usr/inferno/Linux/386/bin
export INPUTRC="~/.inputrc"
# export PULSE_SERVER='foxtrot'
export HISTTIMEFORMAT="%F %T "
export HISTFILESIZE=9999
export HISTSIZE=9999
export HISTFILE="$HOME/.bash_history"
# export TERM='rxvt-unicode'
export TERM='rxvt' # disable shitty color scheme from emacs
# export PS1="\[[00;34m\][\[[00;33m\]\u@\h \[[00;32m\]\W\[[00;34m\]]▶ \[[00m\]"
export PROMPT_COMMAND=__prompt_command
export EDITOR='/usr/bin/emacs'

function __prompt_command {
    if [ $? != 0 ]; then
        PS1="\[[00;34m\][\[[00;33m\]\u@\h \[[00;32m\]\W\[[00;34m\]]\[[00;31m\]▶ \[[00m\]"
    else
        PS1="\[[00;34m\][\[[00;33m\]\u@\h \[[00;32m\]\W\[[00;34m\]]▶ \[[00m\]"
    fi
    export SENDER_WIDTH=$((COLUMNS - 100))
}

if [ -n "$DISPLAY" ]; then
    xset -b
fi

# ps -C mediatomb > /dev/null || mediatomb --interface wlan1 --daemon --logfile $HOME/.mediatomb/mediatomb.log

_game() {
    local cur opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"

    if [[ ${COMP_CWORD} -gt 1 ]]; then
        COMPREPLY=( $(compgen -f ${cur}) )
        return 0
    else
        opts="alphacentauri diablo3 homeworld starcraft2 battle.net"
        COMPREPLY=($(compgen -W "${opts}" -- ${cur}))
        return 0
    fi
}
complete -o filenames -F _game game

function wttr {
    # curl "http://wttr.in/montreal?m"
    wget -q -O- "http://wttr.in/${1:-montreal}?m"
}

function vol {
    b="────────────────────────────────────────────────────────────────────────────────────────────────────"
    vol=$(amixer sget -M Master|tail -1|sed -e 's/.*\[\([0-9]\+\)%.*/\1/')
    stty -echo
    tput civis

    while read -p "Volume ${b:0:$vol}█${b:$vol:100} ($vol%)" -n1 char; do
      case $char in
        q) break;;
        h) vol=$((vol == 0 ? 0 : vol - 1));;
        l) vol=$((vol == 100 ? 100 : vol + 1));;
        m) vol=0;;
        0) vol=100;;
        1) vol=10;;
        2) vol=20;;
        3) vol=30;;
        4) vol=40;;
        5) vol=50;;
        6) vol=60;;
        7) vol=70;;
        8) vol=80;;
        9) vol=90;;
      esac
      tput cr
      tput el
      amixer -q -M sset Master $vol%
    done
    echo ""
    stty echo
    tput cnorm
}
