" Vim syntax file:
" Maintainer:       samtenka
" Latest Revision:  2023-03-30
" Create:  2023-03-30

if exists("b:current_syntax")
  finish
endif

"----------------------------------------------------------------------------/
"  Parsing Names
"----------------------------------------------------------------------------/

" SAM TENKA: color headers
syntax match mookdownBigHeader "^![^!]\+$"
syntax match mookdownBigHeader "^!![^!]\+$"
syntax match mookdownSmallHeader "^!!![^!]\+$"
syntax match mookdownSmallHeader "^!!!![^!]\+$"

"----------------------------------------------------------------------------/
"  Parsing comments
"----------------------------------------------------------------------------/

" SAM TENKA: colorize python-style comments
syn match cCodeComment "^#.*"
syn match cCodeComment "^<|>"
syn match cCodeComment "^///.*"

hi def link cCodeComment       Comment

syn match cEmphPunct "`\|\*\|%\|\~"
syn match cEmphTele "\(^[^`]*\(`[^`]*`[^`]*\)*`\)\@<=[^`]\+\(`\)\@="
syn match cEmphBold "\(^[^*]*\(\*[^*]*\*[^*]*\)*\*\)\@<=[^*]\+\(\*\)\@="
syn match cEmphItal "\(^[^%]*\(%[^%]*%[^%]*\)*%\)\@<=[^%]\+\(%\)\@="
syn match cEmphStrk "\(^[^~]*\(\~[^~]*\~[^~]*\)*\~\)\@<=[^~]\+\(\~\)\@="

syn match cMathPunct "\$"
syn match cMath "\(^\(<|>\)\?[ ]*\$\$\)\@<=[^$<>]\+\(\$\$$\)\@="
syn match cMath "\(^\$\$\n\)\@<=\([^$<>]\+\n\)*\(\$\$$\)\@="
syn match cMath "\(^[^$]*\(\$[^$]*\$[^$]*\)*\$\)\@<=[^$]\+\(\$\)\@="
" what follows is a (too-slow) experiment in allowing multi-line math
" highlighting:
"syn match cMath "\(\n\([^$]\|\n[^$]\)*\(\$\([^$]\|\n[^$]\)*\$\([^$]\|\n[^$]\)*\)*\$\)\@<=\([^$]\|\n[^$]\)\+\(\$\)\@="

syn match cLinkPunct "\(<[^<|>]\+\)\@<=|\([^<|>]\+>\)\@="
syn match cLinkPunct "<\([^<|>]\+|[^<|>]\+>\)\@="
syn match cLinkPunct "\(<[^<|>]\+|[^<|>]\+\)\@<=>"
syn match cLinkURL "\(<\)\@<=[^<|>]\+\(|[^<|>]\+>\)\@="
syn match cLinkText "\(<[^<|>]\+|\)\@<=[^<|>]\+\(>\)\@="

"----------------------------------------------------------------------------/
"  Parsing comments
"----------------------------------------------------------------------------/

nmap :csdk :set background=dark <cr>:call HiMookdownWordsDark()<cr>
nmap :cslt :set background=light<cr>:call HiMookdownWordsLight()<cr>

set comments+=s:^<
set comments+=m:\|
set comments+=e:>

function HiMookdownWords()
    if &background ==# 'dark'
        call HiMookdownWordsDark()
    else
        call HiMookdownWordsLight()
    endif
endfunction

function HiMookdownWordsLight()
    hi mookdownBigHeader     ctermbg=LightGray ctermfg=Brown cterm=Bold
    hi mookdownSmallHeader   ctermbg=LightGray ctermfg=Brown cterm=Italic
    "
    hi cCodeComment ctermfg=Magenta
    "
    hi cEmphPunct ctermfg=Gray
    hi cEmphItal cterm=Bold
    hi cEmphTele cterm=Underline
    hi cEmphBold ctermfg=DarkCyan cterm=Italic
    hi cEmphStrk ctermfg=Gray
    "
    hi cMath ctermfg=DarkGreen ctermbg=LightGray
    hi cMathPunct ctermfg=Gray cterm=Underline
    "
    hi cLinkPunct cterm=Bold
    hi cLinkURL  ctermfg=Gray
    hi cLinkText ctermfg=DarkBlue cterm=Bold
    "
    autocmd ColorScheme * highlight ExtraWhitespace ctermbg=208
    let g:indentLine_color_term=208
endfunction

function HiMookdownWordsDark()
    hi mookdownBigHeader     ctermfg=Brown cterm=Bold
    hi mookdownSmallHeader   ctermfg=Brown cterm=Italic
    "
    hi cCodeComment ctermfg=DarkMagenta
    "
    hi cEmphPunct ctermfg=DarkGray
    hi cEmphBold cterm=Bold
    hi cEmphTele cterm=Underline
    hi cEmphItal ctermfg=Cyan cterm=Italic
    hi cEmphStrk ctermfg=Gray
    "
    hi cMath ctermfg=LightGreen cterm=Italic
    hi cMathPunct ctermfg=DarkGray
    "
    hi cLinkPunct cterm=Bold
    hi cLinkURL  ctermfg=Gray
    hi cLinkText ctermfg=LightBlue cterm=Bold
    "
    autocmd ColorScheme * highlight ExtraWhitespace ctermbg=16
    let g:indentLine_color_term=237
endfunction


call HiMookdownWords()
syntax sync fromstart
