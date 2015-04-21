function! s:overwrite_mappings()
    " undo j6uil-say-buffer mappings
    silent! nunmap <buffer> <C-J>
    silent! nunmap <buffer> <Esc>

    " nnoremap <silent><buffer> <C-j> :bd!<CR>
    " nnoremap <silent><buffer> <esc> :bd!<CR>
    nnoremap <silent><buffer><nowait> q :<C-U>bdelete!<CR>
endfunction

autocmd gyokuro FileType J6uil_say call s:overwrite_mappings()
