if exists('g:loaded_ctrlp_j6uil_rooms') && g:loaded_ctrlp_j6uil_rooms
    finish
endif
let g:loaded_ctrlp_j6uil_rooms = 1

function! ctrlp#j6uil#rooms#init()
    return J6uil#get_rooms()
endfunction

function! ctrlp#j6uil#rooms#accept(mode, str)
    execute 'J6uil' a:str
endfunction

let g:ctrlp_ext_vars= get(g:, 'ctrlp_ext_vars', []) + [{
\   'init':   'ctrlp#j6uil#rooms#init()',
\   'accept': 'ctrlp#j6uil#rooms#accept',
\   'lname':  'j6uil-rooms',
\   'sname':  'j6uil-rooms',
\   'type':   'path',
\   'sort':   0,
\}]

let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)
function! ctrlp#j6uil#rooms#id()
    return s:id
endfunction
