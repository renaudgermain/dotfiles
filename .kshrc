alias ls='ls -F'
alias su='su -'
alias e='emacs'
alias off='ssh delta env DISPLAY=:0 xset dpms force off'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias tmux='tmux -u'

export PAGER='less'
export EDITOR='emacs'
export PS1="[34m[[33m\u@\h [32m\w[34m]▶[0m "
export SENDER_WIDTH=$((COLUMNS - 100))
export SURFRAW_browser=x-www-browser

bind -m '^L'=clear'^J'
