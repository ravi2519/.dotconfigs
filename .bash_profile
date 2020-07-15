
alias h="history 50"
alias j="jobs -l"
alias la="ls -a"
alias lf="ls -FA"
alias ll="ls -lA"
alias rhub="cd /usr/env60/html/rhub"
alias log="cd /usr/env60/log"
alias lib="cd /usr/env60/lib"
alias bin="cd /usr/env60/bin"
alias lb="cd /usr/env60/data/lb"
alias logs="cd /usr/local/apache2/logs"
alias c="clear"

umask 22

PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/games:/usr/local/sbin:/usr/local/bin
export PATH
EDITOR=vim
export EDITOR
PAGER=more
export PAGER
BLOCKSIZE=K
export BLOCKSIZE
PACKAGESITE="http://ftp-archive.freebsd.org/pub/FreeBSD-Archive/ports/i386/packages-8.1-release/Latest/"
export PACKAGESITE


# PS1="\n%{\033[31m%}%/ %{\033[1;33m%}%m%{\033[1;33m%}%% %{\033[0m%} "
#PS1="[\A\[\033[0;32m\] \W \[\033[0m\]]\\$ "

# https://forums.freebsd.org/threads/colorize-your-bash-like-linux.45006/

if [[ $- != *i* ]] ; then
  # Shell is non-interactive.  Be done now!
  return
fi

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

# Enable history appending instead of overwriting.  #139609
shopt -s histappend

# Change the window title of X terminals 
case ${TERM} in
  xterm*|rxvt*|Eterm|aterm|kterm|gnome*|interix)
      PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\007"'
      ;;
  screen)
      PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\033\\"'
      ;;
esac

use_color=false

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.
safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
match_lhs=""
[[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs}    ]] \
  && type -P dircolors >/dev/null \
  && match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

if ${use_color} ; then
  # Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
  if type -P dircolors >/dev/null ; then
      if [[ -f ~/.dir_colors ]] ; then
          eval $(dircolors -b ~/.dir_colors)
      elif [[ -f /etc/DIR_COLORS ]] ; then
          eval $(dircolors -b /etc/DIR_COLORS)
      fi
  fi

  if [[ ${EUID} == 0 ]] ; then
      #PS1='\[\033[01;31m\]\u@\h\[\033[01;34m\] \W \$\[\033[00m\] '
      PS1='\n\[\033[01;31m\]\u@\h\[\033[01;34m\] \w (\!) \$\[\033[00m\] '
  else
      PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] '
  fi

  CLICOLOR="YES";    export CLICOLOR
  LSCOLORS="ExGxFxdxCxDxDxhbadExEx";    export LSCOLORS
  #alias ls='ls --color=auto'
  #alias grep='grep --colour=auto'
else
  if [[ ${EUID} == 0 ]] ; then
      # show root@ when we don't have colors
      PS1='\u@\h \W \$ '
  else
      PS1='\u@\h \w \$ '
  fi
fi

# Try to keep environment pollution down, EPA loves us.
unset use_color safe_term match_lhs
