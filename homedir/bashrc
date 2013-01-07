# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

if [ -n "$CLEARCASE_ROOT" ]
then
   export CUR_VIEW=`echo $CLEARCASE_ROOT | tr '/' ' ' | mawk '{ print($2) }'`
#   if [ -z `mount | grep barrgr_exp_view | tr ' ' '_'` ]
#   then
#      echo "Mounting Vobs for the first time!"
#      sudo mount -a
#   fi
fi

# Comment in the above and uncomment this below for a color prompt
if [ `/usr/bin/whoami` == 'root' ]
then
   PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\[\033[01;31m\]\h\[\033[00m\]: \[\033[01;34m\]\w \$\[\033[00m\] '
else
   PS1='\[\033[01;32m\]\u@\h\[\033[0m\]:\[\033[1;35m\]$(basename `hg root 2> /dev/null` 2> /dev/null)$(basename `git rev-parse --show-toplevel 2>/dev/null` 2>/dev/null)\[\033[00m\]@\[\033[0;31m\]$(hg branch 2>/dev/null)$(git rev-parse --abbrev-ref HEAD 2>/dev/null)\[\033[0m\]: \[\033[01;34m\]\w\[\033[00m\] $ '
fi

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${CUR_VIEW}:${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

export CCRCCLI="/opt/ccrccli"
export PATH=$PATH:/opt/rational/clearcase/bin:~/bin:$CCRCCLI:.
export EDITOR=vi

# Colorize
alias grep="grep --color=tty"
alias minicom="minicom -c on"

