function fish_prompt --description 'Write out the prompt'
   set -l color_suffix
   if test $status -eq 0
      set color_suffix blue
   else
      set color_suffix red
   end

   # Just calculate this once, to save a few cycles when displaying the prompt
   if not set -q __fish_prompt_hostname
      set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
   end

   set -l color_cwd
   set -l suffix
   switch $USER
      case root toor
         if set -q fish_color_cwd_root
            set color_cwd $fish_color_cwd_root
         else
            set color_cwd $fish_color_cwd
         end
         set suffix '#'
      case '*'
         set color_cwd $fish_color_cwd
         set suffix '▶'
   end

   set --global --export SENDER_WIDTH (math $COLUMNS - 100)

   echo -n -s (set_color blue) [ (set_color yellow) "$USER" @ "$__fish_prompt_hostname" \
   ' ' (set_color $color_cwd) (prompt_pwd) (set_color blue) ] (set_color $color_suffix) "$suffix " (set_color normal)
end

function startvm --description "Start a virtual machine"
   startx $HOME/.xinitrc $argv[1]
end

function aide; echo -e "Changer configuration clavier: Caps Lock\nChanger fenêtres: Control-J\nNouvelle fenêtre de navigation privée dans Firefox: Alt-f w"; end
function dpigs; dpkg-query --show --showformat "\${Installed-Size}\t\${Package}\n" | sort -rn; end
function e; emacs -nw $argv; end
function f; perl -lpe $argv; end
function i; for i in $argv; mediainfo --Inform=file:///home/rcog/.mediainforc "$i" | expand -30; end; end
function v; see $argv; end
function cp; /bin/cp -i $argv; end
function ls; /bin/ls -Bh --color=auto $argv; end
function mv; /bin/mv -i $argv; end
function rm; /bin/rm -i $argv; end
function pl; moosic add --sort $argv; end
function su; /bin/su - $argv; end
function feh; /usr/bin/feh -B black -F $argv; end
function mpv; /usr/bin/mpv --really-quiet $argv; end
function grep; /bin/grep --color=auto --exclude=.svn --exclude=.git $argv; end
function first; echo $argv[1]; end
function strings; /usr/bin/strings -a $argv; end
function wttr; wget -q -O- "http://wttr.in/"(first $argv[1] montreal)"?m"; end

# _game() {
#     local cur opts
#     COMPREPLY=()
#     cur="${COMP_WORDS[COMP_CWORD]}"
#
#     if [[ ${COMP_CWORD} -gt 1 ]]; then
#         COMPREPLY=( $(compgen -f ${cur}) )
#         return 0
#     else
#         opts="alphacentauri diablo3 homeworld starcraft2 battle.net"
#         COMPREPLY=($(compgen -W "${opts}" -- ${cur}))
#         return 0
#     fi
# }
# complete -o filenames -F _game game

set -x LS_COLORS 'no=00:fi=00:di=01;37:ln=01;36:pi=00;33:so=01;35:do=01;35:bd=01;33:cd=01;33:or=01;31:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=00;35:*.jpeg=00;35:*.gif=00;35:*.bmp=00;35:*.pbm=00;35:*.pgm=00;35:*.ppm=00;35:*.tga=00;35:*.xbm=00;35:*.xpm=00;35:*.tif=00;35:*.tiff=00;35:*.png=00;35:*.mov=00;35:*.mpg=00;35:*.mpeg=00;35:*.avi=00;35:*.rm=00;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=00;35:*.mp3=00;35:*.wav=00;35:*.m4v=00;35:*.mp4=00;35:*.mkv=00;35:*.svg=00;35:*.pdf=00;32:*.txt=00;32:*.xml=00;32:*.json=00;32:*.nfo=00;32:*.epub=00;32:*.ps=00;32:*.iso=00;31:*.log=00;32:*.rar=00;31'
set -x GREP_COLORS 'ms=01;31:mc=01;31:sl=:cx=:fn=35:ln=32:bn=32:se=36:ne=:'
set -x EDITOR '/usr/bin/emacs'
set -x PATH $PATH /home/rcog/usr/inferno/Linux/386/bin /sbin /usr/sbin $HOME/usr/bin
set -x TERM 'xterm-256color'
set fish_greeting

# file (find | psub) # process substitution

# shopt -s histappend
# shopt -s cmdhist
#
# alias inferno="emu -g1280x1024 -c1 /dis/wm/wm.dis wm/logon"
# alias emx="emacs -batch -l"
# alias symbols="xpdf ~/doc/apps/TeX/symbols.pdf &"
# alias sml="sml -Cprint.depth=100"
# alias mixer='ssh -t foxtrot alsamixer -c 0'
#
# function fork {
#     nohup $* >/dev/null 2>&1 &
#     disown $!
# }
#
# function smv {
#     a=($@)
#     dst=${a[-1]}
#     unset a[-1]
#     for i in ${a[@]}; do
#         scp $i $dst && rm -f $i
#     done
# }
#
# function map {
#     cmd=$1
#     shift
#     for i in $@; do $cmd $i; done
# }
#
# export FIGNORE="~:.svn:.git"
# export INPUTRC="~/.inputrc"
# export HISTTIMEFORMAT="%F %T "
# export HISTFILESIZE=9999
# export HISTSIZE=9999
# export HISTFILE="$HOME/.bash_history"
# # export TERM='rxvt-unicode'
# export TERM='rxvt' # disable shitty color scheme from emacs
#
# if [ -n "$DISPLAY" ]; then xset -b; fi

# if daemon doesn't exist, run `emacs --daemon`
