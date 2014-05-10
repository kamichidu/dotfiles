let s:save_cpo= &cpo
set cpo&vim

let s:V= vital#of('vital')
let s:P= s:V.import('Process')
unlet s:V

let s:luadoc= {
\   'name': 'luadoc',
\}

function! s:luadoc.get_body(query)
    let l:output= s:P.system('luarocks doc --list ' . a:query)
    let l:lines= split(l:output, "\n")

    if !empty(filter(copy(l:lines), "v:val =~# '" . '^Error:' . "'"))
        return l:output
    endif

    let l:docdirs= filter(copy(l:lines), join([
    \       "v:val !~# '" . '^Documentation' . "'",
    \       "v:val !~# '" . '^-\+$' . "'",
    \       "v:val =~# '" . '^\f' . "'",
    \   ],
    \   ' && '
    \))
    let l:files= filter(copy(l:lines), "v:val =~# '" . '^\t' . "'")

    call map(l:files, 'substitute(v:val, "^\t", "", "g")')

    let l:bodies= []

    for l:file in l:files
        call add(l:bodies, join([l:docdirs[0], l:file], ''))
    endfor

    return l:bodies
endfunction

function! s:luadoc.available()
    return executable('luarocks')
endfunction

function! s:luadoc.complete(query)
    let l:rocks= s:P.system('luarocks list')
    let l:completes= split(l:rocks, "\n")

    call filter(l:completes, 'v:val !~# ''^Installed'' && v:val =~# ''^\w''')

    return filter(l:completes, "v:val =~ '" . a:query . "'")
endfunction

function! ref#luadoc#define()
    return deepcopy(s:luadoc)
endfunction

let &cpo= s:save_cpo
unlet s:save_cpo
