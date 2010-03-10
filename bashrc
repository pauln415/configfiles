#
# .bashrc
#

KERNEL=`uname`

# Customizations for OS used
case "$KERNEL" in
Darwin)
  export PATH=$PATH:~/bin:/usr/local/bin:/opt/local/bin:/opt/local/lib/mysql5/bin:~/bin/ec2-api-tools/bin
  export MANPATH=$MANPATH:/usr/local/man:/opt/local/man
  export EDITOR=vim
  ;;
Linux)
  export PATH=$PATH:~/bin:/usr/local/bin
  export MANPATH=$MANPATH:/usr/local/man
  export EDITOR=vim
  ;;
SunOS)
  export PATH=$PATH:~/bin:/usr/local/bin:/opt/csw/bin:/usr/local/apache2/bin
  export MANPATH=$MANPATH:/usr/local/man:/opt/csw/man
  export EDITOR=vi
  ;;
*)
  ;;
esac

if [ -d ~/bin ]; then
  export PATH=~/bin:$PATH
fi

export SVN_EDITOR=/usr/bin/vi
export JAVA_HOME=/Library/Java/Home
export EC2_HOME=~/bin/ec2-api-tools
export EC2_PRIVATE_KEY=~/.ec2/ec2-pk.pem
export EC2_CERT=~/.ec2/ec2-cert.pem
export EC2_URL=https://ec2.us-west-1.amazonaws.com
export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'
export CLICOLOR=1
#export LS_COLORS='di=36:fi=0:ln=31:pi=5:so=5:bd=5:cd=5:or=31:mi=0:ex=35:*.rb=90'
#ls colors: http://www.macosxhints.com/article.php?story=20031025162727485
#           http://krypted.com/mac-os-x/colorizing-the-terminal/
export LSCOLORS='gxfxcxdxbxegedabagacad'

# Bash Prompt
export PROMPT_COMMAND='echo -ne "\033]0;[${USER}@${HOSTNAME%%.*}: ${PWD/#$HOME/~}]"; echo -ne "\007"'

# Bash Prompt
[ "$PS1" = "\\s-\\v\\\$ " ] && PS1="[\u@\h \W]\\$ "

# Aliases
alias ls='ls -F'
alias rekey='/opt/local/bin/keychain id_rsa id_dsa;. ~/.keychain/$HOSTNAME-sh'
alias telnet='telnet -af'
alias scr='screen -x'
alias ls='ls -F'
alias ll='ls -lhF'
alias la='ls -lahF'
alias dl='cd ~/Downloads'
alias desktop='cd ~/Desktop'
alias top='top -F -R -o cpu'
alias docs='cd ~/Documents'
alias g='grep -i'
alias msgs='tail -f /var/log/system.log'
alias ..='cd ..'
alias ...='cd ..; cd ..'
alias profileme="history | awk '{print \$2}' | awk 'BEGIN{FS=\"|\"}{print \$1}' | sort | uniq -c | sort -n | tail -n 20 | sort -nr"

if [ ! -f ~/.dirs ]; then  # if doesn't exist, create it
  touch ~/.dirs
fi

alias show='cat ~/.dirs'
save () {
  command sed "/!$/d" ~/.dirs > ~/.dirs1; \mv ~/.dirs1 ~/.dirs; echo "$@"=\"`pwd`\" >> ~/.dirs; source ~/.dirs ; 
}

source ~/.dirs  # Initialization for the above 'save' facility: source the .sdirs file

# bash completion settings (actually, these are readline settings)
bind "set completion-ignore-case on" # note: bind is used instead of setting these in .inputrc.  This ignores case in bash completion
bind "set bell-style none" # No bell, because it's damn annoying
bind "set show-all-if-ambiguous On" # this allows you to automatically show completion without double tab-ing

ssh () { 
  /usr/bin/ssh $*
  PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}"; echo -ne "\007"'
}

# CD commands
shopt -s cdable_vars
shopt -s cdspell
shopt -s checkwinsize

if [ -f /etc/bash_completion ]; then
  source /etc/bash_completion
fi

# Check for keychain, and run if it exists
case "$KERNEL" in
Darwin)
  if [ -f /opt/local/bin/keychain ]; then
    /opt/local/bin/keychain id_dsa
    source ~/.keychain/`hostname`-sh
  fi
  ;;
Linux)
  if [ -f /opt/local/bin/keychain ]; then
    /opt/local/bin/keychain id_dsa
    source ~/.keychain/`hostname`-sh
  fi
  ;;
*)
  ;;
esac

if [ -e /usr/bin/vim -o -e /opt/csw/bin/vim -o -e /usr/local/bin/vim ]; then
  alias vi='vim'
fi
