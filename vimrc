" vim:foldmethod=marker:fen:
scriptencoding utf-8

if filereadable(expand('~/.vimrc.system'))
    source ~/.vimrc.system
endif

" .vimrcで使用する設定値
let s:gyokuro_constants= {
\   'vimrc': expand('~/.vimrc'), 
\   'temporary_dir':  expand('~/.tmp/vim/'),
\   'dev-plugin-dir': expand('~/sources/vim-plugin/'),
\   'grepprgs': [
\       {
\           'grepprg': 'ag', 
\           'args': ['-n', '$*', '%'], 
\       }, 
\       {
\           'grepprg': 'grep', 
\           'args': ['-n', '$*', '%'], 
\       }, 
\   ], 
\   'vimrc-edit-support': 1, 
\}
augroup gyokuro
    autocmd!
augroup END

" plugin {{{
" neobundle {{{
if has('vim_starting')
    set runtimepath+=~/.bundle/neobundle.vim/
endif
call neobundle#rc(expand('~/.bundle/'))
let g:neobundle#types#git#default_protocol= 'ssh'
" let NeoBundle manage NeoBundle
" required!
filetype off
filetype plugin indent off

" neobundleはneobundle管理しないほうがいい
NeoBundleFetch 'Shougo/neobundle.vim'
" recommended to install
NeoBundle 'Shougo/vimproc', {
\   'build': {
\       'unix': 'make -f make_unix.mak', 
\   }, 
\}
" after install, turn shell ~/.bundle/vimproc, (n,g)make -f your_machines_makefile
NeoBundle 'DrawIt'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/unite.vim', {
\   'name': 'unite.vim', 
\}
NeoBundle 'Shougo/vimshell', {
\   'depends': ['Shougo/unite.vim', 'Shougo/vimproc'], 
\}
NeoBundle 'Shougo/vimfiler', {
\   'depends': ['Shougo/unite.vim', 'Shougo/vimproc'], 
\}
NeoBundle 'Shougo/neosnippet', {
\   'depends': ['Shougo/neocomplcache'], 
\}
" 読み込み設定は、-bつきで起動されたときくらい？
NeoBundleLazy 'Shougo/vinarise'
NeoBundle 'autodate.vim'
NeoBundle 'mattn/gist-vim', {
\   'lazy': 1, 
\   'depends': ['mattn/webapi-vim'], 
\   'autoload': {
\       'commands': 'Gist', 
\   }, 
\}
NeoBundle 'mattn/webapi-vim'
NeoBundleLazy 'mattn/zencoding-vim', {
\   'autoload': {
\       'filetypes': ['html', 'xml', 'javascript'], 
\   }, 
\}
NeoBundle 'quickhl.vim'
NeoBundle 'sudo.vim'
" NeoBundle 'taglist.vim'
NeoBundle 'thinca/vim-ref'
NeoBundle 'pekepeke/ref-javadoc', {
\   'depends': ['thinca/vim-ref'], 
\}
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'thinca/vim-quickrun'
" NeoBundle 'git://github.com/tyru/vim-altercmd.git'
NeoBundle 'kana/vim-tabpagecd'
NeoBundle 'kana/vim-surround'
NeoBundle 'https://code.google.com/p/vimwiki/', {
\   'type': 'hg', 
\   'directory': 'vimwiki/src/', 
\}
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'tyru/vim-altercmd'
NeoBundle 'koron/maze3d-vim'
NeoBundle 'koron/nyancat-vim'
NeoBundle 'h1mesuke/vim-alignta'
NeoBundleLazy 'jiangmiao/simple-javascript-indenter', {
\   'autoload': {
\       'filetypes': ['javascript'], 
\   }, 
\}
NeoBundleLazy 'jelera/vim-javascript-syntax', {
\   'autoload': {
\       'filetypes': ['javascript'], 
\   }, 
\}
NeoBundleLazy 'teramako/jscomplete-vim', {
\   'autoload': {
\       'filetypes': ['javascript'], 
\   }, 
\}
NeoBundleLazy 'scrooloose/syntastic', {
\   'autoload': {
\       'filetypes': ['javascript', 'html', 'xml', 'css', 'perl'], 
\   }, 
\}
NeoBundleLazy 'kchmck/vim-coffee-script', {
\   'autoload': {
\       'filetypes': ['coffee'], 
\   }, 
\}
NeoBundle 'majutsushi/tagbar'
NeoBundle 't9md/vim-textmanip'
NeoBundle 'godlygeek/csapprox'
NeoBundleLazy 'Rykka/colorv.vim', {
\   'depends': ['mattn/webapi-vim'], 
\   'build': {
\       'unix': 'make -f autoload/Makefile', 
\   }, 
\}
NeoBundle 'candycode.vim'
NeoBundleLazy 'Rip-Rip/clang_complete', {
\   'autoload': {
\       'filetypes': ['c', 'cpp'], 
\   }, 
\}
NeoBundleLazy 'Shougo/neocomplcache-clang_complete', {
\   'autoload': {
\       'filetypes': ['c', 'cpp'], 
\   }, 
\}
NeoBundle 'javacomplete', {
\   'build': {
\       'unix': 'javac autoload/Reflection.java', 
\   }, 
\}
NeoBundle 'Shougo/echodoc'
NeoBundle 'kana/vim-submode'
NeoBundle 'osyo-manga/vim-precious', {
\   'depends': ['Shougo/context_filetype.vim'], 
\}
NeoBundle 'choplin/unite-vim_hacks', {
\   'depends': ['Shougo/unite.vim', 'mattn/webapi-vim', 'mattn/wwwrenderer-vim', 'thinca/vim-openbuf'], 
\}
NeoBundle 'fuenor/qfixhowm', {
\}
NeoBundle 'osyo-manga/unite-qfixhowm', {
\   'depends': ['Shougo/unite.vim', 'fuenor/qfixhowm'], 
\}
NeoBundle 'mattn/qiita-vim'
NeoBundle 'vim-jp/vital.vim'

" for twitter
NeoBundle 'basyura/TweetVim', {
\   'depends': [
\       'tyru/open-browser.vim', 
\       'basyura/twibill.vim', 
\       'mattn/webapi-vim', 
\       'h1mesuke/unite-outline', 
\       'basyura/bitly.vim', 
\       'Shougo/unite.vim', 
\       'mattn/favstar-vim', 
\   ], 
\}
NeoBundle 'rbtnn/vimconsole.vim', {
\   'depends': ['thinca/vim-prettyprint'], 
\}
NeoBundle 'gregsexton/gitv', {
\   'depends': ['tpope/vim-fugitive'], 
\}
NeoBundle 'AnsiEsc.vim'
NeoBundle 'kannokanno/previm', {
\   'lazy': 1, 
\   'autoload': {
\       'filetypes': ['markdown'], 
\   }, 
\}
NeoBundle 'c9s/perlomni.vim', {
\}
NeoBundle 'mattn/msgpack-vim'
NeoBundle 'osyo-manga/vim-owl', {
\   'depends': ['osyo-manga/vim-chained', 'osyo-manga/vim-budou'], 
\}
NeoBundle 'hokaccha/vim-prove'
NeoBundle 'yuratomo/w3m.vim'
NeoBundle 'osyo-manga/vim-hideout'
NeoBundle 'tsukkee/lingr-vim'
NeoBundle 'tyru/eskk.vim'

" 開発用
call neobundle#local(s:gyokuro_constants['dev-plugin-dir'], {
\   'type': 'nosync', 
\})

" required!
filetype plugin indent on
" }}}
" vim-ref {{{
let g:ref_use_vimproc= 1
let g:ref_jscore_path= ''
let g:ref_jsdom_path=  ''
let g:ref_html_path=   $HOME.'/documents/vim-ref-doc/www.aptana.com/reference/html/api/'
let g:ref_html5_path=  $HOME.'/documents/vim-ref-doc/www.html5.jp/tag/elements/'
" }}}
" qfixhowm {{{
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
" }}}
" open browser {{{
let g:netrw_nogx= 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)
" }}}
" quickrun {{{
let g:quickrun_config= get(g:, 'quickrun_config', {})
let g:quickrun_config['_']= {
\   'runner'                    : 'vimproc',
\   'runner/vimproc/sleep'      : 50,
\   'runner/vimproc/updatetime' : 100,
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
" }}}
" echodoc {{{
let g:echodoc_enable_at_startup= 1
" }}}
" neocomplcache {{{
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
    let g:neocomplcache_temporary_dir= s:gyokuro_constants['temporary_dir'].'/.neocomplcache/'
elseif has('win64') || has('win32') || has('win16')
    let g:neocomplcache_temporary_dir= s:gyokuro_constants['temporary_dir'].'/.neocomplcache/'
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
let g:neocomplcache_omni_functions['java']= 'javacomplete#Complete'
let g:neocomplcache_omni_functions['perl']= 'PerlComplete'
let g:neocomplcache_vim_completefuncs= get(g:, 'neocomplcache_vim_completefuncs', {})
let g:neocomplcache_vim_completefuncs['java']= 'javacomplete#CompleteParamsInfo'
let g:neocomplcache_vim_completefuncs['perl']= 'PerlComplete'

let g:clang_exec= $HOME.'/local/bin/clang++'
let g:clang_complete_auto= 1
let g:clang_use_library= 1
let g:clang_auto_select= 0
let g:clang_library_path= $HOME.'/local/lib/'
let g:clang_user_options= '-std=c++11 -fms-extensions --fgnu-runtime'
" }}}
" neosnippet {{{
let g:neosnippet#snippets_directory= $HOME.'/.snippet/'
let g:neosnippet#disable_runtime_snippets= {
\   '_': 1, 
\}
" }}}
" vimwiki {{{
let g:vimwiki_list= [{
\   'path'      : '~/documents/site/vimwiki/wiki/',
\   'path_html' : '~/documents/site/vimwiki/html/',
\   'syntax'    : 'markdown',
\   'ext'       : '.md',
\}]
" }}}
" vimfiler {{{
let g:vimfiler_as_default_explorer= 1
let g:vimfiler_safe_mode_by_default= 0
" }}}
" matchit {{{
let b:match_ignorecase= 1
let b:match_words=      &matchpairs.",<:>,<if>:<endif>,<function>:<endfunction>"
" }}}
" ref {{{
function! s:map(lhs, rhs, opt, modes) " {{{
    call s:_map('map', a:lhs, a:rhs, a:opt, a:modes)
endfunction
" }}}
function! s:noremap(lhs, rhs, opt, modes) " {{{
    call s:_map('noremap', a:lhs, a:rhs, a:opt, a:modes)
endfunction
" }}}
function! s:_map(cmd, lhs, rhs, opt, modes) " {{{
    " 'abcd' -> ['a', 'b', 'c', 'd']
    let l:modes= split(a:modes, '\zs\ze')

    for l:m in l:modes
        let l:expr= join([l:m . a:cmd, a:opt, a:lhs, a:rhs], ' ')

        execute l:expr
    endfor
endfunction
" }}}
let s:bundle= neobundle#get('vim-ref')
function! s:bundle.hooks.on_source(bundle)
    let g:ref_no_default_key_mappings= 1
    let g:ref_perldoc_complete_head= 1

    " 上書き
    nmap <silent><expr> K mapping#ref('normal')
    vmap <silent><expr> K mapping#ref('visual')

    autocmd gyokuro FileType ref-* call s:map('q', ':<C-U>q<CR>', '<buffer><silent>', 'nx')
endfunction
unlet s:bundle
" }}}
" syntastic {{{
" 遅延初期化ではうまく設定されなかった at 2013-03-17 00:33:15
" let s:bundle= neobundle#get('syntastic')
" function! s:bundle.hooks.on_source(bundle)
let g:syntastic_enable_signs=         1
let g:syntastic_error_symbol=         'E>'
let g:syntastic_warning_symbol=       'W>'
let g:syntastic_style_error_symbol=   'S>'
let g:syntastic_style_warning_symbol= 's>'
let g:syntastic_auto_jump=            0
" When set to 2 the error window will be automatically closed when no errors are
" detected, but not opened automatically. >
let g:syntastic_auto_loc_list= 2
" passive: manually check, active: automatically check
let g:syntastic_mode_map= {
\   'mode'              : 'passive',
\   'active_filetypes'  : ['javascript', 'html', 'xml', 'css', 'perl'],
\   'passive_filetypes' : [],
\}
" endfunction
" unlet s:bundle
" }}}
" tagbar {{{
let g:tagbar_left= 1
let g:tagbar_autoclose= 1
let g:tagbar_autofocus= 1
let g:tagbar_show_visibility= 1
" }}}
" colorv.vim {{{
let s:bundle= neobundle#get('colorv.vim')
function! s:bundle.hooks.on_source(bundle)
    " 2, if +python
    " 3, if +python3
    " 0, if no python
    let g:colorv_has_python= 0
endfunction
unlet s:bundle
" }}}
" submode {{{
let s:bundle= neobundle#get('vim-submode')
function! s:bundle.hooks.on_source(bundle)
    call submode#enter_with('winsize', 'n', '', '<C-W>>', '<C-W>>')
    call submode#enter_with('winsize', 'n', '', '<C-W><', '<C-W><')
    call submode#enter_with('winsize', 'n', '', '<C-W>-', '<C-W>-')
    call submode#enter_with('winsize', 'n', '', '<C-W>+', '<C-W>+')

    call submode#map('winsize', 'n', '', '>', '<C-W>>')
    call submode#map('winsize', 'n', '', '<', '<C-W><')
    call submode#map('winsize', 'n', '', '-', '<C-W>-')
    call submode#map('winsize', 'n', '', '+', '<C-W>+')
endfunction
unlet s:bundle
" }}}
" unite {{{
" let s:bundle= neobundle#get('unite.vim')
" function! s:bundle.hooks.on_source(bundle)
let g:unite_data_directory= s:gyokuro_constants['temporary_dir'].'/.unite/'
" endfunction
" unlet s:bundle
" }}}
" gist {{{
let s:bundle= neobundle#get('gist-vim')
function! s:bundle.hooks.on_source(bundle)
    " Only :w! updates a gist.
    let g:gist_update_on_write = 2
endfunction
unlet s:bundle
" }}}
" tweetvim {{{
let s:bundle= neobundle#get('TweetVim')
function! s:bundle.hooks.on_source(bundle)
    let g:tweetvim_tweet_per_page= 200
endfunction
unlet s:bundle
" }}}
" vimconsole {{{
let s:bundle= neobundle#get('vimconsole.vim')
function! s:bundle.hooks.on_source(bundle)
    let g:vimconsole#height= 20
endfunction
unlet s:bundle
" }}}
" context_filetype {{{
let g:context_filetype#filetypes= {
\   'vim': [
\       {
\           'start': '\<perl\>\s\+<<\s*\(\w\+\)$', 
\           'end': '^\1$', 
\           'filetype': 'perl', 
\       }, 
\   ], 
\}
" }}}
" precious {{{
let g:precious_enable_switch_CursorMoved= {
\   'help': 0, 
\}
" }}}
" javadoc_viewer {{{
let g:javadocviewer_config= get(g:, 'javadocviewer_config', {})
let g:javadocviewer_config.uri= [
\   'http://docs.oracle.com/javase/7/docs/api/', 
\   'http://poi.apache.org/apidocs/', 
\   'http://docs.guava-libraries.googlecode.com/git/javadoc/', 
\]
" }}}
" eskk {{{
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
" }}}
" }}}
" command {{{
" altercmd {{{
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
" }}}
" automatically make directory when write file {{{
autocmd gyokuro BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)

function! s:auto_mkdir(dir, force)
    if !isdirectory(a:dir) && a:force
        call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
endfunction
" }}}
" auto open qfix window when make {{{
command! -nargs=* Make make <args> | cwindow 3

autocmd gyokuro QuickFixCmdPost [^l]* nested cwindow
autocmd gyokuro QuickFixCmdPost    l* nested lwindow
" }}}
" AllMaps {{{
command! 
\ -nargs=* -complete=command
\ AllMaps
\ map <args> | map! <args> | lmap <args>
" }}}
" Capture {{{
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
" }}}
" on save action {{{
" autocmd BufWritePre * call s:trim_or_append_empty_line()

function! s:trim_or_append_empty_line()
    " 現在のカーソル位置を記憶
    let l:store_cursor_pos= getpos('.')

    " 最終行が空行でなければ、改行追加
    if !empty(getline('$'))
        normal G$o
    else
        " 空行でない最終行番号 + 1 <  最終行番号
        " この場合余分に改行がついているので、トリム
        while prevnonblank('$') + 1 < line('$')
            normal GkJ
        endwhile
    endif

    " 処理前のカーソル位置に戻す
    call setpos('.', l:store_cursor_pos)
endfunction
" }}}
" }}}
" mapping {{{
" helper {{{
" mapping helper {{{
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
" }}}
" mkdir by dir list comma separated form {{{
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
" }}}
" }}}
" cnoremap <C-D> <Del>
cnoremap <C-H> <Left>
cnoremap <C-L> <Right>
" inoremap <C-D> <Del>
inoremap <C-H> <Left>
" inoremap <C-J> <Down>
" inoremap <C-K> <Up>
inoremap <C-L> <Right>
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
nnoremap <silent><SID>[tag]vfe :VimFiler -explorer<CR>
nnoremap <expr><SID>[tag]cl    <SID>toggle_cursorline()
nnoremap <expr><SID>[tag]ve    <SID>toggle_virtualedit()
nnoremap <silent><SID>[tag]o   :TagbarToggle<CR>
nnoremap <silent><C-H>         :nohlsearch<CR>
nnoremap <silent><C-N>         :tabn<CR>
nnoremap <silent><C-P>         :tabN<CR>
nnoremap zl                    zL
nnoremap zh                    zH
nnoremap <C-CR>                i<CR><Esc>
" keep center
nnoremap *                     *zzzv
nnoremap #                     #zzzv
nnoremap n                     nzzzv
nnoremap N                     Nzzzv
" inoremap <C-[>                 <C-[><C-L>
vnoremap <                     <gv
vnoremap >                     >gv
vmap     <C-H>                 <Plug>(textmanip-move-left)
vmap     <C-J>                 <Plug>(textmanip-move-down)
vmap     <C-K>                 <Plug>(textmanip-move-up)
vmap     <C-L>                 <Plug>(textmanip-move-right)
" super tab emu.
imap <expr><Tab> neosnippet#expandable_or_jumpable() ? 
\"\<Plug>(neosnippet_expand_or_jump)" : 
\"\<Tab>"
smap <expr><Tab> neosnippet#expandable_or_jumpable() ?
\"\<Plug>(neosnippet_expand_or_jump)" :
\"\<Tab>"
" vnoremap <silent>"*y  :call<Space>Yank2Remote()<CR>
" }}}
" color {{{
set t_Co=256
colorscheme hydrangea
" reloadすると、csapproxが自動フックしない(できない？)ので、cui用の色設定が失われる
" なので、手動でやる
if exists(':CSApprox') == 2
    CSApprox!
endif
" }}}
" filetype depended config {{{
" autocmd gyokuro FileType * call s:switch_filetype(expand('<amatch>'))
" 
" function! s:switch_filetype(new_filetype)
"     if !exists('b:gyokuro_filetype_info')
"         let b:gyokuro_filetype_info= {
"         \   'current_filetypes': [], 
"         \   'sweepers': {}, 
"         \}
"     endif
"     " PP! b:gyokuro_filetype_info
" 
"     let l:filetypes= b:gyokuro_filetype_info.current_filetypes
"     let l:sweepers= b:gyokuro_filetype_info.sweepers
"     for l:filetype in l:filetypes
"         for l:sweeper in get(l:sweepers, l:filetype, [])
"             execute l:sweeper
"         endfor
" 
"         if has_key(b:gyokuro_filetype_info.sweepers, l:filetype)
"             call remove(b:gyokuro_filetype_info.sweepers, l:filetype)
"         endif
"     endfor
"     unlet l:sweepers
" 
"     let l:filetypes= split(a:new_filetype, '\.')
"     for l:filetype in l:filetypes
"         let l:func_name= 's:on_enter_' . l:filetype
" 
"         if exists('*' . l:func_name)
"             let l:sweepers= {l:func_name}()
" 
"             call extend(b:gyokuro_filetype_info.sweepers, l:sweepers)
"         endif
"     endfor
"     let b:gyokuro_filetype_info.current_filetypes= l:filetypes
" endfunction
" 
" function! s:on_enter_perl()
"     let l:sweeper= {
"     \   'perl': [
"     \       'setlocal fileencoding=' . &l:fileencoding, 
"     \       'setlocal fileformat=' . &l:fileformat, 
"     \       'setlocal equalprg=' . &l:equalprg, 
"     \   ], 
"     \}
" 
"     let &l:fileencoding= 'utf8'
"     let &l:fileformat=   'unix'
"     let &l:equalprg=     'perltidy'
" 
"     return l:sweeper
" endfunction

autocmd gyokuro BufNewFile,BufRead *.g setl filetype=antlr3
autocmd gyokuro BufEnter,BufReadPre *.tex setlocal filetype=tex
autocmd gyokuro BufNewFile *.pl,*.cgi,*.t setlocal fileencoding=utf8
autocmd gyokuro BufEnter,BufReadPre *.ftl setlocal filetype=ftl
autocmd gyokuro BufNewFile,BufReadPre * if &binary | NeoBundleSource vinarise
autocmd gyokuro BufNewFile,BufReadPre * endif
autocmd gyokuro FileType help nnoremap <buffer><silent>q <Esc>:<C-U>q<CR>
" }}}
" editor {{{
" 新しい行のインデントを現在行と同じにする
set autoindent
" 行番号を表示
set number
" シフト移動幅
set shiftwidth=4
" 閉じ括弧が入力されたとき、対応する括弧を表示
set showmatch
" 新しい行が入力されたとき、高度な自動インデントを行う
set smartindent
" 行頭の余白内でtabを入力すると、shiftwidthの数だけインデント
set smarttab
" ファイル内の<tab>が対応する空白の数
set tabstop=4
" カーソルを行頭行末で止まらないようにする
set whichwrap=b,s,h,l,<,>,[,]
" 検索をファイル先頭にループしない
set nowrapscan
set title
set expandtab
set nowrap
set textwidth=0
" .swpとbackupファイルをテンポラリに作成
set backup
set writebackup
" set backupdir=~/.tmp/vim/,.
let &backupdir= s:gyokuro_constants['temporary_dir'].',.'
set swapfile
" set directory=~/.tmp/vim/,.
let &directory= s:gyokuro_constants['temporary_dir'].',.'
" swpとbackupファイルの宛先がなければ作成
call s:make_dirs(&backupdir.','.&directory)
" 無限undo
if has('persistent_undo')
    " set undodir=~/.tmp/vim/undo/
    let &undodir= s:gyokuro_constants['temporary_dir'].'/undo/'
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
set ignorecase
" statuslineを常に表示する
set laststatus=2
" swapfileを書き出す待ち時間
set updatetime=500
set cmdheight=2
" concealを有効にするのはnormal modeのみ。編集するときには不便。
if has('conceal')
    set conceallevel=1
    set concealcursor=n
endif
" }}}
" indent-expr {{{
function! GetVimIndent()
    " Find a non-blank line above the current line.
    let lnum = prevnonblank(v:lnum - 1)

    " If the current line doesn't start with '\' and below a line that starts
    " with '\', use the indent of the line above it.
    if getline(v:lnum) !~ '^\s*\\'
        while lnum > 0 && getline(lnum) =~ '^\s*\\'
            let lnum = lnum - 1
        endwhile
    endif

    " At the start of the file use zero indent.
    if lnum == 0
        return 0
    endif

    " Add a 'shiftwidth' after :if, :while, :try, :catch, :finally, :function
    " and :else.  Add it three times for a line that starts with '\' after
    " a line that doesn't (or g:vim_indent_cont if it exists).
    let ind = indent(lnum)
    if getline(v:lnum) =~ '^\s*\\' && v:lnum > 1 && getline(lnum) !~ '^\s*\\'
        " 現在行のインデントと同じがいい
        let ind= ind
    elseif getline(lnum) =~ '\(^\||\)\s*\(if\|wh\%[ile]\|for\|try\|cat\%[ch]\|fina\%[lly]\|fu\%[nction]\|el\%[seif]\)\>'
        let ind = ind + &sw
    elseif getline(lnum) =~ '^\s*aug\%[roup]' && getline(lnum) !~ '^\s*aug\%[roup]\s*!\=\s\+END'
        let ind = ind + &sw
    endif

    " If the previous line contains an "end" after a pipe, but not in an ":au"
    " command.  And not when there is a backslash before the pipe.
    " And when syntax HL is enabled avoid a match inside a string.
    let line = getline(lnum)
    let i = match(line, '[^\\]|\s*\(ene\@!\)')
    if i > 0 && line !~ '^\s*au\%[tocmd]'
        if !has('syntax_items') || synIDattr(synID(lnum, i + 2, 1), "name") !~ '\(Comment\|String\)$'
            let ind = ind - &sw
        endif
    endif


    " Subtract a 'shiftwidth' on a :endif, :endwhile, :catch, :finally, :endtry,
    " :endfun, :else and :augroup END.
    if getline(v:lnum) =~ '^\s*\(ene\@!\|cat\|fina\|el\|aug\%[roup]\s*!\=\s\+END\)'
        let ind = ind - &sw
    endif

    return ind
endfunction
" }}}
function! s:first_match(expr, pat)
    let l:filtered= filter(a:expr, a:pat)

    if empty(l:filtered)
        return 'none'
    endif

    return l:filtered[0]
endfunction

if exists('s:gyokuro_constants') && has_key(s:gyokuro_constants, 'grepprgs')
    for s:candidate in s:gyokuro_constants.grepprgs
        if executable(s:candidate.grepprg)
            let &grepprg= join([s:candidate.grepprg, join(s:candidate.args, ' ')], ' ')
            break
        endif
    endfor
    unlet s:candidate
endif

" to edit .vimrc
if exists('s:gyokuro_constants') && get(s:gyokuro_constants, 'vimrc-edit-support', 0)
    command! GyokuroVimrcEdit execute 'edit' s:gyokuro_constants.vimrc
endif

if filereadable(expand('~/.vimrc.local'))
    source ~/.vimrc.local
endif

if executable('perl') && executable('perldoc')
    function! PerlModule(module)
        let l:relative_path= substitute(a:module, '::', '/', 'g')
        let l:relative_path= substitute(l:relative_path, '$', '.pm', '')
        let l:search_paths= system("perl -e '$,= q/,/; print @INC;'")

        return globpath(l:search_paths, l:relative_path)
    endfunction
endif

