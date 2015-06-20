export PATH="~/bin:$PATH"
# Colours
export BLUE="\[\033[0;34m\]"
export NO_COLOR="\[\e[0m\]"
export GRAY="\[\033[1;30m\]"
export GREEN="\[\033[0;32m\]"
export LIGHT_GRAY="\[\033[0;37m\]"
export LIGHT_GREEN="\[\033[1;32m\]"
export LIGHT_RED="\[\033[1;31m\]"
export RED="\[\033[0;31m\]"
export WHITE="\[\033[1;37m\]"
export YELLOW="\[\033[0;33m\]"

# ls and grep colorize
export GREP_OPTIONS="--color=auto"
export GREP_COLOR="4;33"
export CLICOLOR="auto"
export GEM_EDITOR="mate"

# Erase duplicates in history
export HISTCONTROL=erasedups
# Store 10k history entries
export HISTSIZE=10000
# Append to the history file when exiting instead of overwriting it
shopt -s histappend

alias ls='ls -G'

alias jsonget="curl -X GET -H 'Accept: application/json'"

alias gem_uninstall_all="gem list | cut -d\" \" -f1 | fgrep -v bundler | fgrep -v rake | fgrep -v rdoc | fgrep -v test-unit | fgrep -v rvm |  fgrep -v psych | fgrep -v json | xargs gem uninstall -aIx"

alias start_redis="redis-server /usr/local/etc/redis.conf"

alias l='ls -lG'

alias postgres_boost="sudo sysctl -w kern.sysv.shmall=65536 && sudo sysctl -w kern.sysv.shmmax=16777216"

function heroku_pg_dump {
  if [ -z "$1" ]; then
  echo "App name should be given"
  else
  curl -o latest.dump `heroku pgbackups:url -a "$1"`
  fi
}

function heroku_generate_backup {
  if [ -z "$1" ]; then
  echo "App name should be given"
  else
  `heroku pgbackups:capture -a "$1"`
  fi
}

function pg_restore_db {
  pg_restore -h localhost --verbose --clean --no-acl --no-owner -d $1 $2
}

function emacs {
  emacs-24.3 $1
}

custom_prompt () {
  local BRANCH=`git branch 2> /dev/null | grep \* | sed 's/* //'`

  if [[ "$BRANCH" = "" ]]; then
    BRANCH=`git status 2> /dev/null | grep "On branch" | sed 's/# On branch //'`
  fi

  local RUBY_VERSION=`rvm-prompt`
  local RUBY_PROMPT=""
  local STATUS=`git status 2>/dev/null`
  local PROMPT_COLOR=$GREEN
  local STATE=" "
  local NOTHING_TO_COMMIT="# Initial commit"
  local BEHIND="# Your branch is behind"
  local AHEAD="# Your branch is ahead"
  local UNTRACKED="# Untracked files"
  local DIVERGED="have diverged"
  local CHANGED="# Changed but not updated"
  local TO_BE_COMMITED="# Changes to be committed"
  local LOG=`git log -1 2> /dev/null`

  RUBY_PROMPT="${RED}(${RUBY_VERSION})${NO_COLOR} "

  if [ "$STATUS" != "" ]; then
    if [[ "$STATUS" =~ "$NOTHING_TO_COMMIT" ]]; then
      PROMPT_COLOR=$RED
      STATE=""
    elif [[ "$STATUS" =~ "$DIVERGED" ]]; then
      PROMPT_COLOR=$RED
      STATE="${STATE}${RED}↕${NO_COLOR}"
    elif [[ "$STATUS" =~ "$BEHIND" ]]; then
      PROMPT_COLOR=$RED
      STATE="${STATE}${RED}↓${NO_COLOR}"
    elif [[ "$STATUS" =~ "$AHEAD" ]]; then
      PROMPT_COLOR=$RED
      STATE="${STATE}${RED}↑${NO_COLOR}"
    elif [[ "$STATUS" =~ "$CHANGED" ]]; then
      PROMPT_COLOR=$RED
      STATE=""
    elif [[ "$STATUS" =~ "$TO_BE_COMMITED" ]]; then
      PROMPT_COLOR=$RED
      STATE=""
    else
      PROMPT_COLOR=$GREEN
      STATE=""
    fi

    if [[ "$STATUS" =~ "$UNTRACKED" ]]; then
      STATE="${STATE}${YELLOW}*${NO_COLOR}"
    fi

    PS1=" ${RUBY_PROMPT}${YELLOW}\w\a${NO_COLOR} (${PROMPT_COLOR}${BRANCH}${NO_COLOR}${STATE}${NO_COLOR})\n⤷  "
  else
    PS1=" ${RUBY_PROMPT}${YELLOW}\w\a${NO_COLOR}\n⤷  "
  fi
}

source ~/.git_completion.sh

PROMPT_COMMAND=custom_prompt
EDITOR=vim
export EDITOR

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

PATH=$PATH:/usr/local/share/npm/bin/
