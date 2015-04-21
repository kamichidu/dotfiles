if fnamemodify(finddir('.git', './;'), ':p') =~# '\<rukkit\>'
    setlocal tabstop=2 shiftwidth=2
    let b:undo_ftplugin.= '| setlocal tabstop< shiftwidth<'
endif
