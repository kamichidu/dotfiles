" perlomniがやってくれるから、いらないかな
" neocomplcache include completion setting
" let g:neocomplcache_include_patterns= get(g:, 'neocomplcache_include_patterns', {})
" let g:neocomplcache_include_exprs=    get(g:, 'neocomplcache_include_exprs',    {})
" let g:neocomplcache_include_suffixes= get(g:, 'neocomplcache_include_suffixes', {})
" let g:neocomplcache_include_paths=    get(g:, 'neocomplcache_include_paths', {})
" 
" call neocomplcache#set_dictionary_helper(g:neocomplcache_include_patterns, 
"             \ 'perl', '^use')
" call neocomplcache#set_dictionary_helper(g:neocomplcache_include_exprs, 
"             \ 'perl', 
"             \ 'substitute(v:fname, ''::'', ''/'', ''g'')')
" call neocomplcache#set_dictionary_helper(g:neocomplcache_include_suffixes, 
"             \ 'perl', 
"             \ '.pm')
" call neocomplcache#set_dictionary_helper(g:neocomplcache_include_paths, 
"             \ 'perl', 
"             \ &path . ',' . neocomplcache#system('perl -e', 'local $,= q/,/; print @INC;'))

" scriptencoding utf8
" 
" if exists('b:did_ftplugin_gyokuro_perl') && b:did_ftplugin_gyokuro_perl
"     finish
" endif
" let b:did_ftplugin_gyokuro_perl= 1
" 
" let s:save_cpo= &cpo
" set cpo&vim
" 
" let b:undo_ftplugin= get(b:, 'undo_ftplugin', 'setl fenc< ff< equalprg< | delcommand Prove | unlet b:did_ftplugin_gyokuro_perl')
" let b:undo_ftplugin.= ''
" 
" let &l:fileencoding= 'utf8'
" let &l:fileformat= 'unix'
" let &l:equalprg= 'perltidy'
" 
" if executable('prove')
"     command! -buffer Prove !prove -r
" endif
" 
" let &cpo= s:save_cpo
" unlet s:save_cpo

