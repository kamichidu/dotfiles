let s:save_cpo= &cpo
set cpo&vim

augroup gyokuro-ft-tsv
    autocmd!
augroup END

let s:undo= []

setlocal list noexpandtab tabstop=12 softtabstop=0
let s:undo+= ['setlocal list< expandtab< tabstop< softtabstop<']

if !exists('b:undo_ftplugin')
    let b:undo_ftplugin= ''
else
    let b:undo_ftplugin.= ' | '
endif
let b:undo_ftplugin.= join(s:undo, ' | ')

let &cpo= s:save_cpo
unlet s:save_cpo
