alias br='tail -50 log/build.log'
alias cp='cp -i'
alias e='emacs'
alias grep="grep --exclude=TAGS --exclude='*.class' --color=always"
alias less='less --RAW-CONTROL-CHARS --quit-if-one-screen --no-init'
alias ls='ls -G'
alias mv='mv -i'
alias mvn='MAVEN_OPTS=-Djansi.force=true mvn -B --log-file log/build.log -Dstyle.color=always --global-settings ~/.m2/settings.xml --fail-fast -DfailIfNoTests=false -Dmaven.test.failure.ignore=false' # https://issues.apache.org/jira/browse/MNG-6380
alias rm='rm -i'
alias scala='scala -deprecation -Xlint -feature'
alias tags='rm -f TAGS; find . -name "*.java" -print | xargs etags --append'

HISTFILE=~/.zhistory
HISTSIZE=SAVEHIST=10000
setopt sharehistory
setopt extendedhistory
setopt HIST_IGNORE_DUPS

export LESSOPEN="|~/.lessfilter %s"
umask 007

function precmd {
  # man zshmisc
  if [ $? != 0 ]; then
      suffix='%F{red}▶ %f'
  else
      suffix='%F{blue}▶ %f'
  fi
  PS1='%F{blue}[%F{yellow}%n@%m %F{green}%~%F{blue}]'$suffix
  export SENDER_WIDTH=50
  export SUBJECT_WITDH=150
  branch_name=$(git symbolic-ref -q HEAD 2>/dev/null)
  branch_name=${branch_name##*/} # ${branch_name##refs/heads/}
  branch_name=${branch_name:-HEAD}
  RPROMPT="%F{blue}[$branch_name]%f"

  for i in Documents Downloads Movies Music Pictures; do
    if [ -d ~/$i ]; then
        /bin/rm -f ~/$i/.localized
        chmod -N ~/$i # https://discussions.apple.com/thread/2750331
        rmdir ~/$i
    fi
  done
}

function nod { # notify on done
  $*
  osascript -e "display notification \"$*\" with title \"Command Done\""
}
