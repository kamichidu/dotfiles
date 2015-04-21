let b:undo_ftplugin= exists('b:undo_ftplugin') ? b:undo_ftplugin . ' | ' : ''

setlocal tabstop=2 shiftwidth=2 softtabstop=2
let b:undo_ftplugin.= 'setlocal tabstop< shiftwidth< softtabstop<'
