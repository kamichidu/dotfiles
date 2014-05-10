let s:save_cpo= &cpo
set cpo&vim

if exists('b:undo_ftplugin')
    let b:undo_ftplugin.= '|'
else
    let b:undo_ftplugin= ''
endif

function! s:update_path()
    if !filereadable('.clang_complete')
        return
    endif

    let l:includes= filter(readfile('.clang_complete'), 'v:val =~# ''^-\%(I\|include\)''')
    let l:paths= map(l:includes, 'matchstr(v:val, ''^-\%(I\|include\)\zs\f\+$'')')

    let &l:path= join(['.'] + l:paths, ',')
endfunction

autocmd! CursorHold,CursorHoldI * call s:update_path()

if executable('prove')
    command! -buffer Prove !prove -r
endif

let &cpo= s:save_cpo
unlet s:save_cpo
