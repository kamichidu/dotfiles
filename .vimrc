" vim:foldmethod=marker:fen:
scriptencoding utf-8

" plugin {{{
" vim-ref {{{
let g:ref_use_vimproc= 1
let g:ref_jscore_path= ''
let g:ref_jsdom_path=  ''
let g:ref_html_path=   $HOME.'/documents/vim-ref-doc/www.aptana.com/reference/html/api/'
let g:ref_html5_path=  $HOME.'/documents/vim-ref-doc/www.html5.jp/tag/elements/'
" }}}
" neobundle {{{
filetype off
filetype plugin indent off

if has('vim_starting')
    set runtimepath+=~/.bundle/neobundle.vim/
    call neobundle#rc(expand('~/.bundle/'))
endif
" let NeoBundle manage NeoBundle
" required!
NeoBundle 'Shougo/neobundle.vim'
" recommended to install
NeoBundle 'Shougo/vimproc', {
            \'build': {
            \   'unix': 'make -f make_unix.mak', 
            \   }, 
            \}
" after install, turn shell ~/.bundle/vimproc, (n,g)make -f your_machines_makefile
NeoBundle 'DrawIt'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimshell', {
            \'depends': ['Shougo/unite.vim', 'Shougo/vimproc'], 
            \}
NeoBundle 'Shougo/vimfiler', {
            \'depends': ['Shougo/unite.vim', 'Shougo/vimproc'], 
            \}
NeoBundle 'Shougo/neosnippet', {
            \'depends': ['Shougo/neocomplcache'], 
            \}
NeoBundle 'autodate.vim'
NeoBundle 'mattn/gist-vim'
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
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'thinca/vim-quickrun'
" NeoBundle 'git://github.com/tyru/vim-altercmd.git'
NeoBundle 'kana/vim-tabpagecd'
NeoBundleLazy 'https://code.google.com/p/vimwiki/', {
            \   'type': 'hg', 
            \   'autoload': {
            \       'mappings': ['\\ww', '\\wt', '<Plug>VimwikiIndex', '<Plug>VimwikiTabIndex'], 
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
NeoBundleLazy 'javacomplete', {
            \   'autoload': {
            \       'filetypes': ['java'], 
            \   },
            \}
NeoBundle 'majutsushi/tagbar'
" required!
filetype plugin indent on
" }}}
" project.vim {{{
" flag description
"	b	When present, use the |browse()| when selecting directories
"		for \c and \C.  This is off by default for Windows, because
"		the windows browser does not allow you to select directories.
"
"	c	When present, the Project Window will automatically close when
"		you select a file.
"
"	F	Float the Project Window.  That is, turn off automatic
"		resizing and placement.  This allows placement between other
"		windows that wish to share similar placement at the side of
"		the screen.  It is also particularly helpful for external
"		window managers.
"
"	g	When present, the mapping for <F12> will be created to toggle
"		the Project Window open and closed.
"
"	i	When present, display the filename and the current working
"		directory in the command line when a file is selected for
"		opening.
"
"	l	When present, the Project Plugin will use the |:lcd| command
"		rather than |:cd| to change directories when you select a file
"		to open.  This flag is really obsolete and not of much use
"		because of L below.
"
"	L	Similar to l, but install a BufEnter/Leave |:autocommand| to
"		ensure that the current working directory is changed to the
"		one specified in the fold CD specification whenever that
"		buffer is active.  (|:lcd| only changes the CWD for a window,
"		not a buffer.)
"
"	m	Turn on mapping of the |CTRL-W_o| and |CTRL-W_CTRL_O| normal
"	        mode commands to make the current buffer the only visible
"		buffer, but keep the Project Window visible, too.
"
"	n	When present, numbers will be turned on for the project
"	        window.
"
"	s	When present, the Project Plugin will use syntax highlighting
"		in the Project Window.
"
"	S	Turn on sorting for refresh and create.
"
"	t	When present, toggle the size of the window rather than just
"		increase the size when pressing <space> or right-clicking.
"		See the entry for <RightMouse> in |project-mappings|.
"
"	T	When present, put Subproject folds at the top of the fold when
"		refreshing.
"
"	v	When present, use :vimgrep rather than :grep when using \G.
let g:proj_flags="imsStc"
nmap <silent> ,p <Plug>ToggleProject
nmap <silent> ,P :Project<CR>
" git add
let g:proj_run1='!git add %f'
let g:proj_run_fold1='*!git add %f'
" git checkout
let g:proj_run2='!git checkout -- %f'
let g:proj_run_fold2='*!git checkout -- %f'
" git status
let g:proj_run3='!git status'
augroup vim_project_open
    autocmd!
    autocmd BufAdd .vimprojects silent! %foldopen!
augroup END
" }}}
" qfixhowm {{{
set runtimepath+=~/.vim/plugin/qfixapp

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
let g:howm_filename=      '%Y/%m/%Y-%m%d-%H%M%S'
" }}}
" open browser {{{
let g:netrw_nogx= 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)
" }}}
" quickrun {{{
let g:quickrun_config= get(g:, 'quickrun_config', {})
let g:quickrun_config._= {
            \   'runner'                    : 'vimproc',
            \   'runner/vimproc/sleep'      : 50,
            \   'runner/vimproc/updatetime' : 100,
            \}
let g:quickrun_config.perl= {
            \   'type'                     : 'perl',
            \   'outputter'                : 'buffer',
            \   'outputter/close_on_empty' : 1,
            \}
let g:quickrun_config.vimwiki= {
            \   'type'                     : 'vimwiki',
            \   'outputter'                : 'buffer',
            \   'outputter/close_on_empty' : 1,
            \   'command'                  : $HOME.'/local/markdown/1.0.1/Markdown.pl',
            \}
let g:quickrun_config.perl6= {
            \   'type'                     : 'perl6',
            \   'outputter'                : 'buffer',
            \   'outputter/close_on_empty' : 1,
            \   'command'                  : $HOME.'/perl6.rakudo/rakudo/perl6',
            \}
" }}}
" neocomplcache {{{
let g:neocomplcache_enable_at_startup= 1
let g:neocomplcache_use_vimproc=       1
let g:neocomplcache_enable_wildcard=   1
let g:neocomplcache_enable_camel_case_completion= 1
let g:neocomplcache_enable_underbar_completion=   1
let g:neocomplcache_enable_ignore_case= 1
let g:neocomplcache_enable_smart_case=  1
" キャッシュ置き場
if has('unix')
    let g:neocomplcache_temporary_dir= $HOME.'/.tmp/vim/.neocomplcache/'
elseif has('win64') || has('win32') || has('win16')
    let g:neocomplcache_temporary_dir= $TEMP.'/vim/.neocomplcache/'
endif
" シンタックス補完はうざいのでいらない
let g:neocomplcache_disabled_sources_list= get(g:, 'neocomplcache_disabled_sources_list', {})
let g:neocomplcache_disabled_sources_list['_']= ['syntax_complete']
" 関数補完時の区切り文字
let g:neocomplcache_delimiter_patterns= get(g:, 'neocomplcache_delimiter_patterns', {})
let g:neocomplcache_delimiter_patterns['cpp']= ['\.', '->', '::']
let g:neocomplcache_delimiter_patterns['java']= ['\.']
" インクルード補完用
let g:neocomplcache_include_exprs= get(g:, 'neocomplcache_include_exprs', {})
let g:neocomplcache_include_exprs['perl']= 'substitute(v:fname, ''::'', ''/'', ''g'')'
let g:neocomplcache_include_exprs['cpp']=  'substitute(v:fname, ''::'', ''/'', ''g'')'
let g:neocomplcache_include_exprs['java']= 'substitute(v:fname, ''\.'', ''/'', ''g'')'
let g:neocomplcache_include_patterns= get(g:, 'neocomplcache_include_patterns', {})
let g:neocomplcache_include_patterns['java']= '^\s\*import'
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
cnoremap <C-D>             <Del>
cnoremap <C-H>             <Left>
cnoremap <C-L>             <Right>
inoremap <C-D>             <Del>
inoremap <C-H>             <Left>
inoremap <C-J>             <Down>
inoremap <C-K>             <Up>
inoremap <C-L>             <Right>
" prefix-tag for insert-mode
inoremap <SID>[tag] <Nop>
imap     <Leader>   <SID>[tag]
" prefix-tag for normal-mode
nnoremap <SID>[tag] <Nop>
nmap     <Leader>   <SID>[tag]
inoremap <SID>[tag]<Leader>  <Leader>
inoremap <SID>[tag]H         <Home>
inoremap <SID>[tag]e         <End>
inoremap <SID>[tag]h         <Esc>I
nnoremap <silent><SID>[tag]tt   :tabnew<CR>
nnoremap <silent><SID>[tag]ubo  :Unite bookmark<CR>
nnoremap <silent><SID>[tag]ubu  :Unite buffer<CR>
nnoremap <silent><SID>[tag]vf   :VimFiler<CR>
nnoremap <expr><SID>[tag]cl     <SID>toggle_cursorline()
nnoremap <expr><SID>[tag]ve     <SID>toggle_virtualedit()
nnoremap <silent><SID>[tag]o    :TagbarToggle<CR>
nnoremap <silent><C-H>     :nohlsearch<CR>
nnoremap <silent><C-N>     :tabn<CR>
nnoremap <silent><C-P>     :tabN<CR>
nnoremap zl                zL
nnoremap zh                zH
nnoremap <C-CR>              i<CR><Esc>
inoremap <C-[>             <C-[><C-L>
vnoremap <                 <gv
vnoremap >                 >gv
imap <expr><Tab> neosnippet#expandable_or_jumpable() ? 
            \"\<Plug>(neosnippet_expand_or_jump)" : 
            \"\<Tab>"
smap <expr><Tab> neosnippet#expandable_or_jumpable() ?
            \"\<Plug>(neosnippet_expand_or_jump)" :
            \"\<Tab>"
" }}}
" color {{{
colorscheme peachpuff
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
set backupdir=~/.tmp/vim/,.
set swapfile
set directory=~/.tmp/vim/,.
" swpとbackupファイルの宛先がなければ作成
call s:make_dirs(&backupdir.','.&directory)
" 無限undo
if has('persistent_undo')
    set undodir=~/.tmp/vim/undo/
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
" }}}

