export EDITOR=emacs
export EMAIL=renaud.germain@ivadolabs.com
export GOPATH=$HOME
export JAVA_HOME="$(/usr/libexec/java_home -v 1.8)"
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/usr/bin:/usr/local/opt/libpq/bin
export PROJECT_DIR=~/src
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# export LESSOPEN # cat some.json | python -m json.tool

# source $(brew --prefix nvm)/nvm.sh

if [ ! -f ~/.zshrc.local ]; then
  for i in BITBUCKET BITBUCKET_SLUG JIRA TEAMCITY; do
    printf "$i="
    read tmp
    echo "export $i=$tmp" >> ~/.zshrc.local
  done
fi

. ~/.zshrc.local
. ~/.zshrc
