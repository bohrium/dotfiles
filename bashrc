#pretty colors:
PS1="\[\033[01;32m\]thnkr \W\[\033[00;36m\] "

alias ls='ls --color=auto'
LS_COLORS='fi=0;36:di=0;32:*.py=0;35:*.c=0;35:*.h=0;35:*.js=0;35'
export LS_COLORS

#safety against stupidity and typos:
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'

#my favorite editor and multiplexer:
alias vi='vim'
export EDITOR="vim"
alias tmux='tmux -2'

##anaconda:
#source /home/samuel/anaconda3/etc/profile.d/conda.sh
#export PATH=~/anaconda3/bin:$PATH
#export PYTHONPATH=/home/samuel/.local/lib/python3.5/site-packages:$PYTHONPATH.

export PATH=/home/sam/.local/bin:$PATH
#"/path/to//texlive/:$PATH"

#save typing:
alias toslurm='ssh samtenka@tig-slurm.csail.mit.edu'
alias vdiff='vim -d'
alias pdfv='qpdfview'
alias py='python3'

xkbset ma 60 10 10 5 2

alias unloud='pactl -- set-sink-volume 1 100% & exit'
alias loud='pactl -- set-sink-volume 1 125% & exit'
alias vloud='pactl -- set-sink-volume 1 175% & exit'
alias vvloud='pactl -- set-sink-volume 1 250% & exit'
alias unbright='xrandr --output eDP-1 --crtc 0 --brightness 1.0 & xrandr --output DP-1 --crtc 1 --brightness 1.0 & exit'
alias sbright='xrandr --output eDP-1 --crtc 0 --brightness 1.05  & xrandr --output DP-1 --crtc 1 --brightness 1.05  & exit'
alias bright='xrandr --output eDP-1 --crtc 0 --brightness 1.15 & xrandr --output DP-1 --crtc 1 --brightness 1.15 & exit'
alias vbright='xrandr --output eDP-1 --crtc 0 --brightness 1.25 & xrandr --output DP-1 --crtc 1 --brightness 1.25 & exit'

# increase evince cache size for larger zoom:
gsettings set org.gnome.Evince page-cache-size 2014

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/sam/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/sam/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/sam/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/sam/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


export PATH=$PATH:~/Desktop/
export COMPOSE_DOCKER_CLI_BUILD=0

# killall snap-store

