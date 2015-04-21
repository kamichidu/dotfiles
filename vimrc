scriptencoding utf-8

let g:loaded_javacomplete= 1

" XXX: special constants
let s:debug= get(g:, 'debug', 0)

" disable mswin.vim
let g:skip_loading_mswin= 1

" constants for using .vimrc
let s:constants= {
\   'is_win':  has('win64') || has('win32') || has('win16') || has('win95'),
\   'is_unix': has('unix'),
\   'files': {
\       'vimrc':       $MYVIMRC,
\       'vimrc_local': $MYVIMRC . '.local',
\       'bundles':     expand('~/.bundles'),
\   },
\   'directories': {
\       'temporary':   expand('~/.tmp/vim/'),
\       'backup':      expand('~/.tmp/vim/backup/'),
\       'swap':        expand('~/.tmp/vim/swap/'),
\       'undo':        expand('~/.tmp/vim/undo/'),
\       'development': expand('~/sources/vim-plugin/'),
\       'bundle':      expand('~/.bundle/'),
\   },
\}

function! s:_()
    for dir in values(s:constants.directories)
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endfor
endfunction
call s:_()

augroup gyokuro
    autocmd!
augroup END

let g:gyokuro_extensions= []

function! s:invoke_extension(type, ...)
    let context= get(a:000, 0, {})

    for extension in g:gyokuro_extensions
        if has_key(extension, a:type)
            call call(extension[a:type], [context])
        endif
    endfor
endfunction

if filereadable(s:constants.files.vimrc_local)
    execute 'source' s:constants.files.vimrc_local
endif

syntax on

if s:constants.is_win
    set encoding=utf8 termencoding=cp932 fileformats=unix,dos,mac
elseif s:constants.is_unix
    set encoding=utf8 termencoding=utf8 fileformats=unix,dos,mac
endif
if exists('+shellslash')
    set shellslash
endif
set number norelativenumber
set tabstop=4 shiftwidth=4 softtabstop=4 expandtab smarttab
set autoindent smartindent
set showmatch
" set whichwrap=b,s,h,l,<,>,[,]
set whichwrap=b,s
set backspace=indent,eol,start
set nowrapscan
set nowrap
set title
set textwidth=0
set backup
set writebackup
let &backupdir= s:constants.directories.backup . ',.'
set swapfile
let &directory= s:constants.directories.swap . ',.'
if has('persistent_undo')
    let &undodir= s:constants.directories.undo
    set undofile
endif
if exists('&ambiwidth')
    set ambiwidth=double
endif
set fileencodings=utf-8,cp932,euc-jp,iso-2022-jp,default,latin
set hlsearch
set incsearch
set ignorecase smartcase
set laststatus=2
set updatetime=500
set cmdheight=2
if has('conceal')
    set conceallevel=0
    set concealcursor=
endif
" disable tag completion since it's too slow
set complete=.,w,b,u
set completeopt=menu
" no beep
set visualbell t_vb=
" don't move cursor when <C-D> and <C-U> and...
set nostartofline
set wildmode=longest:full,full wildmenu
set t_Co=256
set viminfo='20,<100
set history=50
set ruler
" auot-read file when it's modified by outside
set autoread
autocmd gyokuro WinEnter * checktime
set list
set listchars=tab:^I,trail:.

if executable('ag')
    let &grepprg= 'ag -n $*'
elseif executable('jvgrep')
    let &grepprg= 'jvgrep $*'
elseif executable('pt')
    let &grepprg= 'pt'
endif

call s:invoke_extension('configure_global')

" prefix-tag for insert-mode
inoremap <SID>[tag] <Nop>
imap     <Leader>   <SID>[tag]
" prefix-tag for normal-mode
nnoremap <SID>[tag] <Nop>
nmap     <Leader>   <SID>[tag]
inoremap <SID>[tag]<Leader>    <Leader>

if has('vim_starting')
    let &runtimepath.= ',' . s:constants.directories.bundle . 'neobundle/'
endif

let g:neobundle#types#git#default_protocol= 'https'
let g:neobundle#install_process_timeout= 600

call s:invoke_extension('neobundle_pre')

function! s:split2(expr, pattern)
    let bidx= match(a:expr, a:pattern)
    let eidx= matchend(a:expr, a:pattern)

    if bidx == -1
        return [a:expr]
    endif

    return [(bidx > 0) ? a:expr[ : bidx - 1] : '', a:expr[eidx : ]]
endfunction

function! s:read_ltsv(filename, config)
    let lines= readfile(a:filename)

    " apply comments
    let comment_pattern= '^#'
    call filter(lines, 'v:val !~# comment_pattern')

    let records= []
    for line in lines
        let values= map(split(line, '\t'), 's:split2(v:val, "=")')
        let record= {}

        for value in values
            let label= value[0]
            if index(a:config.arrays, label) != -1
                let record[label]= get(record, label, [])
                let record[label]+= [value[1]]
            elseif index(a:config.dicts, label) != -1
                let record[label]= get(record, label, {})
                let value2= s:split2(value[1], '=')
                let record[label][value2[0]]= value2[1]
            else
                let record[label]= value[1]
            endif
        endfor

        let records+= [record]
    endfor
    return records
endfunction

function! s:load_bundles(filename)
    let records= s:read_ltsv(a:filename, {
    \   'arrays': ['depends'],
    \   'dicts':  ['build'],
    \})

    " filter if when expr is false
    call filter(records, 'has_key(v:val, "when") ? eval(v:val.when) : 1')

    " {
    "     'NeoBundleFetch': {
    "         'vim-jp/vital.vim': {},
    "     },
    " }
    let commands= {}
    let aliases= {}
    for record in records
        let command= (has_key(record, 'command')) ? record.command : 'NeoBundle'
        let config= {}

        if has_key(record, 'name')
            let config.name= record.name
            let config.regular_name= record.name
        endif
        if has_key(record, 'type')
            let config.type= record.type
        endif
        if has_key(record, 'force')
            let config.force= str2nr(record.force)
        endif
        if has_key(record, 'alias')
            let aliases[record.alias]= record.repo
        endif
        if has_key(record, 'name')
            let aliases[record.repo]= record.name
        endif
        if has_key(record, 'rtp')
            let config.rtp= record.rtp
        endif
        if has_key(record, 'build')
            let config.build= record.build
        endif
        if has_key(record, 'depends')
            let config.depends= record.depends
        endif

        let commands[command]= get(commands, command, {})
        let commands[command][record.repo]= config
    endfor

    if s:debug | let g:gyokuro_neobundle= [] | endif
    for cmd in keys(commands)
        for repo in keys(commands[cmd])
            let config= commands[cmd][repo]

            " resolve alias, organize name
            if has_key(config, 'depends')
                let [depends, config.depends]= [config.depends, []]

                for dep in depends
                    while 1
                        if dep =~# '^{{\w\+}}$'
                            let dep= matchstr(dep, '{{\zs\w\+\ze}}')
                        endif

                        if !has_key(aliases, dep)
                            break
                        endif

                        let dep= aliases[dep]
                    endwhile

                    let config.depends+= [dep]
                endfor
            endif

            if s:debug | let g:gyokuro_neobundle+= [join([cmd, string(repo), ',', string(config)])] | endif
            execute cmd string(repo) ',' string(config)
        endfor
    endfor
endfunction

" call neobundle#begin(s:constants.directories.bundle)
silent call neobundle#rc(s:constants.directories.bundle)

call s:load_bundles(s:constants.files.bundles)

" developing plugins
call neobundle#local(s:constants.directories.development, {
\   'type': 'nosync',
\})

call s:invoke_extension('neobundle')

" call neobundle#end()

call s:invoke_extension('neobundle_post')

" required!
filetype plugin indent on

if neobundle#tap('ref')
    let g:ref_use_vimproc= 1
    let g:ref_jscore_path= ''
    let g:ref_jsdom_path=  ''
    let g:ref_html_path=   $HOME . '/documents/vim-ref-doc/www.aptana.com/reference/html/api/'
    let g:ref_html5_path=  $HOME . '/documents/vim-ref-doc/www.html5.jp/tag/elements/'
endif

if neobundle#tap('memolist')
    let g:memolist_path= expand('~/documents/memo/')
    let g:memolist_memo_suffix= 'mkd'
    " date format (default %Y-%m-%d %H:%M)
    let g:memolist_memo_date = "%Y-%m-%d %H:%M:%S"
    let g:memolist_unite= 1
    let g:memolist_unite_option= ''
    " let g:memolist_unite_source= 'file_rec/async'
    let g:memolist_template_content= []

    nnoremap <silent> g,c :<C-U>MemoNew<Space><C-R>=strftime('%H%M%S')<CR><CR>
    nnoremap <silent> g,t :<C-U>tabnew<CR>:<C-U>MemoNew<Space><C-R>=strftime('%H%M%S')<CR><CR>
    nnoremap g,l :<C-U>MemoList<CR>
    nnoremap g,g :<C-U>MemoGrep<CR>
endif

if neobundle#tap('open-browser')
    let g:netrw_nogx= 1 " disable netrw's gx mapping.
    let g:openbrowser_browser_commands= [
    \   {
    \       'name': 'firefox',
    \       'args': ['{browser}', '{uri}'],
    \   },
    \]
    nmap gx <Plug>(openbrowser-smart-search)
    vmap gx <Plug>(openbrowser-smart-search)
endif

if neobundle#tap('quickrun')
    let g:quickrun_config= get(g:, 'quickrun_config', {})
    let g:quickrun_config['_']= {
    \   'runner'                    : 'vimproc',
    \   'runner/vimproc/sleep'      : 50,
    \   'runner/vimproc/updatetime' : 100,
    \   'outputter/buffer/close_on_empty': 1,
    \}
    let g:quickrun_config['perl']= {
    \   'type'                     : 'perl',
    \   'outputter'                : 'buffer',
    \   'outputter/close_on_empty' : 1,
    \}
    let g:quickrun_config['vimwiki']= {
    \   'type'                     : 'vimwiki',
    \   'outputter'                : 'buffer',
    \   'outputter/close_on_empty' : 1,
    \   'command'                  : $HOME.'/local/markdown/1.0.1/Markdown.pl',
    \}
    let g:quickrun_config['perl6']= {
    \   'type'                     : 'perl6',
    \   'outputter'                : 'buffer',
    \   'outputter/close_on_empty' : 1,
    \   'command'                  : $HOME.'/perl6.rakudo/rakudo/perl6',
    \}
    let g:quickrun_config['markdown']= {
    \   'type': 'markdown',
    \   'outputter': 'browser',
    \   'command': expand('~/local/markdown/1.0.1/Markdown.pl'),
    \}
    let g:quickrun_config['cpp']= {
    \   'type': 'cpp',
    \   'outputter': 'buffer',
    \   'command': expand('~/local/gcc/default/bin/g++'),
    \   'runner': 'vimproc',
    \   'cmdopt': '-std=c++11 -Wall',
    \}
    let g:quickrun_config['sql/psql']= {
    \   'type': 'sql/psql',
    \   'command': 'psql',
    \   'cmdopt': ['--host=localhost', '--port=5432', '--username=postgres', '--dbname=test'],
    \}

    if neobundle#tap('watchdogs')
        let g:watchdogs_check_CursorHold_enables= {
        \   'java': 0,
        \}
        let g:watchdogs_check_BufWritePost_enables= {
        \   'java': 1,
        \}

        let g:quickrun_config['java/watchdogs_checker']= {'type': 'watchdogs_checker/javac'}
        let g:quickrun_config['watchdogs_checker/javac']= {
        \   'command': '$JAVA_HOME/bin/javac',
        \   'cmdopt': join([
        \       '-Xlint:all',
        \       '-d $TEMP',
        \       '-sourcepath "%{javaclasspath#source_path()}"',
        \       '-classpath "%{javaclasspath#classpath()}"',
        \       '-deprecation',
        \   ]),
        \   'exec': '%c %o %S',
        \   'errorformat': '%tarning: %m,%-G%*\d error,%-G%*\d warnings,%f:%l: %trror: %m,%f:%l: %tarning: %m,%+G%.%#',
        \}
        " :help errorformat-javac
        " \   'errorformat': '%A%f:%l: %m,%-Z%p^,%+C%.%#,%-G%.%#',
    endif
endif

if neobundle#tap('echodoc')
    let g:echodoc_enable_at_startup= 1
endif

if neobundle#tap('neocomplete')
    let g:neocomplete#enable_at_startup= 1
    let g:neocomplete#use_vimproc= 1
    " 表示する候補数
    let g:neocomplete#max_list= 100000
    let g:neocomplete#auto_completion_start_length= 2
    let g:neocomplete#min_keyword_length= 2
    let g:neocomplete#enable_ignore_case= 1
    let g:neocomplete#enable_smart_case= 1
    " i hate fuzzy completion
    let g:neocomplete#enable_fuzzy_completion= 0

    " キャッシュ置き場
    if has('unix')
        let g:neocomplete#data_directory= s:constants.directories.temporary . '/.neocomplete/'
    elseif has('win64') || has('win32') || has('win16')
        let g:neocomplete#data_directory= s:constants.directories.temporary . '/.neocomplete/'
    endif

    " 関数補完時の区切り文字
    if !exists('g:neocomplete#delimiter_patterns')
        let g:neocomplete#delimiter_patterns= {}
    endif
    let g:neocomplete#delimiter_patterns['cpp']= ['\.', '->', '::']
    let g:neocomplete#delimiter_patterns['java']= ['\.']
    " let g:neocomplete#delimiter_patterns['perl']= ['::', '->']

    " omni complete
    let g:neocomplete#force_overwrite_completefunc= 1
    if !exists('g:neocomplete#sources#omni#input_patterns')
        let g:neocomplete#sources#omni#input_patterns= {}
    endif
    let g:neocomplete#sources#omni#input_patterns['perl']= join([
    \       '[^. \t]->\%(\h\w*\)\?',
    \       '\h\w*::\%(\h\w*\)\?',
    \       '\$\%(\w*\)\?',
    \       '%\%(\w*\)\?',
    \       '@\%(\w*\)\?',
    \       '\*\%(\w*\)\?',
    \   ],
    \   '\|'
    \)
    let g:neocomplete#sources#omni#input_patterns['cpp']= join([
    \       '[^.[:digit:] *\t]\%(\.\|->\)\w*',
    \       '.*::\w*',
    \   ],
    \   '\|'
    \)

    if !exists('g:neocomplete#sources#omni#functions')
        let g:neocomplete#sources#omni#functions= {}
    endif
    " let g:neocomplete#sources#omni#functions['java']= 'javacomplete#Complete'
    let g:neocomplete#sources#omni#functions['perl']= 'PerlComplete'
    let g:neocomplete#sources#omni#functions['cpp']= 'ClangComplete'

    " disable unnecessary sources
    for s:source_name in ['include', 'syntax', 'member']
        call neocomplete#custom#source(s:source_name, 'disabled_filetypes', {'_': 1})
    endfor
    unlet s:source_name

    call neocomplete#custom#source('file', 'rank', 999)
elseif neobundle#tap('neocomplcache')
    let g:neocomplcache_enable_at_startup= 1
    let g:neocomplcache_enable_auto_close_preview= 0
    let g:neocomplcache_use_vimproc=       1
    let g:neocomplcache_enable_wildcard=   1
    let g:neocomplcache_enable_camel_case_completion= 1
    let g:neocomplcache_enable_underbar_completion=   1
    let g:neocomplcache_enable_ignore_case= 1
    let g:neocomplcache_enable_smart_case=  1
    " 表示する候補数
    let g:neocomplcache_max_list= 100000
    " キャッシュ置き場
    if has('unix')
        let g:neocomplcache_temporary_dir= s:constants.directories.temporary . '/.neocomplcache/'
    elseif has('win64') || has('win32') || has('win16')
        let g:neocomplcache_temporary_dir= s:constants.directories.temporary . '/.neocomplcache/'
    endif
    " シンタックス補完はうざいのでいらない
    let g:neocomplcache_disabled_sources_list= get(g:, 'neocomplcache_disabled_sources_list', {})
    let g:neocomplcache_disabled_sources_list['_']= ['syntax_complete']
    " 関数補完時の区切り文字
    let g:neocomplcache_delimiter_patterns= get(g:, 'neocomplcache_delimiter_patterns', {})
    let g:neocomplcache_delimiter_patterns['cpp']= ['\.', '->', '::']
    let g:neocomplcache_delimiter_patterns['java']= ['\.']
    " インクルード補完用
    let g:neocomplcache_include_paths= get(g:, 'neocomplcache_include_paths', {})
    let g:neocomplcache_include_paths['java']= '~/local/java/default/src/'
    let g:neocomplcache_include_paths['cpp']=  '.,'.&path
    let g:neocomplcache_include_exprs= get(g:, 'neocomplcache_include_exprs', {})
    let g:neocomplcache_include_exprs['perl']= 'substitute(v:fname, "::", "/", "g")'
    let g:neocomplcache_include_exprs['cpp']=  'substitute(v:fname, "<\\|>\\|\"", "", "g")'
    let g:neocomplcache_include_exprs['java']= 'substitute(substitute(v:fname, "\\.", "/", "g"), "$", ".java", "")'
    let g:neocomplcache_include_patterns= get(g:, 'neocomplcache_include_patterns', {})
    let g:neocomplcache_include_patterns['cpp']= '\<\(include\)\>'
    let g:neocomplcache_include_patterns['java']= '\<\(import\)\>'
    let g:neocomplcache_include_suffixes= get(g:, 'neocomplcache_include_suffixes', {})
    let g:neocomplcache_include_suffixes['cpp']= ['', '.h', '.hpp', '.hxx']
    let g:neocomplcache_include_suffixes['java']= ['.java']
    let g:neocomplcache_include_suffixes['perl']= ['.pm', '.pl']

    let g:neocomplcache_ctags_program= 'ctags'
    let g:neocomplcache_ctags_arguments_list= get(g:, 'neocomplcache_ctags_arguments_list', {})
    let g:neocomplcache_ctags_arguments_list['java']= '--java-kinds=cefgilmp'

    " clang_complete
    let g:neocomplcache_force_overwrite_completefunc= 1
    let g:neocomplcache_force_omni_patterns= get(g:, 'neocomplcache_force_omni_patterns', {})
    let g:neocomplcache_force_omni_patterns['java']= '\.'
    let g:neocomplcache_force_omni_patterns['perl']= '::\|->\|\$\|@\|%'
    " let g:neocomplcache_force_omni_patterns['cpp']= '[^.[:digit:] *\t]\%(\.\|->\)\|::'
    " let g:neocomplcache_force_omni_patterns['cpp']= '\.\|->\|::'
    let g:neocomplcache_omni_functions= get(g:, 'neocomplcache_omni_functions', {})
    " let g:neocomplcache_omni_functions['java']= 'javacomplete#Complete'
    let g:neocomplcache_omni_functions['perl']= 'PerlComplete'
    let g:neocomplcache_vim_completefuncs= get(g:, 'neocomplcache_vim_completefuncs', {})
    " let g:neocomplcache_vim_completefuncs['java']= 'javacomplete#CompleteParamsInfo'
    let g:neocomplcache_vim_completefuncs['perl']= 'PerlComplete'
endif
if neobundle#tap('clang_complete')
    " let g:clang_exec= $HOME . '/local/bin/clang++'
    let g:clang_complete_auto= 0
    let g:clang_auto_select= 0
    let g:clang_close_preview= 0
    let g:clang_use_library= 1
    " let g:clang_library_path= $HOME . '/local/lib/'
    " let g:clang_user_options= '-std=c++11 -fms-extensions --fgnu-runtime'
    " one of {alpha, priority, none}
    let g:clang_sort_algo= 'alpha'
    let g:clang_complete_macros= 1
endif
if neobundle#tap('snowdrop')
    let g:snowdrop#libclang_path= '/usr/lib/'
endif
if neobundle#tap('neosnippet')
    let g:neosnippet#snippets_directory= $HOME.'/.snippet/'
    let g:neosnippet#disable_runtime_snippets= {
    \   '_': 1,
    \}
endif
if neobundle#tap('vimwiki')
    let g:vimwiki_list= [{
    \   'path'      : '~/documents/site/vimwiki/wiki/',
    \   'path_html' : '~/documents/site/vimwiki/html/',
    \   'syntax'    : 'markdown',
    \   'ext'       : '.vimwiki',
    \}]
endif

if neobundle#tap('nerdtree')
    nnoremap <silent> <SID>[tag]nt :<C-U>NERDTreeToggle<CR>
endif

if neobundle#tap('dirvish')
    let g:dirvish_hijack_netrw= 1
endif

function! s:map(lhs, rhs, opt, modes) " {{{
    call s:_map('map', a:lhs, a:rhs, a:opt, a:modes)
endfunction

function! s:noremap(lhs, rhs, opt, modes) " {{{
    call s:_map('noremap', a:lhs, a:rhs, a:opt, a:modes)
endfunction

function! s:_map(cmd, lhs, rhs, opt, modes) " {{{
    " 'abcd' -> ['a', 'b', 'c', 'd']
    let l:modes= split(a:modes, '\zs\ze')

    for l:m in l:modes
        let l:expr= join([l:m . a:cmd, a:opt, a:lhs, a:rhs], ' ')

        execute l:expr
    endfor
endfunction

if neobundle#tap('ref')
    let g:ref_no_default_key_mappings= 1
    let g:ref_perldoc_complete_head= 1

    " overwrite
    nmap <silent><expr> K mapping#ref('normal')
    vmap <silent><expr> K mapping#ref('visual')

    autocmd gyokuro FileType ref call s:init_ref_buf()
    function! s:init_ref_buf()
        nnoremap <buffer><nowait> q <C-W>c
    endfunction
endif

if neobundle#tap('tagbar')
    let g:tagbar_left= 1
    let g:tagbar_autoclose= 1
    let g:tagbar_autofocus= 1
    let g:tagbar_show_visibility= 1
endif

if neobundle#tap('colorv')
    " 2, if +python
    " 3, if +python3
    " 0, if no python
    if has('python') || has('python/dyn')
        let g:colorv_has_python= 2
    elseif has('python3') || has('python3/dyn')
        let g:colorv_has_python= 3
    else
        let g:colorv_has_python= 0
    endif
endif

if neobundle#tap('submode')
    call submode#enter_with('winsize', 'n', '', '<C-W>>', '<C-W>>')
    call submode#enter_with('winsize', 'n', '', '<C-W><', '<C-W><')
    call submode#enter_with('winsize', 'n', '', '<C-W>-', '<C-W>-')
    call submode#enter_with('winsize', 'n', '', '<C-W>+', '<C-W>+')

    call submode#map('winsize', 'n', '', '>', '<C-W>>')
    call submode#map('winsize', 'n', '', '<', '<C-W><')
    call submode#map('winsize', 'n', '', '-', '<C-W>-')
    call submode#map('winsize', 'n', '', '+', '<C-W>+')
endif

if neobundle#tap('unite')
    let g:unite_data_directory= s:constants.directories.temporary . '/.unite/'

    if executable('ag')
        let g:unite_source_grep_command=       'ag'
        let g:unite_source_grep_default_opts=  '--nogroup --nocolor'
        let g:unite_source_grep_recursive_opt= ''
    endif
endif

if neobundle#tap('gist')
    " Only :w! updates a gist.
    let g:gist_update_on_write = 2
endif

if neobundle#tap('TweetVim')
    let g:tweetvim_tweet_per_page= 200
endif

if neobundle#tap('vimconsole')
    let g:vimconsole#height= 20
    let g:vimconsole#maximum_caching_objects_count= 10000

    nnoremap <silent> <Leader>vc :<C-U>call<Space>vimconsole#wintoggle()<CR>

    function! s:configure_vimconsole()
        nmap <buffer> <C-L> <Plug>(vimconsole_redraw)
        nmap <buffer> <Del> <Plug>(vimconsole_clear)
    endfunction

    autocmd gyokuro BufEnter * call s:configure_vimconsole()
endif

if neobundle#tap('textobj-between')
    let g:textobj_between_no_default_key_mappings= 1

    " http://d.hatena.ne.jp/thinca/20100614/1276448745
    omap iF <Plug>(textobj-between-i)
    omap aF <Plug>(textobj-between-a)
    vmap iF <Plug>(textobj-between-i)
    vmap aF <Plug>(textobj-between-a)
endif

if neobundle#tap('choosewin')
    nmap <C-W><C-W> <Plug>(choosewin)

    let g:choosewin_overlay_enable= 1
endif

if neobundle#tap('quickhl')
    nmap <Leader>h <Plug>(quickhl-cword-toggle)
endif

if neobundle#tap('altercmd')
    call altercmd#load()

    AlterCommand perldoc        Ref perldoc
    AlterCommand unite          Unite
    AlterCommand ref            Unite ref
    AlterCommand vimwi[ki2html] !~/documents/sources/perl/tools/markdown/vimwikiall2html.sh
    AlterCommand man            Ref man
    " git-statusのように区切り文字入れたい
    AlterCommand gits[tatus] Gstatus
    AlterCommand gitd[iff] Gdiff
    AlterCommand gitb[lame] Gblame
endif

if neobundle#tap('coffee-script')
"     autocmd gyokuro QuickFixCmdPost * nested cwindow | redraw!
"
"     function! s:compile_coffee()
"         if !exists('b:coffee_dir')
"             let b:coffee_dir= input('where is coffee directory? ', '')
"         endif
"         if !exists('b:js_dir')
"             let b:js_dir= input('where is javascript directory? ', '')
"         endif
"
"         if empty(b:coffee_dir) || empty(b:js_dir)
"             return
"         endif
"
"         execute 'silent make! -o ' . b:js_dir . ' -j app.js -c ' . b:coffee_dir . '/**/*.coffee'
"     endfunction
"
"     autocmd gyokuro BufWritePost *.coffee call s:compile_coffee()
endif

if neobundle#tap('j6uil')
    let g:J6uil_updatetime=    500
    let g:J6uil_display_icon=  1
    let g:J6uil_echo_presence= 0

    nnoremap <silent> <Leader>l :<C-U>call ctrlp#init(ctrlp#j6uil#rooms#id())<CR>
endif

if neobundle#tap('javaclasspath')
    let g:javaclasspath_config= get(g:, 'javaclasspath_config', {})
    let g:javaclasspath_config.standard= get(g:javaclasspath_config, 'standard', {})
    let g:javaclasspath_config.standard.libs= get(g:javaclasspath_config.standard, 'libs', []) + [{'path': 'lib/tools.jar'}]
    let g:javaclasspath_enable_auto_analyze= 1
endif

if neobundle#tap('alti')
    let g:alti_prompt_mappings= get(g:, 'alti_prompt_mappings', {})
    let g:alti_prompt_mappings['PrtSelectMove("j")']= ['<Tab>']
    let g:alti_prompt_mappings['PrtSelectMove("k")']= ['<S-Tab>']
    let g:alti_prompt_mappings['PrtSelectMove("k")']= ['<S-Tab>']
    let g:alti_prompt_mappings['PrtSelectInsert()']=  ['<C-Y>']
endif

if neobundle#tap('calendar')
    let g:calendar_google_calendar= 1
    let g:calendar_google_task= 1
endif

if neobundle#tap('komadori')
endif

if neobundle#tap('ctrlp')
    let g:ctrlp_map= ''
    let g:ctrlp_working_path_mode= 'rw'
    let g:ctrlp_use_caching= 1
    let g:ctrlp_user_command= {
    \   'types': {
    \       1: ['.git', 'cd %s && git ls-files'],
    \       2: ['.hg',  'hg --cwd %s locate -I .'],
    \   },
    \   'fallback': 'find %s -type f',
    \}
    let g:ctrlp_match_window= 'min:1,max:20'

    let g:ctrlp_prompt_mappings= {
    \   'PrtBS()':              ['<BS>'],
    \   'PrtDelete()':          ['<Del>'],
    \   'PrtDeleteWord()':      ['<C-W>'],
    \   'PrtClear()':           ['<C-U>'],
    \   'PrtSelectMove("j")':   ['<C-N>'],
    \   'PrtSelectMove("k")':   ['<C-P>'],
    \   'PrtSelectMove("t")':   ['<Home>'],
    \   'PrtSelectMove("b")':   ['<End>'],
    \   'PrtSelectMove("u")':   ['<PageUp>'],
    \   'PrtSelectMove("d")':   ['<PageDown>'],
    \   'PrtHistory(-1)':       [],
    \   'PrtHistory(1)':        [],
    \   'AcceptSelection("e")': ['<CR>', '<2-LeftMouse>'],
    \   'AcceptSelection("h")': ['<C-X>', '<C-CR>', '<C-S>'],
    \   'AcceptSelection("t")': ['<C-T>'],
    \   'AcceptSelection("v")': ['<C-V>'],
    \   'ToggleFocus()':        ['<S-Tab>'],
    \   'ToggleRegex()':        ['<C-R>'],
    \   'ToggleByFname()':      ['<c-d>'],
    \   'ToggleType(1)':        ['<c-f>', '<c-up>'],
    \   'ToggleType(-1)':       ['<c-b>', '<c-down>'],
    \   'PrtExpandDir()':       ['<tab>'],
    \   'PrtInsert("c")':       ['<MiddleMouse>', '<insert>'],
    \   'PrtInsert()':          ['<c-\>'],
    \   'PrtCurStart()':        ['<c-a>'],
    \   'PrtCurEnd()':          ['<c-e>'],
    \   'PrtCurLeft()':         ['<c-h>', '<left>', '<c-^>'],
    \   'PrtCurRight()':        ['<c-l>', '<right>'],
    \   'PrtClearCache()':      ['<F5>'],
    \   'PrtDeleteEnt()':       ['<F7>'],
    \   'CreateNewFile()':      ['<c-y>'],
    \   'MarkToOpen()':         ['<c-z>'],
    \   'OpenMulti()':          ['<c-o>'],
    \   'PrtExit()':            ['<esc>', '<c-c>', '<c-g>'],
    \}

    " mapping for standard extensions
    nnoremap <silent> <Leader>pp  :<C-U>CtrlP<CR>
    nnoremap <silent> <Leader>pbu :<C-U>CtrlPBuffer<CR>
    nnoremap <silent> <Leader>pbt :<C-U>CtrlPBufTag<CR>
    nnoremap <silent> <Leader>pm  :<C-U>CtrlPMRU<CR>

    if neobundle#tap('ctrlp-gist')
    endif
    if neobundle#tap('qiita')
    endif
endif

if neobundle#tap('geeknote')
    let g:GeeknoteFormat= 'markdown'
    let g:GeeknoteExplorerWidth= float2nr(&columns * 0.2)
endif

if neobundle#tap('previm')
    let g:previm_enable_realtime= 1
endif

if neobundle#tap('operator-surround')
    nmap Ra <Plug>(operator-surround-append)
    xmap Ra <Plug>(operator-surround-append)
    nmap Rr <Plug>(operator-surround-replace)
    xmap Rr <Plug>(operator-surround-replace)
    nmap Rd <Plug>(operator-surround-delete)
    xmap Rd <Plug>(operator-surround-delete)
endif

if neobundle#tap('operator-replace')
    map _ <Plug>(operator-replace)
endif

if neobundle#tap('committia')
    let g:committia_open_only_vim_starting= 0

    autocmd gyokuro BufReadPost COMMIT_EDITMSG call committia#open('git')
endif

if neobundle#tap('incsearch')
    map /  <Plug>(incsearch-forward)
    map ?  <Plug>(incsearch-backward)
    map g/ <Plug>(incsearch-stay)
endif

" if neobundle#tap('unite-javaimport')
"     function! neobundle#hooks.on_source(bundle)
"         let g:javaimport_config.exclude_packages= [
"         \   'java.lang',
"         \   'com.oracle',
"         \   'com.sun.accessibility',
"         \   'com.sun.activation',
"         \   'com.sun.awt',
"         \   'com.sun.beans',
"         \   'com.sun.corba',
"         \   'com.sun.demo',
"         \   'com.sun.image',
"         \   'com.sun.imageio',
"         \   'com.sun.istack',
"         \   'com.sun.java',
"         \   'com.sun.java_cup',
"         \   'com.sun.jmx',
"         \   'com.sun.jndi',
"         \   'com.sun.management',
"         \   'com.sun.media',
"         \   'com.sun.naming',
"         \   'com.sun.net',
"         \   'com.sun.nio',
"         \   'com.sun.org',
"         \   'com.sun.rmi',
"         \   'sun',
"         \   'sunw',
"         \]
"     endfunction
" endif

call s:invoke_extension('configure_plugin')

" automatically make directory when write file
autocmd gyokuro BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)

function! s:auto_mkdir(dir, force)
    if !isdirectory(a:dir) && a:force
        call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
endfunction

" auto open qfix window when make
" command! -nargs=* Make make <args> | cwindow 3
"
" autocmd gyokuro QuickFixCmdPost [^l]* nested cwindow
" autocmd gyokuro QuickFixCmdPost    l* nested lwindow

command!
\ -nargs=* -complete=command
\ AllMaps
\ map <args> | map! <args> | lmap <args>

command!
\ -nargs=+ -complete=command
\ Capture
\ call s:cmd_capture(<q-args>)

function! s:cmd_capture(q_args)
    call unite#start([['output', a:q_args]])
    " redir => output
    " silent execute a:q_args
    " redir END
    " let output= substitute(output, '^\n\+', '', '')

    " belowright new

    " silent file `=printf('[Capture: %s]', a:q_args)`
    " setlocal buftype=nofile bufhidden=unload noswapfile nobuflisted
    " call setline(1, split(output, '\n'))
endfunction

if has('perl')
    function! PerlModuleOf(module)
        let incpath= system('perl -e "$,= q/,/; print @INC"')
        let relpath= substitute(a:module, '::', '/', 'g') . '.pm'

        return globpath(incpath, relpath)
    endfunction
endif

command!
\   MakeTags
\   silent execute '!ctags -R &' | redraw!

function! s:toggle_virtualedit()
    if &virtualedit =~# 'all'
        setlocal virtualedit=
    else
        setlocal virtualedit=all
    endif
    return "\<C-L>"
endfunction
function! s:toggle_cursorline()
    if &cursorline
        setlocal nocursorline
    else
        setlocal cursorline
    endif
    return "\<C-L>"
endfunction

" mkdir by dir list comma separated form
function! s:make_dirs(dir_list)
    if exists('*mkdir')
        let l:tmpdirs= split(a:dir_list, ',', 0)

        for l:tmpdir in l:tmpdirs
            if !isdirectory(l:tmpdir)
                call mkdir(iconv(l:tmpdir, &encoding, &termencoding), 'p')
            endif
        endfor
    else
        echoerr "doesn't exists mkdir function!"
    endif
endfunction

function! s:tabselect(tabnr)
    if !(a:tabnr >= 0 && a:tabnr < tabpagenr())
        echohl Error
        echo 'No such tabnr.'
        echohl NONE
        return
    endif

    if a:tabnr > 0
        execute 'tabnext' a:tabnr
    else
        tabfirst
    endif
endfunction

inoremap <SID>[tag]H           <Home>
inoremap <SID>[tag]e           <End>
inoremap <SID>[tag]h           <Esc>I
nnoremap <silent><SID>[tag]tt  :<C-U>tabnew<CR>
nnoremap <silent><SID>[tag]t0  :<C-U>call s:tabselect(0)<CR>
nnoremap <silent><SID>[tag]t1  :<C-U>call s:tabselect(1)<CR>
nnoremap <silent><SID>[tag]t2  :<C-U>call s:tabselect(2)<CR>
nnoremap <silent><SID>[tag]t3  :<C-U>call s:tabselect(3)<CR>
nnoremap <silent><SID>[tag]t4  :<C-U>call s:tabselect(4)<CR>
nnoremap <silent><SID>[tag]t5  :<C-U>call s:tabselect(5)<CR>
nnoremap <silent><SID>[tag]t6  :<C-U>call s:tabselect(6)<CR>
nnoremap <silent><SID>[tag]t7  :<C-U>call s:tabselect(7)<CR>
nnoremap <silent><SID>[tag]t8  :<C-U>call s:tabselect(8)<CR>
nnoremap <silent><SID>[tag]t9  :<C-U>call s:tabselect(9)<CR>
nnoremap <silent><SID>[tag]ubo :Unite bookmark<CR>
nnoremap <silent><SID>[tag]ubu :Unite buffer<CR>
nnoremap <silent><SID>[tag]uff :Unite file<CR>
nnoremap <silent><SID>[tag]ufr :Unite file_rec/async<CR>
nnoremap <silent><SID>[tag]uo  :Unite outline<CR>
nnoremap <expr><SID>[tag]cl    <SID>toggle_cursorline()
nnoremap <expr><SID>[tag]ve    <SID>toggle_virtualedit()
nnoremap <silent><SID>[tag]o   :TagbarToggle<CR>
nnoremap <silent><C-H>         :nohlsearch<CR>
nnoremap <silent><C-N>         :tabn<CR>
nnoremap <silent><C-P>         :tabN<CR>
nnoremap zl                    zL
nnoremap zh                    zH
nnoremap <silent><C-L>         :<C-U>redraw<CR>
" keep center
nnoremap *                     *zzzv
nnoremap #                     #zzzv
nnoremap n                     nzzzv
nnoremap N                     Nzzzv
nnoremap ]c                    ]czz
nnoremap [c                    [czz
" inoremap <C-[>                 <C-[><C-L>
vnoremap <                     <gv
vnoremap >                     >gv
vmap <C-H> <Plug>(textmanip-move-left)
vmap <C-J> <Plug>(textmanip-move-down)
vmap <C-K> <Plug>(textmanip-move-up)
vmap <C-L> <Plug>(textmanip-move-right)
" super tab emu.
imap <expr><Tab> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<Tab>"
smap <expr><Tab> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<Tab>"

function! s:toggle_qfixwin()
    for bufnr in tabpagebuflist()
        if getbufvar(bufnr, '&filetype') ==# 'qf'
            " close
            cclose
            return
        endif
    endfor

    copen
    wincmd p
endfunction

nnoremap <silent> <C-W>, :<C-U>call <SID>toggle_qfixwin()<CR>

cnoremap <C-H> <Space><BS><Left>
cnoremap <C-L> <Space><BS><Right>
cnoremap <C-Y> <Space><BS>

"
" :h cmdwin-char
"
" :   normal Ex command
" >   debug mode command |debug-mode|
" /   forward search string
" ?   backward search string
" =   expression for "= |expr-register|
" @   string for |input()|
" -   text for |:insert| or |:append|
"
autocmd gyokuro CmdwinEnter * call s:quit_cmdwin(expand('<afile>'))
function! s:quit_cmdwin(mode)
    call feedkeys("\<C-W>c")

    if a:mode ==# ':'
        call feedkeys(':')
    elseif a:mode ==# '/'
        call feedkeys('/')
    elseif a:mode ==# '?'
        call feedkeys('?')
    endif
endfunction

autocmd gyokuro BufNewFile,BufRead    *.g            setlocal filetype=antlr3
autocmd gyokuro BufNewFile,BufRead    *.g4           setlocal filetype=antlr4
autocmd gyokuro BufEnter,BufReadPre   *.tex          setlocal filetype=tex
autocmd gyokuro BufNewFile            *.pl,*.cgi,*.t setlocal fileencoding=utf8
autocmd gyokuro BufEnter,BufReadPre   *.ftl          setlocal filetype=ftl
autocmd gyokuro BufEnter,BufReadPre   *.ebnf         setlocal filetype=ebnf
autocmd gyokuro BufEnter,BufReadPre   *.yrl          setlocal filetype=erlang
autocmd gyokuro FileType java let &l:equalprg= 'uncrustify -c ~/dotfiles/uncrustify.conf/java.conf -l JAVA'
autocmd gyokuro BufNewFile,BufRead *.tsv setfiletype tsv

" When editing a file, always jump to the last cursor position
autocmd gyokuro BufReadPost * if line("'\"") > 0 && line ("'\"") <= line("$")
autocmd gyokuro BufReadPost *     exe "normal! g'\""
autocmd gyokuro BufReadPost * endif

colorscheme hydrangea
if neobundle#tap('csapprox')
    " autocmd gyokuro VimEnter * echomsg 'CSApprox!'
    " autocmd gyokuro VimEnter * CSApprox!
endif
