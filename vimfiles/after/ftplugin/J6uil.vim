let s:save_cpo= &cpo
set cpo&vim

let b:undo_ftplugin= exists('b:undo_ftplugin') ? b:undo_ftplugin . ' | ' : ''

setlocal breakindent wrap
let b:undo_ftplugin.= 'setlocal breakindent< wrap<'

nnoremap <buffer><silent> <Leader><Leader> :<C-U>J6uilReconnect<CR>Gzz

let &cpo= s:save_cpo
unlet s:save_cpo
