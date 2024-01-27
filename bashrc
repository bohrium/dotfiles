#pretty colors:
PS1="\[\033[01;32m\]carbon \W\[\033[00;36m\] "

alias ls='ls --color=auto'
LS_COLORS='fi=0;36:di=0;32:*.py=0;35:*.c=0;35:*.h=0;35:*.js=0;35'
export LS_COLORS

#safety against stupidity and typos:
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'

alias gitch='git commiti & git checkout'

#alias glava='glava --desktop & FOO_PID=$!'

##anaconda:
#source /home/samuel/anaconda3/etc/profile.d/conda.sh
#export PATH=~/anaconda3/bin:$PATH
#export PYTHONPATH=/home/samuel/.local/lib/python3.5/site-packages:$PYTHONPATH.
export PATH=~/.local/kitty.app/bin:$PATH
export PATH=~/.local/kitty.app/bin:$PATH

export PATH=/home/sam/.local/bin:$PATH
#"/path/to//texlive/:$PATH"

#save typing:
alias toslurm='ssh samtenka@tig-slurm.csail.mit.edu'
alias vdiff='vim -d'
alias pdfv='qpdfview'
alias py='python3'

#xkbset ma 60 10 10 5 2

alias unloud='pactl -- set-sink-volume 1 100% & exit'
alias loud='pactl -- set-sink-volume 1 125% & exit'
alias vloud='pactl -- set-sink-volume 1 175% & exit'
alias vvloud='pactl -- set-sink-volume 1 250% & exit'
alias vdark='xrandr --output eDP-1 --crtc 0 --brightness 0.05 & xrandr --output DP-1 --crtc 1 --brightness 0.05 & exit'
alias unbright='xrandr --output eDP-1 --crtc 0 --brightness 1.0 & xrandr --output DP-1 --crtc 1 --brightness 1.0 & exit'
alias sbright='xrandr --output eDP-1 --crtc 0 --brightness 1.05  & xrandr --output DP-1 --crtc 1 --brightness 1.05  & exit'
alias bright='xrandr --output eDP-1 --crtc 0 --brightness 1.15 & xrandr --output DP-1 --crtc 1 --brightness 1.15 & exit'
alias vbright='xrandr --output eDP-1 --crtc 0 --brightness 1.25 & xrandr --output DP-1 --crtc 1 --brightness 1.25 & exit'

# increase evince cache size for larger zoom:
gsettings set org.gnome.Evince page-cache-size 2014

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/sam/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/sam/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/sam/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/sam/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


export PATH=$PATH:~/Desktop/
export COMPOSE_DOCKER_CLI_BUILD=0

# killall snap-store


#my favorite editor and multiplexer:
alias vi='vvv'
export EDITOR="vim"
alias tmux='tmux -2'


DEFAULT_TERM_SOLARIZED_DARK_BG="#002b36"
DEFAULT_TERM_SOLARIZED_LIGHT_BG="#fdf6d3"
VIM_TERM_PAPERCOLOR_DARK_BG="#1c1c1c"
VIM_TERM_PAPERCOLOR_LIGHT_BG="#eeeeee"
term_scheme() {
 local COLOR="$1"
 if [ "$TERM" == "screen-256color" ]; then
# TMUX
  echo -ne "\\ePtmux;\\e\\033]11;$COLOR\\007\\e\\\\"
 else
#  NOT TMUX
  echo -ne "\\033]11;$COLOR\\007"
 fi
}

vvv() {
 term_scheme $VIM_TERM_PAPERCOLOR_DARK_BG
 vim "$@"
 #term_scheme $DEFAULT_TERM_SOLARIZED_LIGHT_BG
}
. "$HOME/.cargo/env"
