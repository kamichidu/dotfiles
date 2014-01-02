let s:save_cpo= &cpo
set cpo&vim

if exists('b:undo_ftplugin')
    let b:undo_ftplugin.= '|'
else
    let b:undo_ftplugin= ''
endif

let b:undo_ftplugin.= 'setlocal fenc< ff< equalprg< | delcommand Prove'

setlocal fenc=utf8
setlocal ff=unix
setlocal equalprg=perltidy

if executable('prove')
    command! -buffer Prove !prove -r
endif

let &cpo= s:save_cpo
unlet s:save_cpo
