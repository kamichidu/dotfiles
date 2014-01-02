let s:save_cpo= &cpo
set cpo&vim

if exists('b:undo_ftplugin')
    let b:undo_ftplugin.= '|'
else
    let b:undo_ftplugin= ''
endif

let b:undo_ftplugin.= 'setlocal comments< commentstring<'

let &l:comments=      ':--'
let &l:commentstring= '--%s'

let &cpo= s:save_cpo
unlet s:save_cpo
