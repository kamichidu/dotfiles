if &l:buftype ==# 'help'
    nnoremap <silent><buffer><nowait> q :close
else
    " editing help
    let b:undo_ftplugin.= '| setlocal list< listchars< tabstop< shiftwidth< softtabstop< expandtab< textwidth<'
    setlocal list listchars+=tab:^I tabstop=8 shiftwidth=8 softtabstop=8 noexpandtab textwidth=78

    if exists('+colorcolumn')
        let b:undo_ftplugin.= '| setlocal colorcolumn<'
        setlocal colorcolumn=+1
    endif

    if has('conceal')
        let b:undo_ftplugin.= '| setlocal conceallevel<'
        setlocal conceallevel=0
    endif
endif
