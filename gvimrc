scriptencoding utf-8
let s:save_cpo= &cpo
set cpo&vim

if filereadable(expand('~/.gvimrc.system'))
    source ~/.gvimrc.system
endif

set guioptions-=m
set guioptions-=T

colorscheme hydrangea

if filereadable(expand('~/.gvimrc.local'))
    source ~/.gvimrc.local
endif

let &cpo= s:save_cpo
" vim:ft=vim foldmethod=marker:fen:

