alias cat='bat'
alias cp='cp -i'
alias e='emacs'
alias grep="grep --exclude=TAGS --exclude='*.class' --color=always"
alias less='bat'
alias ls='ls -G'
alias mv='mv -i'
alias rm='rm -i'
alias scala='scala -deprecation -Xlint -feature'
alias tags='rm -f TAGS; find * -name "*.py" -print | xargs etags --append --regex="/\(def\|class\)[ \t]+\([A-Za-z_]+\)/\2/" --regex="/^\([A-Z_]+\)/\1/"'
alias vi='vim -i NONE'

HISTFILE=~/.zhistory
HISTSIZE=SAVEHIST=10000
setopt sharehistory
setopt extendedhistory
setopt HIST_IGNORE_DUPS

export LESSOPEN="|-~/.lessfilter %s"
export PAGER='less -L'
export AZURE_STORAGE_CONNECTION_STRING=$(az storage account show-connection-string -g RG_EA_Infra_CACE_Hellcat_POC -n brphellcatcacelrspoc| jq -r .connectionString)
export PYTHONDONTWRITEBYTECODE=1
export WORDCHARS='*?_-.[]~&;!#$%^(){}<>'

umask 077

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

  rm -rf ~/Movies/TV
  for i in Applications Documents Downloads Movies Music Pictures Public; do
    if [ -d ~/$i ]; then
        /bin/rm -f ~/$i/.localized
        chmod -N ~/$i # https://discussions.apple.com/thread/2750331
        rmdir ~/$i
    fi
  done
  rm -f ~/Google\ Drive
}

function nod { # notify on done
  $*
  osascript -e "display notification \"$*\" with title \"Command Done\""
}

function 2fa {
  oathtool --base32 --totp $(lpass show $1 --notes|head -1) | pbcopy
}

function keyboard { # not working
  case $1 in
    enable)
      sudo kextload /System/Library/Extensions/AppleUSBTopCase.kext/Contents/PlugIns/AppleUSBTCKeyboard.kext/
    ;;
    disable)
      sudo kextunload /System/Library/Extensions/AppleUSBTopCase.kext/Contents/PlugIns/AppleUSBTCKeyboard.kext/
    ;;
    *)
      echo "keyboard {enable|disable}"
      ;;
  esac
}

function mysql {
  p=$(lpass show databases --password)
  /usr/local/opt/mysql@5.5/bin/mysql --defaults-extra-file=<(echo "[client]\nuser=$USER\npassword=$p") $*
}

function sqlcmd {
   env INPUTRC=<(echo '"\C-m": "\C-jGO\C-j"') rlwrap --always-readline -t dumb --forget-matching GO sqlcmd $*
}
