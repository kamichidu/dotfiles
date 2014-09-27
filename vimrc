scriptencoding utf-8


if filereadable(expand($MYVIMRC . '.system'))
    execute 'source' $MYVIMRC . '.system'
endif

" constants for using .vimrc
let s:constants= {
\   'directories': {
\       'temporary':   expand('~/.tmp/vim/'),
\       'development': expand('~/sources/vim-plugin/'),
\       'bundle':      expand('~/.bundle/'),
\   },
\}

augroup gyokuro
    autocmd!
augroup END

let g:gyokuro_pluggable= {
\   'description': 'pluggable vimrc settings',
\   'pluggables': [],
\}

function! g:gyokuro_pluggable.call_hook(name, ...)
    for l:pluggable in self.pluggables
        if has_key(l:pluggable, a:name)
            call call(l:pluggable[a:name], a:000, l:pluggable)
        endif
    endfor
endfunction

function! s:meltdown(expr)
    let l:blast_furnace= {}

    for l:dict in a:expr
        for l:key in keys(l:dict)
            let l:blast_furnace[l:key]= l:dict[l:key]
        endfor
    endfor

    return l:blast_furnace
endfunction

function! s:call_sl(path, func_name, ...)
    if !exists('s:scriptnames')
        redir => s:scriptnames
        silent scriptnames
        redir END
    endif

    let path2sid= {}

    for line in split(s:scriptnames, "\n")
        let key= fnamemodify(matchstr(line, '\%(:\s\+\)\@<=\f\+$'), ":p")
        let value= str2nr(matchstr(line, '\d\+\%(:\)\@='))

        let path2sid[key]= value
    endfor

    let sid= get(path2sid, fnamemodify(a:path, ':p'), -1)

    if sid == -1
        throw printf("No such file `%s'", a:path)
    endif

    return call(printf('<SNR>%d_%s', sid, a:func_name), a:000)
endfunction

if filereadable($MYVIMRC . '.local')
    execute 'source' $MYVIMRC . '.local'

    let s:pluggable= s:call_sl($MYVIMRC . '.local', '_pluggable')

    let g:gyokuro_pluggable.pluggables+= [s:pluggable]

    unlet s:pluggable
endif

if has('vim_starting')
    let &runtimepath.= ',' . s:constants.directories.bundle . 'neobundle.vim/'
endif
call neobundle#begin(s:constants.directories.bundle)

let g:neobundle#types#git#default_protocol= 'https'
let g:neobundle#install_process_timeout= 600

call g:gyokuro_pluggable.call_hook('on_neobundle_pre')

" XXX: don't manage neobundle.vim by neobundle.vim. this is obsolete.
NeoBundleFetch 'Shougo/neobundle.vim'

" manage vim by myself
NeoBundleFetch 'https://code.google.com/p/vim/', {
\   'type': 'hg',
\   'name': 'vim-self',
\   'build': {
\       'unix': expand('~/.vim/bin/build-vim-self.sh'),
\   },
\}

" switch neocompl{ete,cache}
let s:which_neocompl= has('lua') ? 'Shougo/neocomplete' : 'Shougo/neocomplcache'
" for managing evaluation timing
function! s:neobundle(repository, ...)
    let config= get(a:000, 0, {})

    let base_command= "NeoBundle '" . a:repository . "'"
    if empty(config)
        let command= base_command
    else
        let command= base_command . ',' . string(config)
    endif

    execute command
endfunction
" ease to write depends
function! s:neobundle_dependant_on(repository)
    let l:obj= {
    \   'dependant': a:repository,
    \}

    function! l:obj.by(repository, ...)
        let l:args= get(a:000, 0, {})

        if has_key(l:args, 'depends')
            let l:args.depends= [self.dependant] + l:args.depends
        else
            let l:args.depends= [self.dependant]
        endif

        call s:neobundle(a:repository, l:args)
    endfunction

    return l:obj
endfunction

call s:neobundle(s:which_neocompl)
call s:neobundle('Shougo/vimproc', {
\   'build': {
\       'unix': 'make -f make_unix.mak',
\   },
\})
call s:neobundle('Shougo/unite.vim')
let s:depends= s:neobundle_dependant_on('Shougo/unite.vim')
" call s:depends.by('osyo-manga/unite-qfixhowm', {
" \       'depends': ['fuenor/qfixhowm'],
" \})
call s:depends.by('choplin/unite-vim_hacks', {
\   'depends': ['mattn/webapi-vim', 'mattn/wwwrenderer-vim', 'thinca/vim-openbuf'],
\})
unlet s:depends
call s:neobundle('Shougo/vimshell', {
\   'depends': ['Shougo/unite.vim', 'Shougo/vimproc'],
\})
" call s:neobundle('Shougo/vimfiler', {
" \   'depends': ['Shougo/unite.vim', 'Shougo/vimproc'],
" \})
call s:neobundle('Shougo/neosnippet', {
\   'depends': [s:which_neocompl],
\})
" 読み込み設定は、-bつきで起動されたときくらい？
call s:neobundle('Shougo/vinarise')
" call s:neobundle('Shougo/javacomplete', {
" \   'build': {
" \       'unix': 'javac autoload/Reflection.java',
" \   },
" \})
call s:neobundle('Shougo/echodoc')
call s:neobundle('mattn/gist-vim', {
\   'depends': ['mattn/webapi-vim'],
\})
call s:neobundle('mattn/webapi-vim')
" emmet-vim eq zencoding-vim
call s:neobundle('mattn/emmet-vim')
call s:neobundle('mattn/qiita-vim')
call s:neobundle('mattn/msgpack-vim')
call s:neobundle('kana/vim-tabpagecd')
call s:neobundle('kana/vim-surround')
call s:neobundle('kana/vim-submode')
call s:neobundle('kana/vim-vspec')
let s:depends= s:neobundle_dependant_on('kana/vim-textobj-user')
call s:depends.by('kana/vim-textobj-entire')
call s:depends.by('kana/vim-textobj-function')
call s:depends.by('kana/vim-textobj-underscore')
call s:depends.by('deris/vim-textobj-enclosedsyntax')
call s:depends.by('thinca/vim-textobj-between')
call s:depends.by('thinca/vim-textobj-comment')
unlet s:depends
let s:depends= s:neobundle_dependant_on('kana/vim-gf-user')
call s:depends.by('sgur/vim-gf-autoload')
unlet s:depends
call s:neobundle('thinca/vim-ref')
call s:neobundle('thinca/vim-quickrun')
call s:neobundle('t9md/vim-textmanip')
call s:neobundle('t9md/vim-choosewin')
call s:neobundle('t9md/vim-quickhl')
call s:neobundle('tyru/open-browser.vim')
call s:neobundle('tyru/vim-altercmd')
call s:neobundle('tyru/eskk.vim')
call s:neobundle('koron/maze3d-vim')
call s:neobundle('koron/nyancat-vim')
call s:neobundle('itchyny/thumbnail.vim')
call s:neobundle('itchyny/calendar.vim')
call s:neobundle('tomtom/tcomment_vim')
call s:neobundle('osyo-manga/vim-precious', {
\   'depends': ['Shougo/context_filetype.vim'],
\})
call s:neobundle('osyo-manga/vim-owl', {
\   'depends': ['osyo-manga/vim-chained', 'osyo-manga/vim-budou'],
\})
call s:neobundle('osyo-manga/vim-watchdogs', {
\   'depends': [
\       'thinca/vim-quickrun',
\       'Shougo/vimproc',
\       'osyo-manga/shabadou.vim',
\       'jceb/vim-hier',
\       'dannyob/quickfixstatus',
\   ],
\})
call s:neobundle('osyo-manga/vim-snowdrop')
call s:neobundle('osyo-manga/vim-gyazo')
call s:neobundle('h1mesuke/vim-alignta')
call s:neobundle('jiangmiao/simple-javascript-indenter')
call s:neobundle('jelera/vim-javascript-syntax')
call s:neobundle('marijnh/tern_for_vim')
call s:neobundle('kchmck/vim-coffee-script')
call s:neobundle('majutsushi/tagbar')
call s:neobundle('godlygeek/csapprox', {
\   'force': 1,
\})
call s:neobundle('Rykka/colorv.vim', {
\   'depends': ['mattn/webapi-vim'],
\})
call s:neobundle('candycode.vim')
call s:neobundle('Rip-Rip/clang_complete')
" call s:neobundle('fuenor/qfixhowm')
call s:neobundle('vim-jp/vital.vim')
call s:neobundle('vim-jp/cpp-vim')
" for twitter
call s:neobundle('basyura/TweetVim', {
\   'depends': [
\       'tyru/open-browser.vim',
\       'basyura/twibill.vim',
\       'mattn/webapi-vim',
\       'h1mesuke/unite-outline',
\       'basyura/bitly.vim',
\       'Shougo/unite.vim',
\       'mattn/favstar-vim',
\   ],
\})
call s:neobundle('rbtnn/vimconsole.vim', {
\   'depends': ['thinca/vim-prettyprint'],
\})
call s:neobundle('gregsexton/gitv', {
\   'depends': ['tpope/vim-fugitive'],
\})
call s:neobundle('AnsiEsc.vim')
call s:neobundle('kannokanno/previm')
call s:neobundle('c9s/perlomni.vim')
call s:neobundle('yuratomo/w3m.vim')
" call s:neobundle('tsukkee/lingr-vim')
call s:neobundle('kamichidu/j6uil.vim', {
\   'depends': ['Shougo/vimproc', 'mattn/webapi-vim'],
\})
call s:neobundle('tpope/vim-abolish')
"
" XXX: lua omni completion trying
" call s:neobundle('rkowal/Lua-Omni-Vim-Completion')
" call s:neobundle('xolox/vim-lua-ftplugin', {
" \   'depends': ['vim-misc'],
" \})
"
"
call s:neobundle('DrawIt')
call s:neobundle('autodate.vim')
call s:neobundle('sudo.vim')
call s:neobundle('https://code.google.com/p/vimwiki/', {
\   'name': 'vimwiki',
\   'type': 'hg',
\   'rtp':  'src/',
\})
call s:neobundle('AndrewRadev/linediff.vim')
call s:neobundle('coderifous/textobj-word-column.vim')
call s:neobundle('ebnf.vim')
call s:neobundle('bnf.vim')
call s:neobundle('blinks/vim-antlr')
call s:neobundle('kamichidu/memolist.vim')
call s:neobundle('LeafCage/alti.vim')
call s:neobundle('syngan/vim-vimlint', {
\   'depends': ['ynkdir/vim-vimlparser'],
\})
call s:neobundle('balloon-stat/komadori.vim')
call s:neobundle('scrooloose/nerdtree')
call s:neobundle('ctrlpvim/ctrlp.vim')
call s:neobundle('mattn/ctrlp-gist', {
\   'depends': ['mattn/gist-vim'],
\})

" developing plugins
call neobundle#local(s:constants.directories.development, {
\   'type': 'nosync',
\})

call g:gyokuro_pluggable.call_hook('on_neobundle')

call neobundle#end()

" required!
filetype plugin indent on

if neobundle#tap('ref-vim')
    let g:ref_use_vimproc= 1
    let g:ref_jscore_path= ''
    let g:ref_jsdom_path=  ''
    let g:ref_html_path=   $HOME . '/documents/vim-ref-doc/www.aptana.com/reference/html/api/'
    let g:ref_html5_path=  $HOME . '/documents/vim-ref-doc/www.html5.jp/tag/elements/'
endif

if neobundle#tap('qfixhowm')
    let g:QFixHowm_DatePattern= '%Y-%m-%d'
    let g:QFixHowm_FileType=    'markdown.howm_memo'
    let g:QFixHowm_Title=       '#'
    let g:QFixHowm_DefaultTag= ''
    " 新規エントリの雛形
    " %TAG% == g:QFixHowm_DefaultTag
    let g:QFixHowm_Template= [
    \   '%TITLE% %TAG%',
    \   '%DATE%',
    \   ''
    \]
    let g:QFixHowm_SaveTime=  1
    let g:QFixHowm_SplitMode= 1
    let g:howm_dir=           '~/documents/qfixmemo'
    let g:howm_fileencoding=  &encoding
    let g:howm_fileformat=    &fileformat
    let g:howm_filename=      '%Y/%m/%Y-%m-%d-%H%M%S'
    let g:calendar_holidayfile= '~/documents/qfixmemo/Sche-Hd-0000-00-00-000000.txt'
endif

if neobundle#tap('memolist.vim')
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

if neobundle#tap('open-browser.vim')
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

if neobundle#tap('vim-watchdogs')
    let g:watchdogs_check_CursorHold_enables= {
    \   'java': 0,
    \}
    let g:quickrun_config= get(g:, 'quickrun_config', {})
    " let g:quickrun_config['watchdogs_checker/javac']= {
    " \   'command': 'javac',
    " \   'exec':    '%c %o %s',
    " \   'cmdopt':  '-source 1.6 -Xlint:all',
    " \}
endif

if neobundle#tap('vim-quickrun')
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
    let g:quickrun_config['java/watchdogs_checker']= {
    \   'type': 'watchdogs_checker/javac',
    \}
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
if neobundle#tap('vim-snowdrop')
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

if neobundle#tap('vimfiler')
    let g:vimfiler_as_default_explorer= 1
    let g:vimfiler_safe_mode_by_default= 0
endif
if neobundle#tap('nerdtree')
    
endif

" TODO: what to do?
let b:match_ignorecase= 1
let b:match_words=      &matchpairs.",<:>,<if>:<endif>,<function>:<endfunction>"

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

if neobundle#tap('vim-ref')
    let g:ref_no_default_key_mappings= 1
    let g:ref_perldoc_complete_head= 1

    " overwrite
    nmap <silent><expr> K mapping#ref('normal')
    vmap <silent><expr> K mapping#ref('visual')
endif

if neobundle#tap('tagbar')
    let g:tagbar_left= 1
    let g:tagbar_autoclose= 1
    let g:tagbar_autofocus= 1
    let g:tagbar_show_visibility= 1
endif

if neobundle#tap('colorv.vim')
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

if neobundle#tap('vim-submode')
    call submode#enter_with('winsize', 'n', '', '<C-W>>', '<C-W>>')
    call submode#enter_with('winsize', 'n', '', '<C-W><', '<C-W><')
    call submode#enter_with('winsize', 'n', '', '<C-W>-', '<C-W>-')
    call submode#enter_with('winsize', 'n', '', '<C-W>+', '<C-W>+')

    call submode#map('winsize', 'n', '', '>', '<C-W>>')
    call submode#map('winsize', 'n', '', '<', '<C-W><')
    call submode#map('winsize', 'n', '', '-', '<C-W>-')
    call submode#map('winsize', 'n', '', '+', '<C-W>+')
endif

if neobundle#tap('unite.vim')
    let g:unite_data_directory= s:constants.directories.temporary . '/.unite/'

    if executable('ag')
        let g:unite_source_grep_command=       'ag'
        let g:unite_source_grep_default_opts=  '--nogroup --nocolor'
        let g:unite_source_grep_recursive_opt= ''
    endif
endif

if neobundle#tap('gist-vim')
    " Only :w! updates a gist.
    let g:gist_update_on_write = 2
endif

if neobundle#tap('TweetVim')
    let g:tweetvim_tweet_per_page= 200
endif

if neobundle#tap('vimconsole.vim')
    let g:vimconsole#height= 20
    let g:vimconsole#maximum_caching_objects_count= 10000

    nnoremap <silent> <Leader>vc :<C-U>call<Space>vimconsole#wintoggle()<CR>

    function! s:configure_vimconsole()
        nmap <buffer> <C-L> <Plug>(vimconsole_redraw)
        nmap <buffer> <Del> <Plug>(vimconsole_clear)
    endfunction

    autocmd BufEnter * call s:configure_vimconsole()
endif

if neobundle#tap('context_filetype.vim')
    let g:context_filetype#filetypes= {
    \   'vim': [
    \       {
    \           'start': '\<perl\>\s\+<<\s*\(\w\+\)$',
    \           'end': '^\1$',
    \           'filetype': 'perl',
    \       },
    \   ],
    \}
endif

if neobundle#tap('vim-precious')
    let g:precious_enable_switch_CursorMoved= {
    \   'help': 0,
    \}
endif

if neobundle#tap('unite-javadoc_viewer')
    let g:javadocviewer_config= get(g:, 'javadocviewer_config', {})
    let g:javadocviewer_config.uri= [
    \   'http://docs.oracle.com/javase/7/docs/api/',
    \   'http://poi.apache.org/apidocs/',
    \   'http://docs.guava-libraries.googlecode.com/git/javadoc/',
    \]
endif

if neobundle#tap('eskk.vim')
    let g:eskk#directory= expand('~/.eskk/')
    let g:eskk#dictionary= {
    \   'path':     g:eskk#directory . '/user-dictionary',
    \   'sorted':   0,
    \   'encoding': 'utf-8',
    \}
    let g:eskk#large_dictionary= {
    \   'path':     g:eskk#directory . '/SKK-JISYO.L',
    \   'sorted':   1,
    \   'encoding': 'euc-jp',
    \}
    let g:eskk#auto_save_dictionary_at_exit= 1
    let g:eskk#dictionary_save_count=        3
    let g:eskk#start_completion_length=      1
endif

if neobundle#tap('vim-textobj-between')
    let g:textobj_between_no_default_key_mappings= 1

    " http://d.hatena.ne.jp/thinca/20100614/1276448745
    omap iF <Plug>(textobj-between-i)
    omap aF <Plug>(textobj-between-a)
    vmap iF <Plug>(textobj-between-i)
    vmap aF <Plug>(textobj-between-a)
endif

if neobundle#tap('vim-choosewin')
    nmap <C-W><C-W> <Plug>(choosewin)

    let g:choosewin_overlay_enable= 1
endif

if neobundle#tap('vim-quickhl')
    nmap <Leader>h <Plug>(quickhl-cword-toggle)
endif

if neobundle#tap('vim-altercmd')
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

if neobundle#tap('vim-coffee-script')
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

if neobundle#tap('j6uil.vim')
    let g:J6uil_updatetime=    500
    let g:J6uil_display_icon=  1
    let g:J6uil_echo_presence= 0
endif

if neobundle#tap('vim-javaclasspath')
    function! neobundle#hooks.on_source(bundle)
        let g:javaclasspath_config.standard.libs+= [{'path': 'lib/tools.jar'}]
    endfunction
endif

if neobundle#tap('alti.vim')
    let g:alti_prompt_mappings= get(g:, 'alti_prompt_mappings', {})
    let g:alti_prompt_mappings['PrtSelectMove("j")']= ['<Tab>']
    let g:alti_prompt_mappings['PrtSelectMove("k")']= ['<S-Tab>']
    let g:alti_prompt_mappings['PrtSelectMove("k")']= ['<S-Tab>']
    let g:alti_prompt_mappings['PrtSelectInsert()']=  ['<C-Y>']
endif

if neobundle#tap('calendar.vim')
    let g:calendar_google_calendar= 1
    let g:calendar_google_task= 1
endif

if neobundle#tap('komadori.vim')
endif

if neobundle#tap('ctrlp.vim')
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
    nnoremap <silent> <Leader>pp :<C-U>CtrlP<CR>
    nnoremap <silent> <Leader>pb :<C-U>CtrlPBuffer<CR>
    nnoremap <silent> <Leader>pm :<C-U>CtrlPMRU<CR>

    if neobundle#tap('ctrlp-gist')
    endif
    if neobundle#tap('qiita-vim')
    endif
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

" automatically make directory when write file
autocmd gyokuro BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)

function! s:auto_mkdir(dir, force)
    if !isdirectory(a:dir) && a:force
        call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
endfunction

" auto open qfix window when make
command! -nargs=* Make make <args> | cwindow 3

autocmd gyokuro QuickFixCmdPost [^l]* nested cwindow
autocmd gyokuro QuickFixCmdPost    l* nested lwindow

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

" prefix-tag for insert-mode
inoremap <SID>[tag] <Nop>
imap     <Leader>   <SID>[tag]
" prefix-tag for normal-mode
nnoremap <SID>[tag] <Nop>
nmap     <Leader>   <SID>[tag]
inoremap <SID>[tag]<Leader>    <Leader>
inoremap <SID>[tag]H           <Home>
inoremap <SID>[tag]e           <End>
inoremap <SID>[tag]h           <Esc>I
nnoremap <silent><SID>[tag]tt  :tabnew<CR>
nnoremap <silent><SID>[tag]ubo :Unite bookmark<CR>
nnoremap <silent><SID>[tag]ubu :Unite buffer<CR>
nnoremap <silent><SID>[tag]uff :Unite file<CR>
nnoremap <silent><SID>[tag]ufr :Unite file_rec/async<CR>
nnoremap <silent><SID>[tag]uo  :Unite outline<CR>
nnoremap <silent><SID>[tag]vfb :VimFiler<CR>
nnoremap <silent><SID>[tag]vfe :VimFiler -winwidth=50 -explorer -create<CR>
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

cnoremap <C-H> <Space><BS><Left>
cnoremap <C-L> <Space><BS><Right>
cnoremap <C-Y> <Space><BS>

" avoid to open command line window
nnoremap q: :
vnoremap q: :

autocmd gyokuro FileType * call s:map_quit()

function! s:map_quit()
    if  (&l:filetype ==# 'help' && &l:filetype ==# 'help') ||
    \   (&l:filetype ==# 'quickrun') ||
    \   (&l:filetype =~# '^ref') ||
    \   (&l:filetype ==# 'vimconsole')
        silent! nunmap q
        silent! vunmap q

        nnoremap <buffer><silent><nowait> q :<C-U>close<CR>
        vnoremap <buffer><silent><nowait> q :<C-U>close<CR>
    elseif &l:filetype ==# 'unite'
        silent! nunmap q

        nmap <buffer><nowait> q <Plug>(unite_exit)
    elseif &l:filetype ==# 'calendar'
        silent! nunmap q

        nmap <buffer><nowait> q <Plug>(calendar_exit)
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

set number norelativenumber
set tabstop=4 shiftwidth=4 softtabstop=4 expandtab smarttab
set autoindent smartindent
set showmatch
" set whichwrap=b,s,h,l,<,>,[,]
set whichwrap=b,s
set nowrapscan
set nowrap
set title
set textwidth=0
" .swpとbackupファイルをテンポラリに作成
set backup
set writebackup
" set backupdir=~/.tmp/vim/,.
let &backupdir= s:constants.directories.temporary . ',.'
set swapfile
" set directory=~/.tmp/vim/,.
let &directory= s:constants.directories.temporary . ',.'
" swpとbackupファイルの宛先がなければ作成
call s:make_dirs(join([&backupdir, &directory], ','))
" 無限undo
if has('persistent_undo')
    " set undodir=~/.tmp/vim/undo/
    let &undodir= s:constants.directories.temporary . '/undo/'
    set undofile

    call s:make_dirs(&undodir)
endif
" 全角文字のずれを修正
if exists('&ambiwidth')
    set ambiwidth=double
endif
" ファイル読み込み時のエンコーディング優先順
set fileencodings=utf-8,cp932,euc-jp,iso-2022-jp,default,latin
" 検索時に大文字小文字区別なし
set ignorecase smartcase
" statuslineを常に表示する
set laststatus=2
" swapfileを書き出す待ち時間
set updatetime=500
set cmdheight=2
" concealを有効にするのはnormal modeのみ。編集するときには不便。
if has('conceal')
    set conceallevel=0
    set concealcursor=
endif
" disable tag completion since it's too slow
set complete=.,w,b,u
set completeopt=menu
" no beep
set visualbell t_vb=
set incsearch
" don't move cursor when <C-D> and <C-U> and...
set nostartofline
set wildmode=longest:full,full
set wildmenu
set t_Co=256

autocmd gyokuro ColorScheme * if !has('gui_running') && exists(':CSApprox')
autocmd gyokuro ColorScheme *     CSApprox!
autocmd gyokuro ColorScheme * endif

colorscheme hydrangea

if executable('ag')
    let &grepprg= 'ag -n $*'
elseif executable('jvgrep')
    let &grepprg= 'jvgrep $*'
elseif executable('pt')
    let &grepprg= 'pt'
endif

call g:gyokuro_pluggable.call_hook('on_finish')
