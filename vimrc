"   author: sam tenka
"   change: 2023-04-21
"   create: 2018-09-01
"   descrp: Define vim settings for super bovine text editing productivity
"           This document has six parts: PLUGINS --- FILE MANAGEMENT ---
"           COLORS --- COLUMNS & INDENTATION --- META: COMMANDS-&-SETTINGS
"           ABOUT COMMANDS-&-SETTINGS ------ TEXT PER SE.
"
"   jargon: none so far
"
"   thanks: To the vundle maintainers (`github.com/VundleVim`) for their
"           excellent plugin manager.  And, for ideas for and implementations
"           of cool tidbits, to `b80lpi` (reddit.com/r/vim/comments/b8olpi),
"           `422224` (superuser.com/a/422224), and `amix`
"           (github.com/amix/vimrc).
"
"   to use: Place this vim code in `~/.vimrc`.  Feel free to edit this file
"           (especially those parts marked ADD).  Then, when using vim, enjoy
"           the following non-standard commands.  We mark each as available in
"           visual, normal, or insert mode by the letters V, N, I.
"
"        I  C-[xnp]         snippet : `x`(expand), `n`(next), `p`(prev)
"       N   #               search for current selection or word
"       N   \(CC|Cc|cc)     insert /*..*/-style banner comment
"       N   \p(CC|Cc|cc)    insert #-style banner comment
"       N   :cs(dk|lt)      brightness : `dk`(dark), `lt`(light)
"       N   :cs(pc|cl)      color scheme : `pc`(papercolor), `cl`(cosmiclatte)
"       N   <space>         toggle fold view shallow
"       N   C-Arrow         switch windows according to arrow key
"       N   M-HoriArrow     switch tabs according to /horizontal/ arrow key
"       N   \[np]           switch tabs : `n`(next), `p`(previous)
"       N   \fw             remove trailing whitespace in whole file
"       N   \l[lxnp]        lint : `l`(run), `x`(disable), `n`(next), `p`(prev)
"       N   \n[nx]          line number gutter: `n`(set), `x`(unset)
"       N   \s[snp]         spellcheck : `s`(toggle), `n`(next), `p`(prev)
"       N   \sc             open `~/buffer.md` for scribbling
"       N   f(f|d|[|])      fold : `f`(make), `d`(free), `[`(opendeep), `]`(closedeep)
"      V    \ga             align table to character (e.g. \ga= aligns to =)
"      V    \gt             titlecase the selection

"==============================================================================
"=  PLUGINS  ==================================================================
"==============================================================================

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"~~~~~  Load Plugins  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" see :h vundle for more details

filetype off

" add vundle to runtime path; initialize vundle; let vundle manage itself
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
" to add plugins, ADD to this list:
Plugin 'SirVer/ultisnips'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'christoomey/vim-titlecase'
Plugin 'honza/vim-snippets'
Plugin 'junegunn/vim-easy-align'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'valloric/YouCompleteMe'
Plugin 'w0rp/ale'
Plugin 'yggdroot/indentline'
call vundle#end()
filetype plugin indent on


"-------  multiline search  ---------------------------------------------------
"thanks to unix.stackexchange.com/questions/7617
function! SearchMultiLine(bang, ...)
  if a:0 > 0
    let sep = (a:bang) ? '\_W\+' : '\_s\+'
    let @/ = join(a:000, sep)
  endif
endfunction
command! -bang -nargs=* -complete=tag S call SearchMultiLine(<bang>0, <f-args>)|normal! /<C-R>/<CR>

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"~~~~~  Customize Plugins  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" snippets (honza/vim-snippets, SirVer/ultisnips)
let g:UltiSnipsExpandTrigger       = "<C-x>"
let g:UltiSnipsJumpForwardTrigger  = "<C-n>"
let g:UltiSnipsJumpBackwardTrigger = "<C-p>"

" trailing whitespace (bronson/vim-trailing-whitespace)
nmap <leader>fw :FixWhitespace<CR>

" titlecase (christoomey/vim-titlecase)
let g:titlecase_map_keys = 0
vmap <leader>gt <Plug>Titlecase

" autocomplete (valloric/youcompleteme)
let g:ycm_enable_diagnostic_signs = 0

" aligned tables (junegunn/vim-easy-align)
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" linting (w0rp/ale)
let g:ale_sign_error = '>'
let g:ale_sign_warning = '-'
let g:ale_set_highlights = 0
highlight clear ALEErrorSign
highlight clear ALEWarningSign
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 0
nmap <leader>ll :ALELint<CR>
nmap <leader>lx :ALEDisable<CR>
nmap <leader>ln :ALENext<CR>
nmap <leader>lp :ALEPrevious<CR>

"       " mark indentation (yggdroot/indentline)
"       let g:indentLine_color_term = 233
"       let g:indentLine_color_tty_light = 208
"       let g:indentLine_color_tty_dark  = 237
"       " don't mess up latex:
let g:indentLine_fileTypeExclude = ['tex', 'markdown', 'md']
au Filetype tex setlocal conceallevel=0
au Filetype markdown setlocal conceallevel=0
au Filetype md setlocal conceallevel=0
"autocmd Filetype markdown let g=0

"==============================================================================
"=  FILE MANAGEMENT  ==========================================================
"==============================================================================

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"~~~~~  Autofiles for Scribbling  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" THX amix
map <leader>sc :e ~/buffer.md<cr>

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"~~~~~  Single-Chord Window and Tab Navigation  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" switch windows
map <c-Up>      <c-W><Up>
map <c-Down>    <c-W><Down>
map <c-Left>    <c-W><Left>
map <c-Right>   <c-W><Right>

" switch tabs
nmap <M-Left> :prev<cr>
nmap <M-Right> :next<cr>
""" nmap <leader>p :prev<cr>
""" nmap <leader>n :next<cr>

"==============================================================================
"=  COLORING  =================================================================
"==============================================================================

set t_Co=256
syntax on

""" highlight Schwaword     ctermfg=brown
""" highlight Typename      ctermfg=darkgreen
""" highlight Reward        ctermfg=darkmagenta
""" highlight ControlFlow   ctermfg=lightblue
""" highlight SchwaComment  ctermfg=yellow

" associate filename patterns with syntax files `.vim/syntax/foo.vim`
au BufRead,BufNewFile *.stc       set filetype=cel
au BufRead,BufNewFile notes.*     set filetype=notes
au BufRead,BufNewFile *.hoof      set filetype=hoof
au BufRead,BufNewFile *.mookdown  set filetype=mookdown
au BufRead,BufNewFile *.grammar   set filetype=grammar
au BufRead,BufNewFile *.lexspec   set filetype=grammar
au BufRead,BufNewFile *.c         set filetype=cpp
au BufRead,BufNewFile *.bcc       set filetype=cpp

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"~~~~~  Colorscheme  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

call plug#begin('~/.vim/plugged')
Plug 'nightsense/cosmic_latte'
call plug#end()

colorscheme PaperColor
""" colorscheme cosmic_latte

nmap :cscl :colorscheme cosmic_latte<cr>:call HiAttnWords()<cr>
nmap :cspc :colorscheme PaperColor<cr>:call HiAttnWords()<cr>
nmap :csdk :set background=dark <cr>:call HiAttnWordsDark()<cr>
nmap :cslt :set background=light<cr>:call HiAttnWordsLight()<cr>

let MORNING=6
let EVENING=20

if MORNING <= strftime('%H') && strftime('%H') < EVENING
    set background=light
else
    set background=dark
endif

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"~~~~~  Highlight Reader-Attention Words  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" C special
augroup cspecial autocmd!
    " note : (---  ^[^"]*("[^"]*"[^"]*)*  ---) matches even number of "s from
    " start of line, ensuring we are not inside string (except for escapes,
    " which we are too lazy to reason about) ... We also are too lazy to
    " handle when something immediately follows a string literal with no space
    " in between.
    "
    " c type, e.g. IAmACow or int32_t
    autocmd Syntax cpp call matchadd('Type',      '\v(^|^[^"]*("[^"]*"[^"]*)*(^|[^"_A-Za-z0-9]|([^"]*"[^"]*")+))@<=[A-Z]+[a-zA-Z]*[A-Z][a-z]+($|[^_A-Za-z0-9])@=')
    autocmd Syntax cpp call matchadd('Type',      '\v(^|^[^"]*("[^"]*"[^"]*)*(^|[^"_A-Za-z0-9]|([^"]*"[^"]*")+))@<=[a-z]+[_a-z0-9]*_t($|[^_A-Za-z0-9])@=')
    "
    autocmd Syntax cpp call matchadd('CommType',  '\v(^[^"]*("[^"]*"[^"]*)*//.*(|[^_A-Za-z0-9]))@<=[A-Z]+[a-zA-Z]*[A-Z][a-z]+($|[^_A-Za-z0-9])@=')
    autocmd Syntax cpp call matchadd('CommType',  '\v(^[^"]*("[^"]*"[^"]*)*//.*(|[^_A-Za-z0-9]))@<=[a-z]+[_a-z0-9]*_t($|[^_A-Za-z0-9])@=')
    "
    " c macro, e.g. _CPUT or __MATCH
    autocmd Syntax cpp call matchadd('CSamMacro', '\v(^|^[^"]*("[^"]*"[^"]*)*(^|[^"_A-Za-z0-9]|([^"]*"[^"]*")+))@<=[A-Z]+[_A-Z]+[A-Z]+($|[^_A-Za-z0-9])@=')
    autocmd Syntax cpp call matchadd('CSamMacro', '\v(^|^[^"]*("[^"]*"[^"]*)*(^|[^"_A-Za-z0-9]|([^"]*"[^"]*")+))@<=__[A-Z]+[_A-Z]+[A-Z]+($|[^_A-Za-z0-9])@=')
    " c macro flank underscored, e.g. _W_
    autocmd Syntax cpp call matchadd('CMacScore', '\v(^|^[^"]*("[^"]*"[^"]*)*(^|[^"_A-Za-z0-9]|([^"]*"[^"]*")+))@<=_[A-Z]*[_A-Z]+[A-Z]*_($|[^_A-Za-z0-9])@=')
    "
    autocmd Syntax cpp call matchadd('CommMacro', '\v(^[^"]*("[^"]*"[^"]*)*//.*(|[^_A-Za-z0-9]))@<=[A-Z]+[_A-Z]+[A-Z]+($|[^_A-Za-z0-9])@=')
    autocmd Syntax cpp call matchadd('CommMacro', '\v(^[^"]*("[^"]*"[^"]*)*//.*(|[^_A-Za-z0-9]))@<=__[A-Z]+[_A-Z]+[A-Z]+($|[^_A-Za-z0-9])@=')
    autocmd Syntax cpp call matchadd('CommMacro', '\v(^[^"]*("[^"]*"[^"]*)*//.*(|[^_A-Za-z0-9]))@<=_[A-Z]*[_A-Z]+[A-Z]*_($|[^_A-Za-z0-9])@=')
augroup END

" glaring words (THX b80lpi)
augroup todo autocmd!
    autocmd Syntax * call matchadd('Todo', '\v\W\zs<(TODO|FILLIN|FIXME|ADD|SECTION)>')
augroup END

" non-glaring words
augroup note autocmd!
    autocmd Syntax * call matchadd('Note', '\v\W\zs<(NOTE|ATTN|PRE|POST|THX)>')
    autocmd Syntax * call matchadd('Note', '\v\W\zs<(for #[A-Z]+)>')
augroup END

" backtick literals "with no whitespace or escapes in them
" NOTE: ACTUALLY we allow whitespace
augroup btstring autocmd!
    "autocmd Syntax * call matchadd('BtString', '\(`\)\@<=[^` ]\+\(`\)\@=')
    "autocmd Syntax * call matchadd('BtString', '\(`\)\@<=[^`]\+\(`\)\@=')
    autocmd Syntax (*.hoof)@<! call matchadd('BtString', '\(^[^`]*\(`[^`]*`[^`]*\)*`\)\@<=[^`]\+\(`\)\@=')
augroup END

" exclam-caps
augroup exclamcapsstring autocmd!
    autocmd Syntax * call matchadd('ExclamCapsString', '![-a-z_A-Z][-a-z_A-Z]\+')
    autocmd Syntax * call matchadd('ExclamCapsString', ' _[-a-z_A-Z][-a-z_A-Z]\+_')
augroup END



function HiAttnWords()
    if &background ==# 'dark'
        call HiAttnWordsDark()
    else
        call HiAttnWordsLight()
    endif
endfunction

function HiAttnWordsLight()
    highlight CommType               ctermfg=darkblue cterm=bold
    highlight CommMacro              ctermfg=darkblue cterm=bold
    highlight CSamMacro              ctermfg=102 cterm=bold
    highlight CMacScore            ctermfg=145
    "
    highlight BtString  ctermfg=8   cterm=underline
    highlight ExclamCapsString ctermfg=28  cterm=italic
    highlight Comment   ctermfg=31
    highlight Note      ctermfg=31  cterm=bold
    highlight Todo      ctermfg=172 cterm=bold
    "
    autocmd ColorScheme * highlight ExtraWhitespace ctermbg=208
    "       let g:indentLine_color_term=208
endfunction

function HiAttnWordsDark()
    highlight CommType               ctermfg=darkblue cterm=bold
    highlight CommMacro              ctermfg=darkblue cterm=bold
    highlight CSamMacro              ctermfg=102 cterm=bold
    highlight CMacScore            ctermfg=145
    "
    highlight BtString  ctermfg=8   cterm=underline
    highlight ExclamCapsString ctermfg=28  cterm=italic
    highlight Comment   ctermfg=31
    highlight Note      ctermfg=31  cterm=bold
    highlight Todo      ctermfg=172 cterm=bold
    "
    autocmd ColorScheme * highlight ExtraWhitespace ctermbg=16
    "       let g:indentLine_color_term=237
    " TODO: call indent plugin's script-local InitColor to reset:
    " https://vi.stackexchange.com/questions/17866/are-script-local-functions-sfuncname-unit-testable
    "let MyFuncref = function("<SNR>" . 42 . "_InitColor")
    "call(MyFuncref, [])
endfunction



call HiAttnWords()



"==============================================================================
"=  COLUMNS  &  INDENTATION  ==================================================
"==============================================================================

set expandtab
set tabstop=4
set shiftwidth=4
set cc=80

" no autoindent, please
set noai nocin nosi inde=

" no autoindent, I MOST FERVENTLY INSIST!
set indentexpr=

" make `gq` respect latex blocks (THX 422224)
let &flp = '\(.*\\\(begin\|end\|item\|footnote\)\>\|.*%.*\)'
set formatoptions+=n2

"==============================================================================
"=  META: COMMANDS-&-SETTINGS ABOUT COMMANDS-&-SETTINGS  ======================
"==============================================================================

" show whether `<leader>` is activated
set showcmd

" visual instead of audio bell
set visualbell

" number of lines of history to remember
set history=500

"==============================================================================
"=  TEXT PER SE  ==============================================================
"==============================================================================

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"~~~~~  Spellcheck  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" toggle spell checking
map <leader>ss :setlocal spell!<cr>
" navigate through spell check errors:
map <leader>sn ]s
map <leader>sp [s

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"~~~~~  Intra-Text Search and Navigation  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" `#` searches for current word or selection (THX amix)
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" during vertical scroll, cursor is at least this many lines from screen edge:
set so=4

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"~~~~~  Line Numbers  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

nmap <leader>nn :set number<cr>
nmap <leader>nx :set nonumber<cr>

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"~~~~~  Folding  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" manual rather than syntax-based or indent-based folding
set foldmethod=manual

" `ff` creates fold for current paragraph (in N mode) or selection (V mode)
nmap ff { zf}
vmap ff zf

" `fd` destroys fold (without modifying text)
nmap fd zd

" `f[` or `f]` opens or closes fold view (deeply)
nmap f[ zR
nmap f] zM

" `<space>` toggles fold view (shallowly)
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"~~~~~  Abbreviations  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

ab samt         samuel tenka
ab atmit        samtenka@mit.edu
ab atumich      samtenka@umich.edu

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"~~~~~  Comment Banners  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

"nmap ST_equals_ i========================================<esc>
"nmap ST_tildes_ i~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~<esc>
"nmap ST_dashes_ i----------------------------------------<esc>
"
"nmap ST__equals__ ST_equals_ST_equals_i<backspace><backspace><backspace><esc>
"nmap ST__tildes__ ST_tildes_ST_tildes_i<backspace><backspace><backspace><esc>
"nmap ST__dashes__ ST_dashes_ST_dashes_i<backspace><backspace><backspace><esc>

" new structure
"
nmap <leader>cst wbde
                \itypedef struct <esc>pA {<cr>
                \TODO;<cr>
                \} <esc>pA;<esc>?TODO<cr>R

" new switch statement
"
nmap <leader>csw wbde
                \iswitch ( <esc>pA ) {<cr>
                \break; case TODO:<cr>
                \break; default:<cr>
                \}<esc>?TODO<cr>R


" init C file
"
"
nmap <leader>ccc <esc><leader>chh
                \<esc><leader>cmm
                \<esc><leader>cFF
                \<esc><leader>caa
"
nmap <leader>hhh <esc><leader>chh
                \j:r! echo %:t<cr>
                \0V$U
                \/\.<cr>D
                \<esc>h<leader>hGG
                \<esc>j<leader>cFF
                \ddkki//TODO
                \<esc><leader>caa

" add function declaration
"
nmap <leader>cFF mz{i<cr>FUNCTION DECLARATIONS<cr><cr><esc>kk0i// <esc>`z
nmap <leader>cff mz[[k0v$y?FUNCTION DECLARATIONS<cr>}pA;<esc>`z

" prepend an "about" comment
"
nmap <leader>caa ggO
                \/* author: samtenka<cr>
                \change: <esc>:pu=strftime('%Y-%m-%d')<cr>i<bs><esc>$A<cr>
                \create: <esc>:pu=strftime('%Y-%m-%d')<cr>i<bs><esc>$A<cr>
                \descrp: TODO<cr>
                \to use: TODO<cr>
                \/<cr><cr><esc>?descrp:<cr>/TODO<cr>R
nmap <leader>cdd mzgg$/change<cr>wwD:pu=strftime('%Y-%m-%d')<cr>i<bs><esc>`z

" insert main
"
nmap <leader>cmm o
                \int main(int argc, char const* const argv)<cr>
                \{<cr>
                \TODO;<cr>
                \return 0;<cr>
                \}
                \<esc>
                \?TODO<cr>R

nmap <leader>chh ggO
                \#include <assert.h><cr>
                \#include <stdbool.h><cr>
                \#include <string.h><cr>
                \#include <stdio.h><cr>
                \#include <stdlib.h><cr>
                \#include <inttypes.h><cr>
                \#include <time.h><cr>
                \<cr><esc>

"   Type \hgg or \hGG in visual mode.  \hgg is light-weight and usually works;
"   \hGG goes through hoops to get around auto-adding of comment symbols when
"   opening new lines from a line with a comment.
"
"   The cursor should be on or after guard name:
"
"                0---------------$
"                    MOO   Mitten
"           good:    ^^^^^^
"           bad:  ^^^      ^^^^^^
"
"   yields
"           #ifndef MOO_H
"           #define MOO_H
"
"           <2 blank lines, then code, then 2 blank lines>
"
"           #endif//MOO_H
"
"   and destructively sets mark `z`
"
" Implementation:
"
"   The mapping's 10 lines do:
"
"         0 "set mark"                   mz
"         1 "append _H to guard name"    wbei <esc>dlpi_H<esc>ldl
"         2 "cut guard name"             bde
"         3 "insert #ifndef"             ggO<esc>0i#ifndef <esc>p
"         4 "insert #define"             o<esc>0i#define <esc>po<esc>0i<cr><esc>
"         5 "insert #endif"              Go<esc>0i<cr><cr>#endif//<esc>p
"         6 "remove cruff after #ifndef" ggeei <esc>dlpv$hd
"         7 "remove cruff after #define" j0eei <esc>dlpv$hd
"         8 "remove cruff after #endif"  G0eeei <esc>dlpv$hd
"         9 "goto mark"                  `z
"
"   Most of the time there is no cruff to remove, but if before our command
"   there happened to be comments at the very beginning or end of file then
"   our line openers `O`, `o` could auto-continue that comment; it's for this
"   reason that we use `<esc>0i` in our 3 "insert" lines (twice in one of
"   them) and that we have those 3 "remove" lines.
"
"   Also, the fragment `i <esc>dlp` occurs in our "append" lie and our "remove"
"   lines.  This fragment inserts a space after our cursor (and moves our
"   cursor to that space), even if our cursor was previously right-most in the
"   line.  That extra space is then deleted by `ldl` or as part of `v$hd`.
"
nmap <leader>hGG mz
                \wbei <esc>dlpi_H<esc>ldl
                \bde
                \ggO<esc>0i#ifndef <esc>p
                \o<esc>0i#define <esc>po<esc>0i<cr><esc>
                \Go<esc>0i<cr><cr>#endif//<esc>p
                \ggeei <esc>dlpv$hd
                \j0eei <esc>dlpv$hd
                \G0eeei <esc>dlpv$hd
                \`z
nmap <leader>hgg mz
                \wbei <esc>dlpi_H<esc>ldl
                \bde
                \ggO#ifndef <esc>p
                \o#define <esc>po<cr><esc>
                \Go<cr><cr>#endif//<esc>p
                \`z



" length-79 comment banners (C):
nmap <leader>CC O/* ========================================================================= */<cr>
\/* =  _  =================================================================== */<cr>
\/* ========================================================================= */<cr><esc>?_<cr>R
nmap <leader>Cc O/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */<cr>
\/* ~  _  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */<cr><esc>?_<cr>R
nmap <leader>cc O/* -----  _  --------------------------------------------------------------- */<esc>?_<cr>R

" length-79 comment banners (LaTeX, Bash)
nmap <leader>tCC O% =============================================================================<cr>
\% ==  _  ======================================================================<cr>
\% =============================================================================<cr><esc>?_<cr>R
nmap <leader>tCc O% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~<cr>
\% ~~  _  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~<cr><esc>?_<cr>R
nmap <leader>tcc O%-------  _  ------------------------------------------------------------------<esc>?_<cr>R

" length-79 comment banners (Haskell, Hoof)
nmap <leader>hCC O--=============================================================================<cr>
\--==  _  ======================================================================<cr>
\--=============================================================================<cr><esc>?_<cr>R
nmap <leader>hCc O--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~<cr>
\--~~  _  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~<cr><esc>?_<cr>R
nmap <leader>hcc O--------  _  ------------------------------------------------------------------<esc>?_<cr>R




" length-79 comment banners (Python):
nmap <leader>pCC O#==============================================================================<cr>
\#===  _  ======================================================================<cr>
\#==============================================================================<cr><esc>?_<cr>R
nmap <leader>pCc O#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~<cr>
\#~~~  _  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~<cr><esc>?_<cr>R
nmap <leader>pcc O#-------  _  ------------------------------------------------------------------<esc>?_<cr>R





nmap <leader>signature o<cr><cr><esc>0i
\             ____                               ___________________          .<cr><esc>0i
\            /    \                                       l                   .<cr><esc>0i
\           /      \                                      l                   .<cr><esc>0i
\          (                                              l                   .<cr><esc>0i
\           \                                             l                   .<cr><esc>0i
\            \            ___        _     _              l                   .<cr><esc>0i
\             \___       /   \    l / \   / \             l                   .<cr><esc>0i
\                 \     /     l  /l/   \ /   \            l                   .<cr><esc>0i
\                  \      ____l   l     V     l           l                   .<cr><esc>0i
\                   \    /    l   l           l           l                   .<cr><esc>0i
\                    )  /     l   l           l           l                   .<cr><esc>0i
\           \       /  (      l   l           l           l                   .<cr><esc>0i
\            \_____/    \____/ \  l           l           l   (O)             .<cr><esc>0i
\                                                                             .<esc>v{:s/l/<bar>/g<cr>i}<backspace><esc>





"==============================================================================
"=  COMMANDS SYNPOSIS  ========================================================
"==============================================================================

"  https://www.worldtimzone.com/res/vi.html

" In what follows, the backtick, square brackets, and pipe are special.  Each
" non-empty all-caps substring wrapped by backticks is to be substituted by
" a special substring, whether the latter be a modifier character
" (control(`CTL`), meta/alt(`ALT`), escape(`ESC`), delete(`DEL`),
" backspace(`BCK`), enter(`NEW`)) or some user-specified choice (e.g. file
" name(`FILENM`), shell command(`COMMAND`), line number(`LN`), vim search
" pattern(`PATTERN`)).  We press characters written after `CTL` or `ALT` at
" the same time as that modifier character.  We pretend that we can produce
" each uppercase character by pressing some single logical key dedicated to
" that uppercase character rather than by using (`shift` or `capslock`) ---
" this logical key's correspondence to multiple physical keys is a hardware
" rather than a software concern.



"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"~~~~~  Minimal Knowledge  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



"--  lesson 0.0 on "modes"  ---------------------------------------------------

" Fire up vim by running `vim` in a command line while also keeping this
" tutorial open elsewhere for reference.  Press these 9 keys in sequence
" (colon, e, space, h, a, l, l, o, enter):
"
"   :e hallo`NEW`
"
" Now press this single key (i):
"
"   i
"
" Now press these 17 keys (h, e, l, l, o, colon, space, g, o, o, d, space,
" w, o, r, l, l, d):
"
"   hello: good worlld
"
" Oops!  We misspelled /world/.  Fix this by pressing these 2 keys (left-arrow,
" backspace):
"
"   `LEFT``BCK`
"
" Now press this single key (escape):
"
"   `ESC`
"
" Now press these 3 keys (colon, x, enter):
"
"   :x`NEW`
"
" Here we learned about "modes".  We started --- as we always do --- in
" "normal" mode.  Normal mode parses commands such as `:e` (for editing a
" specified file) and `:x` (for closing a file we are editing).  The example
" above used both those commands as bookends around an actual editing session.
" In this case, our editing session just consisted of writing some text into
" the file.
"
" To write text to our file, we'd like to literally translates keystrokes into
" file-insertions.  Normal mode interprets characters such as `:` literally,
" so it won't do.   We instead switch to "insert" mode.  We used `i` and ``ESC``
" to switch from normal to insert mode and back.  In insert mode, we simply
" type the text we want to add.
"
" Here, in summary, are what the above six keysequences do:
"
"   :e hallo`NEW`       -- open `hallo` for editing, creating it if needed
"   i                   -- switch from normal to insert mode
"   hello: good worlld  -- insert this salutation to the current file
"   `LEFT``BCK`         -- delete letter before previous letter
"   `ESC`               -- switch from insert to normal mode
"   :x`NEW`             -- close current file, saving it if needed
"
" That's nice.  You might now wonder why we have any mode besides insert mode.
" Is normal mode more than just cumbersome scaffolding?  The next paragraph
" offers a glimpse into the point of non-insert modes.



"--  lesson 0.1 on "commands"  ------------------------------------------------

" Let's continue editing that file.  Use `vim` to open the file `hallo`.  You
" can do this by using `:e` as described above OR by providing `vim` with
" `hallo` as a command line argument.  Now press these 5 keys (w, w, v,
" dollar, U):
"
"   wwv$U
"
" Now press these 5 keys (0, v, w, y, P):
"
"   0vwyP
"
" Now close-and-save the file by using `:x` as described above.
"
" Here we met some `commands` available in non-insert modes.  The first
" command, `wwv$U`, literally translates to
"
"  `w` -- jump to the next word (counting punctation as a delimiter)
"  `w` -- jump to the next word (counting punctation as a delimiter)
"  `v` -- start selecting text (technically, we go to visual selection mode)
"  `$` -- jump to the line's end
"  `U` -- make the selection entirely uppercase
"
" When we jump within "visual selection" mode, our selection will expand with
" the jump.  Thus
"
"   hallo: good world
"
" becomes
"
"   hallo: GOOD WORLD
"
" The second command, `0vwyP`, translates to
"
"  `0` -- jump to the line's start
"  `v` -- start selecting text (technically, we go to visual selection mode)
"  `w` -- jump to the next word (counting punctuation as a delimiter)
"  `y` -- yank (copy) the selection and return to normal mode
"  `P` -- paste (whatever is yanked (copied)) to place before cursor
"
" Thus
"   hallo: GOOD WORLD
" becomes
"   hallo:hallo: GOOD WORLD
"
" The two commands share structure: the prefixes `wwv$` and `0vw` prepare an
" object --- a region of text --- on which we act.  The suffixes `U` and `yP`
" specify the action.  That the two commands each have a verb and an object is
" typical of vim.  We will encounter grammatical forms that go verb-object
" instead of object-verb as well.  That commands can operate on structures
" more meaningful than mere characters --- words, parenthesized expressions,
" lines, paragraphs, code blocks --- is one reason why they are so useful
" and why we therefore want modes beyond insert mode.



"--  lesson 0.2 summarizing how to use-but-not-utilize vim  -------------------

" The left column, a subsequence of "NVI -> NVI", indicates which modes the
" command is valid in and which modes the command moves us to.  For example,
" "VI -> N" means the command works in both visual or insert mode and that
" after the command runs we are in normal mode.  An empty target means that
" we stay in the same mode.  The following spec DOES NOT show the full power
" of commands such as `y`.
"
" "Commands" in "normal" and "visual" modes:
"
"   N   ->     |  :e `FILENM`     edit (create if necessary)
"   N   ->     |  :x              exit (save if necessary)
"
"   N   ->     |  P               paste whatever's yanked to place before cursor
"
"    V  -> N   |  d               delete-after-yanking selection
"    V  -> N   |  y               yank selection
"    V  ->     |  U               uppercase-ify selection
"    V  ->     |  u               lowercase-ify selection
"
" "Text insertion" in "insert" mode:
"
"     I ->     |  `PRINTABLE`     insert the specified printable char
"     I ->     |  `WHITESPACE`    insert the specified whitespace char
"
"     I ->     |  `DEL`           delete at cursor, which is then at next char
"     I ->     |  `BCK`           delete before the cursor
"
" "Navigation" in multiple modes:
"
"   NVI ->     |  `LEFT`          move cursor left
"   NVI ->     |  `RIGHT`         move cursor right
"   NVI ->     |  `UP`            move cursor up
"   NVI ->     |  `DOWN`          move cursor down
"
"   NV  ->     |  w               jump to next word's start; punctuation delimits
"   NV  ->     |  0               jump to line's start
"   NV  ->     |  $               jump to line's end
"
" "Switch" modes:
"
"   N   ->   I |  i               to insert mode
"    VI -> N   |  `ESC`           to normal mode (slight pause if visual->normal)
"   N   ->  V  |  v               to visual mode

" For some semblance of completeness, we have also included commands `u` (for
" lower-casing), `d` (for deleting-after-yanking), `DEL` (for deletion of the
" char after the cursor), and all four arrow keys.



"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"~~~~~  Basic Knowledge  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

"--  lesson 1.0 on verb-object form  ------------------------------------------

" "cut-paste"
"
"   [y|yy]          yank (double means do it to line)
"   [d|dd]          delete (double means do it to line)
"   [p|P]           paste after(`p`) or before (`P`) cursor
"
"   >               indent
"   <               unindent
"
" "case"
"
"   [u|U]           set case to lower(`u`) or upper(`U`)
"   ~               toggle case
"
" "history"
"
"   u               undo most recent command
"   `CTL`r          redo an undone command
"   .               repeat most recent command (do-verb-to-object) in N mode

" and useful vocabulary: useful verbs and objects

"--  lesson 1.1 listing useful object-specifying motions  ---------------------


"--  lesson 1.2 on working with modes  ----------------------------------------


"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"~~~~~  Basics  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

"
"   :e `FILENM`     edit
"   :w              save
"   :q              exit
"   :x              after saving-if-modified, exit
"   :sav `FILENM`   save-as
"
"   :!`COMMAND`     execute bash command
"   !!`COMMAND`     execute bash command and append output to file
"
" The following all go from normal mode to a different mode:
"
"   [o|O]           insert mode at new line after(`o`) or before(`O`) cursor
"   `CTL`R          replace mode
"   `CTL`v          visual (columnar aka block) mode
"   i               insert mode
"   v               visual (linear) mode
"
" To go from a non-normal mode back to normal mode, simply escape:
"
"   `ESC`           normal mode

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"~~~~~  Verb-Object Commands  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

"   >               indent
"   <               unindent
"   [y|yy]          yank (double means do it to line)
"   [d|dd]          delete (double means do it to line)
"   [p|P]           paste after(`p`) or before (`P`) cursor
"
"   [u|U]           set case to lower(`u`) or upper(`U`)
"   ~               toggle case
"
"   u               undo most recent command (among commands not undone)
"   `CTL`r          redo an undone command
"   .               repeat most recent command (do-verb-to-object) in N mode

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"~~~~~  Intra-text Navigation  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

"   [b|B]           back to word start (lowercase: delimit at punctuation)
"   [e|E]           on   to word end   (lowercase: delimit at punctuation)
"   [w|W]           on   to word start (lowercase: delimit at punctuation)
"
"   0               line start
"   $               line end
"
"   {               paragraph start
"   }               paragraph end
"
"   H               screenful start
"   M               screenful middle
"   L               screenful end
"
"   gg              file start
"   G               file end
"
"   :`LN`           go to the indicated line number
"   `LN`G           go to the indicated line number
"
"   m`LETTER`       mark this position with the given letter
"   ``LETTER`       go to position marked with the given letter
"   ``              go back after marking operation

"   /`PATTERN`      search onward for pattern
"   /               search onward for last-searched pattern
"   ?               search back   for last-searched pattern

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
"~~~~~  Inter-text Navigation: Tabs, Windows, File Tree  ~~~~~~~~~~~~~~~~~~~~~~


"au FileType tex hi clear texStyleItal
"au FileType tex hi clear texStyleBold

au FileType tex set indentkeys-={
au FileType tex set indentkeys-=}
au FileType tex set indentkeys-=0{
au FileType tex set indentkeys-=0}

"let g:ycm_server_keep_logfiles = 1
"let g:ycm_server_log_level = 'debug'

