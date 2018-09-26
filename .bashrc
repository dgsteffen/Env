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
    export PATH=.:$HOME/bin:/usr/local/dev/bin:$PATH ;
fi

export EDITOR=emacs

eval `/usr/bin/dircolors ~/.dir_colors`
export LS_OPTIONS='-F -s -T 0 --color=tty'
source ~/.bash_alias

export TRASH=Desktop/Trash

ulimit -c unlimited

export PS1="\[\033[1;32m\]\w \[\033[1;35m\]:\[\033[0m\] "
export PS2="\[\033[1;35m\]continue :\[\033[0m\] "

xrdb -merge ~/.Xdefaults 

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib:/usr/local/dev/lib64


###  Set up git email depending on hostname

case "$HOSTNAME" in
    rhel7-bldr-dsteffen-dev.linux3.bldr.scitec1.local )
	git config --global user.email dsteffen@scitec.com ;;
    * )
	git config --global user.email tkd-physics@comcast.net ;;
esac

#ssh-add ~/.ssh/id_rsa
