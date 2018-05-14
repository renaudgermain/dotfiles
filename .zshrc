alias ls='ls -G'
alias e='emacs'
alias rm='rm -i'
alias grep="grep --exclude=TAGS --exclude='*.class' --color=always"
alias tags='rm -f TAGS; find . -name "*.java" -print | xargs etags --append'
alias less='less -R'

HISTFILE=~/.zhistory
HISTSIZE=SAVEHIST=10000
setopt sharehistory
setopt extendedhistory
setopt HIST_IGNORE_DUPS

umask 007

function precmd {
  # man zshmisc
  if [ $? != 0 ]; then
      suffix='%F{red}▶ %f'
  else
      suffix='%F{blue}▶ %f'
  fi
  PS1='%F{blue}[%F{yellow}%n@%m %F{green}%~%F{blue}]'$suffix
  export SENDER_WIDTH=$((COLUMNS - 150))
	branch_name=$(git symbolic-ref -q HEAD 2>/dev/null)
	branch_name=${branch_name##*/} # ${branch_name##refs/heads/}
	branch_name=${branch_name:-HEAD}
	RPROMPT="%F{blue}[$branch_name]%f"
}

function nod { # notify on done
  $*
  osascript -e "display notification \"$*\" with title \"Command Done\""
}
