" local syntax file - set colors on a per-machine basis:
" Vim color file
" Maintainer:  kamichidu <c.kamunagi@gmail.com>
" Last Change: 20-Apr-2013.

hi clear
set background=dark
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "hydrange"

let s:save_cpo= &cpo
set cpo&vim

" basic
hi Normal guifg=#dddddd guibg=#000000
hi link NonText Normal
" basic groups (:h group-name) {{{
" comment group
hi Comment guifg=#666666 guibg=NONE gui=NONE
" constant group
hi Constant guifg=#ff0000 guibg=NONE gui=NONE
hi default link String Constant
hi Character guifg=#ff5555 guibg=NONE gui=NONE
hi default link Number Constant
hi default link Boolean Constant
hi default link Float Constant
" identifier group {{{
hi Identifier guifg=NONE    guibg=NONE    gui=NONE
hi Function   guifg=NONE    guibg=NONE    gui=NONE
" }}}
" statement group {{{
hi Statement  guifg=NONE    guibg=NONE    gui=NONE
" if, then, else, endif, switch, etc.
hi Conditional  guifg=NONE    guibg=NONE    gui=NONE
" for, do, while, etc.
hi Repeat      guifg=NONE    guibg=NONE    gui=NONE
" case, default, etc.
hi Label       guifg=NONE    guibg=NONE    gui=NONE
" "sizeof", "+", "*", etc.
hi Operator    guifg=NONE    guibg=NONE    gui=NONE
" any other keyword
hi Keyword     guifg=NONE    guibg=NONE    gui=NONE
" try, catch, throw
hi Exception   guifg=NONE    guibg=NONE    gui=NONE
" }}}
" preproc group. e.g.#include {{{
hi PreProc    guifg=NONE guibg=NONE gui=NONE
" preprocessor #include
hi Include    guifg=NONE guibg=NONE gui=NONE
" preprocessor #define
hi Define     guifg=NONE guibg=NONE gui=NONE
" same as Define
hi default link Macro Define
" preprocessor #if, #else, #endif, etc.
hi default link PreCondit PreProc
" }}}
" type group. e.g. int, long, char, etc. {{{
hi Type guifg=#338838 guibg=NONE gui=NONE
" static, register, volatile, etc.
hi default link StorageClass Type
" struct, union, enum, etc.
hi default link Structure Type
" A typedef
hi default link Typedef Type   
" }}}
" special symbol group. {{{
" any special symbol
hi Special guifg=NONE guibg=NONE gui=NONE
" special character in a constant
hi default link SpecialChar Special
" you can use CTRL-] on this
hi default link Tag Special
" character that needs attention
hi default link Delimiter Special
" special things inside a comment
hi default link SpecialComment Special
" debugging statements
hi default link Debug Special
" }}}
" underlined group {{{
" text that stands out, HTML links
hi Underlined guifg=NONE guibg=NONE gui=underline
" }}}
" ignore group. (:h hl-Ignore) {{{
" left blank, hidden  |hl-Ignore|
hi Ignore guifg=NONE guibg=NONE gui=NONE
" }}}
" error group. {{{
" any erroneous construct
hi Error guifg=#ffffff guibg=#ff0000 gui=NONE
" }}}
" todo group {{{
" anything that needs extra attention; mostly the keywords TODO FIXME and XXX
hi Todo guifg=#000000 guibg=#00ffff gui=NONE
" }}}
" }}}

let &cpo=s:save_cpo
" vim: tw=0 ts=4 sw=4 fen foldmethod=marker

