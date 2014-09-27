if exists("b:did_ftplugin")
    finish
endif

let s:save_cpo= &cpo
set cpo&vim

let b:undo_ftplugin= get(b:, 'undo_ftplugin', '')

let b:undo_ftplugin.= '| setlocal expandtab< tabstop< shiftwidth< softtabstop<'
setlocal noexpandtab tabstop=20 shiftwidth=20 softtabstop=20

let b:did_ftplugin= 1

let &cpo= s:save_cpo
unlet s:save_cpo
