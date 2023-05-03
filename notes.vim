" Vim syntax file
" Maintainer:       samtenka
" Latest Revision:  2022-06

if exists("b:current_syntax")
  finish
endif

"syn keyword moonotesSCTodo containedin=moonotesSCComment contained TODO FIXME XXX NOTE
"syn match   moonotesSCComment "#.*$" contains=moonotesSCTodo

"----------------------------------------------------------------------------/
"  Parsing Names
"----------------------------------------------------------------------------/

" SAM TENKA: color unfilled boxes
syntax match cUnfilled "\[[^x]\]"
syntax match cUnfilled "<[^x]>"
hi cUnfilled ctermfg=Red

" SAM TENKA: color unfilled boxes
syntax match cFilled "\[x\]"
syntax match cFilled "<x>"
hi cFilled ctermfg=DarkGreen

" SAM TENKA: color !(uppercase identifier) as a name
syntax match moonotesLearnerName "![A-Z][A-Z0-9 ]\+ "
syntax match moonotesLearnerName "![A-Z][A-Z0-9 ]\+$"
hi moonotesLearnerName     ctermfg=Magenta

" SAM TENKA: color !(uppercase identifier) as a name
syntax match moonotesUnderscoreType "[^!][A-Z][A-Z][A-Z0-9 ]\+"
syntax match moonotesUnderscoreType "[^!][A-Z][A-Z][A-Z0-9 ]\+"
hi moonotesUnderscoreType ctermfg=Gray

"----------------------------------------------------------------------------/
"  Parsing comments
"----------------------------------------------------------------------------/

" SAM TENKA: four kinds of moonotes comments:
"   todos (bg dark red),
"   docnotes/headings/labels to help skimming (fg brown),
"   commented code (fg dark gray), and
"   ordinary comments to discuss interfaces and annotate implementations (default = fg cyan)

" SAM TENKA: colorize lowercase slash-style comments with (label)colon(text) or beginning with a leftarrow
syn match cCodeComment "//(.*)"
hi cCodeComment ctermfg=DarkGray

" SAM TENKA: colorize lowercase slash-style comments with (label)colon(text) or beginning with a leftarrow
syn match cLabelComment "//[ ]\?[a-z0-9][ a-z0-9-]\+:[ a-z0-9-]*$"
syn match cLabelComment "//[ ]\?<-[ ]\?[a-z0-9].\+$"
syn match cLabelComment "::.\+$"
hi cLabelComment ctermfg=Brown

syn match cHeadingComment "===.*==="
syn match cHeadingComment "\~\~\~.*\~\~\~"
syn match cHeadingComment "---.*---"
hi cHeadingComment ctermfg=Cyan

"" SAM TENKA: highlight commented all-caps words followed by exlam or colon
"syn match cTodo contained "[A-Z]\+\ze\!"
"syn match cTodo contained "[A-Z]\+\ze:"
"highlight link cTodo Todo
"hi Todo ctermfg=DarkRed
""note: Todo bg/fg are flipped!

"----------------------------------------------------------------------------/
"  Setup syntax highlighting
"----------------------------------------------------------------------------/

let b:current_syntax = "celstarcat"

"hi def link moonotesSCTodo          Todo
"hi def link moonotesSCComment       Comment
"hi def link moonotesSCStarBlockCmd  Statement
"hi def link moonotesSCMainKw        Keyword
"hi def link moonotesSCMainInnerKw   Special
"hi def link moonotesSCEllOrbitCmd   Statement
"hi def link moonotesSCHIPNumber     Type
"hi def link moonotesSCString        Constant
"hi def link moonotesSCDescString    PreProc
"hi def link moonotesSCNumber        Constant
"

