" vim:foldmethod=marker:fen:
scriptencoding utf-8

" .vimrcで使用する設定値
let g:gyokuro_constants= {
            \   'temporary_dir': expand('~/.tmp/vim/'), 
            \   'dev-plugin-dir': '~/sources/vim-plugin/',
            \}

" plugin {{{
" neobundle {{{
if has('vim_starting')
    set runtimepath+=~/.bundle/neobundle.vim/
endif
call neobundle#rc(expand('~/.bundle/'))
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
NeoBundleLazy 'https://code.google.com/p/vimwiki/', {
            \   'type': 'hg', 
            \   'autoload': {
            \       'mappings': ['\ww', '\wt', '<Plug>VimwikiIndex', '<Plug>VimwikiTabIndex'], 
            \   }
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
" NeoBundle 'osyo-manga/vim-precious'
NeoBundle 'choplin/unite-vim_hacks', {
            \   'depends': ['Shougo/unite.vim', 'mattn/webapi-vim', 'mattn/wwwrenderer-vim', 'thinca/vim-openbuf'], 
            \}
NeoBundle 'fuenor/qfixhowm', {
            \}
NeoBundle 'osyo-manga/unite-qfixhowm', {
            \   'depends': ['Shougo/unite.vim', 'fuenor/qfixhowm'], 
            \}
NeoBundle 'mattn/qiita-vim'
" NeoBundle 'vim-jp/vital.vim'
NeoBundle 'KamunagiChiduru/vital.vim'

" 開発用
execute 'NeoBundleLocal '.g:gyokuro_constants['dev-plugin-dir']

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
            \ '%TITLE% %TAG%', 
            \ '%DATE%', 
            \ ''
            \ ]
let g:QFixHowm_SaveTime=  1
let g:QFixHowm_SplitMode= 1
let g:howm_dir=           '~/documents/qfixmemo'
let g:howm_fileencoding=  &encoding
let g:howm_fileformat=    &fileformat
let g:howm_filename=      '%Y/%m/%Y-%m-%d-%H%M%S'
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
    let g:neocomplcache_temporary_dir= g:gyokuro_constants['temporary_dir'].'/.neocomplcache/'
elseif has('win64') || has('win32') || has('win16')
    let g:neocomplcache_temporary_dir= g:gyokuro_constants['temporary_dir'].'/.neocomplcache/'
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
" let g:neocomplcache_force_omni_patterns['cpp']= '[^.[:digit:] *\t]\%(\.\|->\)\|::'
" let g:neocomplcache_force_omni_patterns['cpp']= '\.\|->\|::'
let g:neocomplcache_omni_functions= get(g:, 'neocomplcache_omni_functions', {})
let g:neocomplcache_omni_functions['java']= 'javacomplete#Complete'
let g:neocomplcache_vim_completefuncs= get(g:, 'neocomplcache_vim_completefuncs', {})
let g:neocomplcache_vim_completefuncs['java']= 'javacomplete#CompleteParamsInfo'

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
            \'_': 1, 
            \}
" }}}
" vimwiki {{{
let g:vimwiki_list= [{
            \'path'      : '~/documents/site/vimwiki/wiki/',
            \'path_html' : '~/documents/site/vimwiki/html/',
            \'syntax'    : 'markdown',
            \'ext'       : '.md',
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
let s:bundle= neobundle#get('vim-ref')
function! s:bundle.hooks.on_source(bundle)
    let g:ref_no_default_key_mappings= 1

    " 上書き
    nmap <silent><expr> K mapping#ref('normal')
    vmap <silent><expr> K mapping#ref('visual')
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
    let g:unite_data_directory= g:gyokuro_constants['temporary_dir'].'/.unite/'
" endfunction
" unlet s:bundle
" }}}
" gist {}{{
let s:bundle= neobundle#get('gist-vim')
function! s:bundle.hooks.on_source(bundle)
    " Only :w! updates a gist.
    let g:gist_update_on_write = 2
endfunction
unlet s:bundle
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
" }}}
" automatically make directory when write file {{{
augroup automatically_make_directory
    autocmd!
    autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
    function! s:auto_mkdir(dir, force)
        if !isdirectory(a:dir) && a:force
            call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
        endif
    endfunction
augroup END
" }}}
" auto open qfix window when make {{{
command! -nargs=* Make make <args> | cwindow 3
augroup automatically_open_qfixwindow
    autocmd!
    autocmd QuickFixCmdPost [^l]* nested cwindow
    autocmd QuickFixCmdPost    l* nested lwindow
augroup END
" }}}
" Ls {{{
command! -nargs=* Ls !ls <args>
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
    redir => output
    silent execute a:q_args
    redir END
    let output= substitute(output, '^\n\+', '', '')

    belowright new

    silent file `=printf('[Capture: %s]', a:q_args)`
    setlocal buftype=nofile bufhidden=unload noswapfile nobuflisted
    call setline(1, split(output, '\n'))
endfunction
" }}}
" on save action {{{
augroup on_save_action
    au!
    " autocmd BufWritePre * call s:trim_or_append_empty_line()
augroup END

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
" yank to remote {{{
" http://blog.remora.cx/2011/08/yank-to-local-clipboard-from-vim-on-screen.html
" let g:y2r_config = {
"             \   'tmp_file': expand('~/.tmp/vim/yank_remote'),
"             \   'key_file': expand('~/.tmp/vim/.yank_remote.key'),
"             \   'host': 'lady-grey.tea',
"             \   'port': 22,
"             \}
" function Yank2Remote()
"     call writefile(split(@*, '\n'), g:y2r_config['tmp_file'], 'b')
"     let s:params = ['cat %s %s | nc -w1 %s %s']
"     for s:item in ['key_file', 'tmp_file', 'host', 'port']
"         let s:params += [shellescape(g:y2r_config[s:item])]
"     endfor
"     let s:ret = system(call(function('printf'), s:params))
" endfunction
" nnoremap <silent> <unique> <Leader>y :call Yank2Remote()<CR>
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
cnoremap <C-D> <Del>
cnoremap <C-H> <Left>
cnoremap <C-L> <Right>
inoremap <C-D> <Del>
inoremap <C-H> <Left>
inoremap <C-J> <Down>
inoremap <C-K> <Up>
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
inoremap <C-[>                 <C-[><C-L>
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
" }}}
" filetype depended config {{{
augroup antlr3_filetype_config
    au!
    autocmd BufNewFile,BufRead *.g setl filetype=antlr3
augroup END
augroup tex_filetype_config
    au!
    autocmd BufEnter,BufReadPre *.tex setlocal filetype=tex
augroup END
augroup perl_filetype_config
    au!
    autocmd BufNewFile *.pl,*.cgi,*.t setlocal fileencoding=utf8
augroup END
augroup freemarker_config
    au!
    autocmd BufEnter,BufReadPre *.ftl setlocal filetype=ftl
augroup END
augroup load_vinarise
    autocmd!
    autocmd BufNewFile,BufReadPre * if &binary | NeoBundleSource vinarise
    autocmd BufNewFile,BufReadPre * endif
augroup END
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
let &backupdir= g:gyokuro_constants['temporary_dir'].',.'
set swapfile
" set directory=~/.tmp/vim/,.
let &directory= g:gyokuro_constants['temporary_dir'].',.'
" swpとbackupファイルの宛先がなければ作成
call s:make_dirs(&backupdir.','.&directory)
" 無限undo
if has('persistent_undo')
    " set undodir=~/.tmp/vim/undo/
    let &undodir= g:gyokuro_constants['temporary_dir'].'/undo/'
    set undofile

    call s:make_dirs(&undodir)
endif
" 全角スペースを視覚化
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=#666666
augroup hilighting_special_character
    autocmd!
    autocmd BufNewFile,BufRead * match ZenkakuSpace /　/
augroup END
" 全角文字のずれを修正
if exists('&ambiwidth')
    set ambiwidth=double
endif
" ファイル読み込み時のエンコーディング優先順
set fileencodings=iso-2022-jp,utf-8,cp932,euc-jp,default,latin
" 検索時に大文字小文字区別なし
set ignorecase
" statuslineを常に表示する
set laststatus=2
" swapfileを書き出す待ち時間
set updatetime=500
" }}}

