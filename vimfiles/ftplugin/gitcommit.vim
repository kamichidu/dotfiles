if exists('b:undo_ftplugin')
    let b:undo_ftplugin.= '|'
else
    let b:undo_ftplugin= ''
endif
let b:undo_ftplugin.= 'setl spell< spelllang<'

setlocal spell spelllang=en_gb
