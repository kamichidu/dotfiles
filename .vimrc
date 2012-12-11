" vim:foldmethod=marker:fen:
" scriptencoding utf-8

" plugin {{{
" vim-ref {{{
let g:ref_use_vimproc= 1
let g:ref_jscore_path= ''
let g:ref_jsdom_path=  ''
let g:ref_html_path=   $HOME . '/documents/vim-ref-doc/www.aptana.com/reference/html/api/'
let g:ref_html5_path=  $HOME . '/documents/vim-ref-doc/www.html5.jp/tag/elements/'
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
NeoBundle 'Shougo/vimproc'
" after install, turn shell ~/.bundle/vimproc, (n,g)make -f your_machines_makefile
NeoBundle 'DrawIt'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimshell'
NeoBundle 'autodate.vim'
NeoBundle 'mattn/gist-vim'
NeoBundle 'mattn/webapi-vim'
NeoBundle 'mattn/zencoding-vim'
NeoBundle 'quickhl.vim'
NeoBundle 'sudo.vim'
NeoBundle 'taglist.vim'
NeoBundle 'thinca/vim-ref'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'tyru/altercmd'
" NeoBundle 'git://github.com/tyru/vim-altercmd.git'
NeoBundle 'kana/vim-tabpagecd'
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
augroup VimProjectOpen
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
" neocomplcache {{{
let g:neocomplcache_enable_at_startup= 1
let g:neocomplcache_enable_wildcard=   1
let g:neocomplcache_enable_camel_case_completion= 1
let g:neocomplcache_enable_underbar_completion= 1
" }}}
" Align {{{
let g:Align_xstrlen= 3
" }}}
" vimwiki {{{
let g:vimwiki_list= [{
            \'path':      '~/documents/site/vimwiki/wiki',
            \'path_html': '~/documents/site/vimwiki/html',
            \'ext':       '.md',
            \}]
" }}}
" }}}
" mapping {{{
cnoremap <C-D>            <Del>
cnoremap <C-H>            <Left>
cnoremap <C-L>            <Right>
inoremap <C-D>            <Del>
inoremap <C-H>            <Left>
inoremap <C-J>            <Down>
inoremap <C-K>            <Up>
inoremap <C-L>            <Right>
inoremap <Leader><Leader> <Leader>
inoremap <Leader>H        <Home>
inoremap <Leader>e        <End>
inoremap <Leader>h        <Esc>I
nnoremap <silent>         ,t       :tabnew<CR>
nnoremap <silent>         <C-H>    :nohlsearch<CR>
nnoremap <silent>         <C-N>    :tabn<CR>
nnoremap <silent>         <C-P>    :tabN<CR>
noremap  <silent>         <C-O>    :Tlist<CR><C-w>h
vnoremap <                <gv
vnoremap >                >gv

" 時刻入力用のコマンド
inoremap <Leader>date <C-R>=strftime('%Y-%m-%d (%a)')<CR>
inoremap <Leader>time <C-R>=strftime('%H:%M:%S')<CR>
inoremap <Leader>now  <C-R>=strftime('%Y-%m-%d %H:%M:%S')<CR>
inoremap <Leader>w3cd <C-R>=strftime('%Y-%m-%dT%H:%M:%S+09:00')<CR>
" }}}
" color {{{
colorscheme peachpuff
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
set backupdir=/tmp/vim,.
set swapfile
set directory=/tmp/vim,.
" 全角スペースを視覚化
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=#666666
augroup Hilighting
    autocmd!
    autocmd BufNewFile,BufRead * match ZenkakuSpace /　/
augroup END
" }}}
" template {{{
augroup ReadTemplate
    autocmd!
    autocmd FileType perl,cgi :compiler perl
    autocmd BufNewFile *.pl,*.cgi 0r $HOME/templates/BufNewFile.pl
    autocmd BufNewFile *.pm       0r $HOME/templates/BufNewFile.pm
    autocmd BufNewFile *.h,*.hpp  0r $HOME/templates/BufNewFile.h
    autocmd BufNewFile *.c,*.cpp  0r $HOME/templates/BufNewFile.cpp
augroup END
" }}}
" command {{{
" altercmd {{{
call altercmd#define('perldoc', 'Unite ref/perldoc')
call altercmd#define('unite', 'Unite')
call altercmd#define('ref', 'Unite ref')
" }}}
" auto make directory when write file {{{
augroup AutoMakeDiectoryWhenWriteFile
    autocmd!
    autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
    function! s:auto_mkdir(dir, force)
        if !isdirectory(a:dir) && a:force
            call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
        endif
    endfunction
augroup END
" }}}
" Q {{{
command! -nargs=0 -complete=command Q qall
" }}}
" auto open qfix window when make {{{
command! -nargs=* Make make <args> | cwindow 3
augroup AutoOpenQFixWindow
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
" AlignReset {{{
command! -nargs=0 AlignReset call Align#AlignCtrl('default')
" }}}
" }}}

