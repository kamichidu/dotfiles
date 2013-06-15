" neocomplcache include completion setting
let g:neocomplcache_include_patterns= get(g:, 'neocomplcache_include_patterns', {})
let g:neocomplcache_include_exprs=    get(g:, 'neocomplcache_include_exprs',    {})
let g:neocomplcache_include_suffixes= get(g:, 'neocomplcache_include_suffixes', {})
let g:neocomplcache_include_paths=    get(g:, 'neocomplcache_include_paths', {})

call neocomplcache#set_dictionary_helper(g:neocomplcache_include_patterns, 
            \ 'perl', '^use')
call neocomplcache#set_dictionary_helper(g:neocomplcache_include_exprs, 
            \ 'perl', 
            \ 'substitute(v:fname, ''::'', ''/'', ''g'')')
call neocomplcache#set_dictionary_helper(g:neocomplcache_include_suffixes, 
            \ 'perl', 
            \ '.pm')
call neocomplcache#set_dictionary_helper(g:neocomplcache_include_paths, 
            \ 'perl', 
            \ &path . ',' . neocomplcache#system('perl -e', 'local $,= q/,/; print @INC;'))

