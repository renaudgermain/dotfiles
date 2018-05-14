export PATH=$HOME/src/ftk-scripts:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/usr/bin
export FTK_SCRIPTS=$HOME/src/ftk-scripts
export JAVA_HOME="$(/usr/libexec/java_home -v 1.8)"
export NVM_DIR=~/.nvm
export PROJECT_DIR=~/src
export EDITOR=emacs

# export LESSOPEN # cat some.json | python -m json.tool

source $(brew --prefix nvm)/nvm.sh

. ~/.zshrc
