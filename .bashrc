#pretty colors:
PS1="\[\033[01;32m\]moo \W\[\033[00;36m\] "

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

#anaconda:
source /home/samuel/anaconda3/etc/profile.d/conda.sh
export PATH=~/anaconda3/bin:$PATH
export PYTHONPATH=/home/samuel/.local/lib/python3.5/site-packages:$PYTHONPATH.

#save typing:
alias toslurm='ssh samtenka@tig-slurm.csail.mit.edu'
alias vdiff='vim -d'
alias pdfv='qpdfview'
alias py='python3'
