call plug#begin('~/.vim/plugged')
Plug 'nightsense/cosmic_latte'
call plug#end()

colorscheme cosmic_latte
if 6 <= strftime('%H') && strftime('%H') < 18
    set background=dark
else
    set background=dark
endif

set expandtab
set tabstop=4
set shiftwidth=4
set cc=100

set t_Co=256

syntax on
highlight Schwaword     ctermfg=brown         guifg=#af5f00
highlight Typename      ctermfg=darkgreen     guifg=#005f00
highlight Reward        ctermfg=darkmagenta   guifg=#870087
highlight ControlFlow   ctermfg=lightblue     guifg=#afd7ff
highlight SchwaComment  ctermfg=yellow        guifg=#ffff00
