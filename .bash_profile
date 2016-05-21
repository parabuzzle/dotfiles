#Git Branch Parsing
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

#Set color codes
function proml {
  local        BLUE="\[\033[0;34m\]"
  local         RED="\[\033[0;31m\]"
  local   LIGHT_RED="\[\033[1;31m\]"
  local       GREEN="\[\033[0;32m\]"
  local LIGHT_GREEN="\[\033[1;32m\]"
  local       WHITE="\[\033[0;37m\]"
  local  LIGHT_GRAY="\[\033[0;37m\]"
  case $TERM in
    xterm*)
    TITLEBAR='\[\033]0;\u@\h:\w\007\]'
    ;;
    *)
    TITLEBAR=""
    ;;
  esac

  #Set Prompt
PS1="${TITLEBAR}\
$BLUE[$LIGHT_GRAY\$(date +%H:%M:%S)$BLUE]$RED\u@\h:\w$WHITE\$(parse_git_branch)$GREEN\$$WHITE "
PS2='> '
PS4='+ '

  # green prompt
  #PS1="${TITLEBAR}\
  #$WHITE[$LIGHT_GRAY\$(date +%H:%M:%S)$WHITE]$LIGHT_GREEN\u@\h:\w$WHITE\$(parse_git_branch)$WHITE\$$WHITE "
  #PS2='> '
  #PS4='+ '
}
proml

if [ -e ~/.aliases ]; then
  source ~/.aliases
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export PATH="/usr/local/share/npm/bin:$PATH"
export HD_HOME=~/tools/hd
export HADOOP_PREFIX=~/tools/hd/hadoop
export HBASE_HOME=~/tools/hd/hbase
export PATH="/usr/local/share/npm/bin:/usr/local/heroku/bin:$HADOOP_PREFIX/bin:$HBASE_HOME/bin:$PATH"

# Set up docker machine on login
if [ `docker-machine ls | grep default | wc -l` -gt 0 ]; then duse default; fi

# Alias git to hub if it exists
if [ "`which hub | wc -l`" -gt "0" ]; then alias git="hub"; fi
