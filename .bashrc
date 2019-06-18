# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
export HISTCONTROL=ignoreboth
# Don't record some commands
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"

# append to the history file, don't overwrite it
shopt -s histappend
shopt -s cmdhist
export PROMPT_COMMAND='history -a'

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=1000000
export HISTFILESIZE=1000000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar 2> /dev/null

# Tab Completion
bind "set show-all-if-ambiguous on"
bind "set mark-symlinked-directories on"

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ -f ~/opt/git-dev/contrib/completion/git-prompt.sh ]; then
   source ~/opt/git-dev/contrib/completion/git-prompt.sh;
   export GIT_PS1_SHOWDIRTYSTATE="yes"
   export GIT_PS1_SHOWUPSTREAM="auto"
   export GIT_PS1_SHOWCOLORHINTS="yes"
   export GIT_PS1_SHOWUNTRACKEDFILES="yes"
   export GIT_PS1_STATESEPARATOR=""
   PROMPT_COMMAND='__git_ps1 "\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]" "\\\$ " "[%s]"'
else
   if [ "$color_prompt" = yes ]; then
      PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
   else
      PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
   fi
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'


# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

#include user bin in path
if [ -d "$HOME/bin" ]; then
   PATH="$HOME/bin:$PATH";
fi
#include pip/setuptools bin
if [ -d "$HOME/.local/bin" ]; then
   PATH="$HOME/.local/bin:$PATH";
fi

#include cargo bin
if [ -d "$HOME/.cargo/bin" ]; then
   PATH="$HOME/.cargo/bin:$PATH";
fi


# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

if [ -f ~/opt/git-dev/contrib/completion/git-completion.bash ]; then
	source ~/opt/git-dev/contrib/completion/git-completion.bash
fi

#bash-completion for beets
eval "$(beet completion)";


export EDITOR=vim

# pip bash completion start
_pip_completion()
{
    COMPREPLY=( $( COMP_WORDS="${COMP_WORDS[*]}" \
                   COMP_CWORD=$COMP_CWORD \
                   PIP_AUTO_COMPLETE=1 $1 ) )
}
complete -o default -F _pip_completion pip
# pip bash completion end


#SSH Config
cat $HOME/.ssh/config.in > $HOME/.ssh/config
cat $HOME/.ssh/config.private >> $HOME/.ssh/config
chmod 600 $HOME/.ssh/config

eval "$(stack --bash-completion-script stack)"

if type ds >/dev/null; then
	function _ds_autocomplete_()
	{
		case $COMP_CWORD in
			1) COMPREPLY=($(compgen -back -A function -- "${COMP_WORDS[COMP_CWORD]}"));;
			*) COMPREPLY=();;
		esac
	}

	complete -o filenames -o default -F _ds_autocomplete_ ds
fi

export PYTHONSTARTUP=$HOME/.startup.py

if command -v tmux>/dev/null; then
  [[ ! $TERM =~ screen ]] && [ -z $TMUX ] && { tmux attach || exec tmux new-session && exit;}
fi

export SUMO_HOME=/home/nathdwek/share/sumo

