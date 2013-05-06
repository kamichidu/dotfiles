" Vim color file -- hydrangea
" Maintainer:   kamichidu <c.kamunagi@gmail.com>
" Last Change:  26-Apr-2013.

set background=dark
hi clear
syn reset
let g:colors_name="hydrangea"

let save_cpo = &cpo
set cpo&vim

" basic highlight groups (:help highlight-groups) {{{
" text {{{
hi Normal       guifg=#ffffff       guibg=#050505       gui=NONE
hi NonText      guifg=#ffffff       guibg=#050505       gui=NONE
hi Folded       guifg=#c2bfa5       guibg=#050505       gui=underline
hi LineNr       guifg=#928c75       guibg=NONE          gui=NONE
hi Directory    guifg=#00bbdd       guibg=NONE          gui=NONE
hi SpecialKey   guifg=#559933       guibg=NONE          gui=NONE
hi SpellBad     guifg=NONE          guibg=NONE          gui=undercurl
hi SpellCap     guifg=NONE          guibg=NONE          gui=undercurl
hi SpellLocal   guifg=NONE          guibg=NONE          gui=undercurl
hi SpellRare    guifg=NONE          guibg=NONE          gui=undercurl
hi DiffAdd      guifg=#ffffff       guibg=#126493       gui=NONE
hi DiffChange   guifg=#000000       guibg=#976398       gui=NONE
hi DiffDelete   guifg=#000000       guibg=#be1923       gui=NONE
hi DiffText     guifg=#ffffff       guibg=#976398       gui=NONE
" }}}
" borders / separators / menus {{{
hi FoldColumn   guifg=#c8bcb9       guibg=#786d65       gui=NONE            
hi SignColumn   guifg=#c8bcb9       guibg=#786d65       gui=NONE
hi Pmenu        guifg=#000000       guibg=#a6a190       gui=NONE
hi PmenuSel     guifg=#ffffff       guibg=#133293       gui=NONE
hi PmenuSbar    guifg=NONE          guibg=#555555       gui=NONE
hi PmenuThumb   guifg=NONE          guibg=#cccccc       gui=NONE
hi StatusLine   guifg=#000000       guibg=#c2bfa5       gui=NONE    
hi StatusLineNC guifg=#444444       guibg=#c2bfa5       gui=NONE    
hi WildMenu     guifg=#ffffff       guibg=#133293       gui=NONE
hi VertSplit    guifg=#c2bfa5       guibg=#c2bfa5       gui=NONE
hi TabLine      guifg=#000000       guibg=#c2bfa5       gui=NONE
hi TabLineFill  guifg=#000000       guibg=#c2bfa5       gui=NONE
hi TabLineSel   guifg=#ffffff       guibg=#133293       gui=NONE
"hi Menu
"hi Scrollbar
"hi Tooltip
" }}}
" cursor / dynamic / other {{{
hi Cursor       guifg=#000000       guibg=#ffff99       gui=NONE
hi link CursorIM Cursor
hi CursorLine   guifg=NONE          guibg=NONE          gui=underline
hi CursorColumn guifg=NONE          guibg=#1b1b1b       gui=NONE
hi Visual       guifg=#ffffff       guibg=#606070       gui=NONE
hi IncSearch    guifg=#000000       guibg=#eedd33       gui=NONE 
hi Search       guifg=#efefd0       guibg=#937340       gui=NONE
hi MatchParen   guifg=NONE          guibg=#3377aa       gui=NONE
"hi VisualNOS
" }}}
" listings / messages {{{
hi ModeMsg      guifg=#eecc18       guibg=NONE          gui=NONE
hi Title        guifg=#dd4452       guibg=NONE          gui=NONE
hi Question     guifg=#66d077       guibg=NONE          gui=NONE
hi MoreMsg      guifg=#39d049       guibg=NONE          gui=NONE
hi ErrorMsg     guifg=#ffffff       guibg=#ff0000       gui=NONE
hi WarningMsg   guifg=#ccae22       guibg=NONE          gui=NONE    
" }}}
" }}}
" syntax highlighting groups (:help group-name) {{{
hi Comment      guifg=#4F4F4F       guibg=NONE          gui=NONE
hi Constant     guifg=#ff6050       guibg=NONE          gui=NONE
hi Boolean      guifg=#ff6050       guibg=NONE          gui=NONE  
hi Identifier   guifg=#eecc44       guibg=NONE          gui=NONE
hi Statement    guifg=#66d077       guibg=NONE          gui=NONE
hi PreProc      guifg=#bb88dd       guibg=NONE          gui=NONE
hi Type         guifg=#4093cc       guibg=NONE          gui=NONE
hi Special      guifg=#9999aa       guibg=NONE          gui=NONE  
hi Underlined   guifg=#80a0ff       guibg=NONE          gui=underline
hi Ignore       guifg=#888888       guibg=NONE          gui=NONE
hi Error        guifg=#ffffff       guibg=#ff0000       gui=NONE
hi Todo         guifg=#ffffff       guibg=#ee7700       gui=NONE
" }}}

let &cpo = save_cpo

" vim: fdm=marker fdl=0

