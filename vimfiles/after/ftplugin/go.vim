let s:save_cpo= &cpo
set cpo&vim

augroup gyokuro-ft-go
    autocmd!
augroup END

let s:undo= []

setlocal nolist
let s:undo+= ['setlocal list<']

" gocode, etc
let s:gocode_path= globpath($GOPATH, 'src/github.com/nsf/gocode/vim/')
if s:gocode_path !=# ''
    if index(split(&runtimepath, ','), s:gocode_path) == -1
        execute 'set runtimepath+=' . s:gocode_path
    endif

    setlocal omnifunc=gocomplete#Complete
    let s:undo+= ['setlocal omnifunc<']
endif

if executable('gofmt')
    function! s:exec_gofmt() abort
        if &l:filetype !=# 'go'
            return
        endif

        let save_pos= getpos('.')
        try
            %!gofmt
        finally
            call setpos('.', save_pos)
        endtry
    endfunction
    autocmd gyokuro-ft-go BufWritePre * call s:exec_gofmt()
endif

if !exists('b:undo_ftplugin')
    let b:undo_ftplugin= ''
else
    let b:undo_ftplugin.= ' | '
endif
let b:undo_ftplugin.= join(s:undo, ' | ')

let &cpo= s:save_cpo
unlet s:save_cpo
