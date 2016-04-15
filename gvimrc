scriptencoding utf-8
let s:save_cpo= &cpo
set cpo&vim

if filereadable(expand('~/.gvimrc.system'))
    source ~/.gvimrc.system
endif

set guioptions-=m
set guioptions-=T

set guifont=ゆたぽん（コーディング）Backsl:h12

set t_vb=

colorscheme hydrangea

if filereadable(expand('~/.gvimrc.local'))
    source ~/.gvimrc.local
endif

function! s:winpos(dx, dy)
    redir => l:pos
    silent winpos
    redir END

    let l:x= matchstr(l:pos, '\CWindow position: X \zs\d\+\ze, Y \d\+$')
    let l:y= matchstr(l:pos, '\CWindow position: X \d\+, Y \zs\d\+\ze$')

    execute printf('winpos %d %d', l:x + a:dx, l:y + a:dy)
endfunction

nmap <silent><Plug>(increment-columns) :<C-U>let &columns+= 1<CR>
nmap <silent><Plug>(decrement-columns) :<C-U>let &columns-= 1<CR>
nmap <silent><Plug>(increment-lines) :<C-U>let &lines+= 1<CR>
nmap <silent><Plug>(decrement-lines) :<C-U>let &lines-= 1<CR>

nmap <silent><Plug>(left-winpos)  :<C-U>call <SID>winpos(-1,  0)<CR>
nmap <silent><Plug>(right-winpos) :<C-U>call <SID>winpos( 1,  0)<CR>
nmap <silent><Plug>(up-winpos)    :<C-U>call <SID>winpos( 0, -1)<CR>
nmap <silent><Plug>(down-winpos)  :<C-U>call <SID>winpos( 0,  1)<CR>

nmap <silent><Plug>(left-winpos-5)  :<C-U>call <SID>winpos(-5,  0)<CR>
nmap <silent><Plug>(right-winpos-5) :<C-U>call <SID>winpos( 5,  0)<CR>
nmap <silent><Plug>(up-winpos-5)    :<C-U>call <SID>winpos( 0, -5)<CR>
nmap <silent><Plug>(down-winpos-5)  :<C-U>call <SID>winpos( 0,  5)<CR>

nmap <C-Home>     <Plug>(left-winpos)
nmap <C-End>      <Plug>(right-winpos)
nmap <C-PageDown> <Plug>(down-winpos)
nmap <C-PageUp>   <Plug>(up-winpos)

nmap <S-C-Home>     <Plug>(left-winpos-5)
nmap <S-C-End>      <Plug>(right-winpos-5)
nmap <S-C-PageDown> <Plug>(down-winpos-5)
nmap <S-C-PageUp>   <Plug>(up-winpos-5)

nmap <C-Right> <Plug>(increment-columns)
nmap <C-Left>  <Plug>(decrement-columns)
nmap <C-Up>    <Plug>(increment-lines)
nmap <C-Down>  <Plug>(decrement-lines)

" Maximize gvim window
autocmd gyokuro GUIEnter * simalt ~x

let &cpo= s:save_cpo
" vim:ft=vim foldmethod=marker:fen:
