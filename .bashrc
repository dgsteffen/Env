# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
if [[ $DAVE ]]; then
    echo "By Your Command"
else
    export DAVE=1 ;
fi

export PATH=.:$HOME/bin:$HOME/local/bin:/usr/local/bin:/usr/bin:$PATH ;


export EDITOR=emacs

eval `/usr/bin/dircolors ~/.dir_colors`
export LS_OPTIONS='-F -s -T 0 --color=tty'
source ~/.bash_alias

export TRASH=Desktop/Trash

ulimit -c unlimited


####  Git branch and colors
COLOR_RED="\033[0;31m"
COLOR_YELLOW="\033[0;33m"
COLOR_GREEN="\033[0;32m"
COLOR_OCHRE="\033[38;5;95m"
COLOR_BLUE="\033[0;34m"
COLOR_WHITE="\033[0;37m"
COLOR_RESET="\033[0m"

function git_color {
  local git_status="$(git status 2> /dev/null)"

  if [[ $git_status =~ "Changes not staged for commit" ]]; then
    echo -e $COLOR_RED
  elif [[ $git_status =~ "Changes to be committed" ]]; then
    echo -e $COLOR_YELLOW
  elif [[  $git_status =~ "working directory clean" ]]; then
    echo -e $COLOR_WHITE
  elif [[ $git_status =~ "Your branch is ahead of" ]]; then
      echo -e $COLOR_GREEN
  elif [[ $git_status =~ "but the upstream is gone" ]]; then
      echo -e $COLOR_GREEN
  elif [[ $git_status =~ "Your branch is up to date" ]]; then
      echo -e $COLOR_WHITE
  elif [[ $git_status =~ "nothing added to commit but untracked files present" ]]; then
      echo -e $COLOR_WHITE
  else
    echo -e $COLOR_OCHRE
  fi
}

function git_branch {
  local git_status="$(git status 2> /dev/null)"
  local on_branch="On branch ([^${IFS}]*)"
  local on_commit="HEAD detached at ([^${IFS}]*)"

  if [[ $git_status =~ $on_branch ]]; then
    local branch=${BASH_REMATCH[1]}
    echo "($branch)"
  elif [[ $git_status =~ $on_commit ]]; then
    local commit=${BASH_REMATCH[1]}
    echo "($commit)"
  fi
}


parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/<\1> /'
}
#git branch | grep \* | cut -d ' ' -f2
#git rev-parse --abbrev-ref HEAD

#export PS1="\[\033[1;32m\]\$(parse_git_branch) \w \[\033[1;35m\]:\[\033[0m\] "

export PS1="\[\$(git_color)\]\$(parse_git_branch)\[\033[1;32m\]\w \[\033[1;35m\]:\[\033[0m\] "
export PS2="\[\033[1;35m\]continue :\[\033[0m\] "

xrdb -merge ~/.Xdefaults 

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib:/usr/local/dev/lib64


###  Set up git email depending on hostname

eval $(thefuck --alias 2>/dev/null) 
source ~/.bash_proj


case "$HOSTNAME" in

    dsteffen.centos7 )
        git config --global user.email dsteffen@scitec.com )
        source scl_source enable devtoolset-7 llvm-toolset-7
        ;;

    rhel7-bldr-dsteffen-dev.linux3.bldr.scitec1.local )
	git config --global user.email dsteffen@scitec.com 
        ;;

    * )
	git config --global user.email tkd-physics@comcast.net ;;
esac




#ssh-add ~/.ssh/id_rsa
