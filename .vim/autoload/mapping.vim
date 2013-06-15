let s:save_cpo = &cpo
set cpo&vim

function! mapping#ref(mode)
    if !exists('g:loaded_ref')
        echoerr 'vim-ref not exists!'
        return ''
    endif

    if &filetype !=# 'vim'
        return "\<Plug>(ref-keyword)"
    endif

    let l:word= ref#get_text_on_cursor('\w\+')
    echo l:word

    if strlen(l:word) <= 0
        return ""
    endif

    return ":help ".l:word."\<CR>"
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: foldmethod=marker

