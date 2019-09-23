# default locale
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# colored terminal
export CLICOLOR=1

# editor
export EDITOR=vim

# compact history
export HISTCONTROL=ignoredups

# increase ulimit
ulimit -n 8192

# put current git branch in the prompt
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
if [ "$TERM" != "dumb" ]; then
  function proml {
    local BLUE="\[\033[0;34m\]"
    local RED="\[\033[0;31m\]"
    local LIGHT_RED="\[\033[1;31m\]"
    local GREEN="\[\033[0;32m\]"
    local LIGHT_GREEN="\[\033[1;32m\]"
    local WHITE="\[\033[1;37m\]"
    local LIGHT_GRAY="\[\033[0;22m\]"
    case $TERM in
      xterm*)
      TITLEBAR='\[\033]0;\u@\h:\w\007\]'
      ;;
      *)
      TITLEBAR=""
      ;;
    esac

  PS1="${TITLEBAR}\
$RED[$RED\$(date +%H:%M)$RED]\
$GREEN[$GREEN\w$GREEN\$(parse_git_branch)$GREEN]\
$LIGHT_GRAY\$ "
  PS2='> '
  PS4='+ '
  }
  proml

  function prs {
    PS1="$ "
  }
fi

# bash_completion
# brew install bash-completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# list processes by port
process_at_port() {
 if [ -z "$1" ]
 then
   echo "Usage: process_at_port <port>"
 else
   lsof -n -i4TCP:$1 | grep LISTEN
 fi
}

# what's my ip
alias extip="dig +short myip.opendns.com @resolver1.opendns.com"
alias intip="ifconfig | grep 'inet ' | grep -v 127.0.0.1  | cut -d  ' ' -f 2"

# go
export GOPATH=$HOME

# ruby
# brew install rbevn
eval "$(rbenv init -)"
