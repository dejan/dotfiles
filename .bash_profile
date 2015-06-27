# bash_completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# what's my ip
alias extip="dig +short myip.opendns.com @resolver1.opendns.com"
alias intip="ipconfig getifaddr en0"

# set default locale
export LANG=en_US.UTF-8

# set editor
export EDITOR=vim

# http://fredwu.me/post/60441991350/protip-ruby-devs-please-tweak-your-gc-settings-for
export RUBY_GC_MALLOC_LIMIT=90000000
export RUBY_FREE_MIN=200000
export RUBY_GC_HEAP_FREE_SLOTS=$RUBY_FREE_MIN   # ruby 2.1

# colors in terminal
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups  

# auto chruby
source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh

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
