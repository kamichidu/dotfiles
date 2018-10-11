scriptencoding utf-8

"
" Concepts:
"   - Can use this for windows, mac, linux
"   - Speed is most important
"
if has('win64') || has('win32') || has('win16') || has('win95')
    set encoding=utf8 termencoding=cp932 fileformats=unix,dos,mac
elseif has('win32unix') " mintty
    set encoding=utf8 termencoding=cp932 fileformats=unix,dos,mac
elseif has('unix')
    set encoding=utf8 termencoding=utf8 fileformats=unix,dos,mac
endif
if exists('+shellslash')
    set shellslash
endif

let g:loaded_javacomplete= 1

" XXX: special constants
let s:debug= get(g:, 'debug', 0)

" disable mswin.vim
let g:skip_loading_mswin= 1

" constants for using .vimrc
let s:systype= has('win64') || has('win32') || has('win16') || has('win95')
\   ? 'windows'
\   : 'linux'
let s:tmpdir= expand('~/.tmp/vim/')

" Utility functions
function! s:mkdir(path)
    if !isdirectory(a:path)
        call mkdir(a:path, 'p')
    endif
    return a:path
endfunction

augroup gyokuro
    autocmd!
augroup END

syntax on

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
let &backupdir= s:mkdir(s:tmpdir . 'backup/') . ',.'
set swapfile
let &directory= s:mkdir(s:tmpdir . 'swap/') . ',.'
if has('persistent_undo')
    let &undodir= s:mkdir(s:tmpdir . 'undo/')
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
" set completeopt=menu
set completeopt=menuone
" no beep
set visualbell t_vb=
" don't move cursor when <C-D> and <C-U> and...
set nostartofline
set wildmode=longest:full,full wildmenu
" XXX: windows cmd/powershell is 16 colors
" set t_Co=256
set viminfo='20,<100
set history=50
set ruler
" auot-read file when it's modified by outside
set autoread
autocmd gyokuro WinEnter * checktime
set list listchars=tab:^I,trail:.

if executable('ag')
    let &grepprg= 'ag -n $*'
elseif executable('jvgrep')
    let &grepprg= 'jvgrep $*'
elseif executable('pt')
    let &grepprg= 'pt'
endif

if has('vim_starting')
    set runtimepath+=$HOME/dotfiles/hariti/
    runtime plugin/hariti.vim
endif
HaritiSetup

if get(g:hariti_bundles, 'ref', 0)
    let g:ref_use_vimproc= 1
    let g:ref_jscore_path= ''
    let g:ref_jsdom_path=  ''
    let g:ref_html_path=   $HOME . '/documents/vim-ref-doc/www.aptana.com/reference/html/api/'
    let g:ref_html5_path=  $HOME . '/documents/vim-ref-doc/www.html5.jp/tag/elements/'
endif

if get(g:hariti_bundles, 'memolist', 0) || isdirectory(expand('~/sources/github.com/kamichidu/memolist.vim/'))
    let g:memolist_path= expand('~/documents/memo/')
    let g:memolist_memo_suffix= 'mkd'
    " date format (default %Y-%m-%d %H:%M)
    let g:memolist_memo_date = "%Y-%m-%d %H:%M:%S"
    let g:memolist_template_content= []

    nnoremap <silent> g,c :<C-U>MemoNew<Space><C-R>=strftime('%H%M%S')<CR><CR>
    nnoremap <silent> g,t :<C-U>tabnew<CR>:<C-U>MemoNew<Space><C-R>=strftime('%H%M%S')<CR><CR>
    nnoremap g,l :<C-U>MemoList<CR>
    nnoremap g,g :<C-U>MemoGrep<CR>
endif

if get(g:hariti_bundles, 'open-browser', 0)
    let g:netrw_nogx= 1 " disable netrw's gx mapping.
    let g:openbrowser_browser_commands= [
    \   {
    \       'name': 'chrome',
    \       'args': ['{browser}', '{uri}'],
    \   },
    \   {
    \       'name': 'firefox',
    \       'args': ['{browser}', '{uri}'],
    \   },
    \]
    nmap gx <Plug>(openbrowser-smart-search)
    vmap gx <Plug>(openbrowser-smart-search)
endif

if get(g:hariti_bundles, 'quickrun', 0)
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

    if get(g:hariti_bundles, 'watchdogs', 0)
        let g:watchdogs_check_CursorHold_enables= {
        \   'java': 0,
        \}
        let g:watchdogs_check_BufWritePost_enables= {
        \   'java': 0,
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

if get(g:hariti_bundles, 'clang_complete', 0)
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

if get(g:hariti_bundles, 'neosnippet', 0)
    let g:neosnippet#snippets_directory= $HOME.'/.snippet/'
    let g:neosnippet#disable_runtime_snippets= {
    \   '_': 1,
    \}
    " super tab emu.
    imap <expr><Tab> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<Tab>"
    smap <expr><Tab> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<Tab>"
endif

if get(g:hariti_bundles, 'nerdtree', 0)
    nnoremap <silent> <Leader>nt :<C-U>NERDTreeToggle<CR>
endif

if get(g:hariti_bundles, 'ref', 0)
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

if get(g:hariti_bundles, 'tagbar', 0)
    let g:tagbar_left= 1
    let g:tagbar_autoclose= 1
    let g:tagbar_autofocus= 1
    let g:tagbar_show_visibility= 1
endif

if get(g:hariti_bundles, 'submode', 0)
    call submode#enter_with('winsize', 'n', '', '<C-W>>', '<C-W>>')
    call submode#enter_with('winsize', 'n', '', '<C-W><', '<C-W><')
    call submode#enter_with('winsize', 'n', '', '<C-W>-', '<C-W>-')
    call submode#enter_with('winsize', 'n', '', '<C-W>+', '<C-W>+')

    call submode#map('winsize', 'n', '', '>', '<C-W>>')
    call submode#map('winsize', 'n', '', '<', '<C-W><')
    call submode#map('winsize', 'n', '', '-', '<C-W>-')
    call submode#map('winsize', 'n', '', '+', '<C-W>+')
endif

" TODO: Purge unite
if get(g:hariti_bundles, 'unite', 0)
    let g:unite_data_directory= s:mkdir(s:tmpdir . '/unite/')

    if executable('ag')
        let g:unite_source_grep_command=       'ag'
        let g:unite_source_grep_default_opts=  '--nogroup --nocolor'
        let g:unite_source_grep_recursive_opt= ''
    endif
endif

if get(g:hariti_bundles, 'gist', 0)
    " Only :w! updates a gist.
    let g:gist_update_on_write = 2
endif

if get(g:hariti_bundles, 'TweetVim', 0)
    let g:tweetvim_tweet_per_page= 200
endif

if get(g:hariti_bundles, 'vimconsole', 0)
    let g:vimconsole#height= 20
    let g:vimconsole#maximum_caching_objects_count= 10000

    nnoremap <silent> <Leader>vc :<C-U>call<Space>vimconsole#wintoggle()<CR>

    function! s:configure_vimconsole()
        nmap <buffer> <C-L> <Plug>(vimconsole_redraw)
        nmap <buffer> <Del> <Plug>(vimconsole_clear)
    endfunction

    autocmd gyokuro BufEnter * call s:configure_vimconsole()
endif

if get(g:hariti_bundles, 'textobj-between', 0)
    let g:textobj_between_no_default_key_mappings= 1

    " http://d.hatena.ne.jp/thinca/20100614/1276448745
    omap iF <Plug>(textobj-between-i)
    omap aF <Plug>(textobj-between-a)
    vmap iF <Plug>(textobj-between-i)
    vmap aF <Plug>(textobj-between-a)
endif

if get(g:hariti_bundles, 'choosewin', 0)
    nmap <C-W><C-W> <Plug>(choosewin)

    let g:choosewin_overlay_enable= 1
endif

if get(g:hariti_bundles, 'quickhl', 0)
    nmap <Leader>h <Plug>(quickhl-manual-this)
    vmap <Leader>h <Plug>(quickhl-manual-this)
endif

if get(g:hariti_bundles, 'altercmd', 0)
    call altercmd#load()

    AlterCommand perldoc        Ref perldoc
    AlterCommand unite          Unite
    AlterCommand ref            Unite ref
    AlterCommand man            Ref man
    " git-statusのように区切り文字入れたい
    AlterCommand gits[tatus] Gstatus
    AlterCommand gitd[iff] Gdiff
    AlterCommand gitb[lame] Gblame
endif

if get(g:hariti_bundles, 'j6uil', 0)
    let g:J6uil_updatetime=    500
    let g:J6uil_display_icon=  1
    let g:J6uil_echo_presence= 0

    nnoremap <silent> <Leader>l :<C-U>call ctrlp#init(ctrlp#j6uil#rooms#id())<CR>
endif

if get(g:hariti_bundles, 'javaclasspath', 0)
    let g:javaclasspath_config= get(g:, 'javaclasspath_config', {})
    let g:javaclasspath_config.standard= get(g:javaclasspath_config, 'standard', {})
    let g:javaclasspath_config.standard.libs= get(g:javaclasspath_config.standard, 'libs', []) + [{'path': 'lib/tools.jar'}]
    let g:javaclasspath_enable_auto_analyze= 1
endif

if get(g:hariti_bundles, 'alti', 0)
    let g:alti_prompt_mappings= get(g:, 'alti_prompt_mappings', {})
    let g:alti_prompt_mappings['PrtSelectMove("j")']= ['<Tab>']
    let g:alti_prompt_mappings['PrtSelectMove("k")']= ['<S-Tab>']
    let g:alti_prompt_mappings['PrtSelectMove("k")']= ['<S-Tab>']
    let g:alti_prompt_mappings['PrtSelectInsert()']=  ['<C-Y>']
endif

if get(g:hariti_bundles, 'calendar', 0)
    let g:calendar_google_calendar= 1
    let g:calendar_google_task= 1
endif

if get(g:hariti_bundles, 'komadori', 0)
endif

if get(g:hariti_bundles, 'ctrlp', 0)
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

    if get(g:hariti_bundles, 'ctrlp-gist', 0)
    endif
    if get(g:hariti_bundles, 'qiita', 0)
    endif
endif

if get(g:hariti_bundles, 'geeknote', 0)
    let g:GeeknoteFormat= 'markdown'
    let g:GeeknoteExplorerWidth= float2nr(&columns * 0.2)
endif

if get(g:hariti_bundles, 'previm', 0)
    let g:previm_enable_realtime= 1
    " XXX: unable to open preview in browser if vimproc disabled
    let g:previm_disable_vimproc= 0
    let g:previm_disable_filetypes= ['rst']
    if s:systype ==# 'windows'
        let g:previm_open_cmd= 'chrome --incognito'
    endif
endif

if get(g:hariti_bundles, 'operator-replace', 0)
    map _ <Plug>(operator-replace)
endif

if get(g:hariti_bundles, 'committia', 0)
    let g:committia_open_only_vim_starting= 0
endif

if get(g:hariti_bundles, 'incsearch', 0)
    map /  <Plug>(incsearch-forward)
    map ?  <Plug>(incsearch-backward)
    map g/ <Plug>(incsearch-stay)
endif

if get(g:hariti_bundles, 'jedi', 0)
    autocmd gyokuro FileType python let b:did_ftplugin= 1
    let g:jedi#auto_initialization= 1
    let g:jedi#popup_select_first= 0
    let g:jedi#popup_on_dot= 0
    let g:jedi#rename_command= "<C-K>R"
    let g:jedi#show_call_signatures= 2
endif

" if get(g:hariti_bundles, 'unite-javaimport', 0)
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

if get(g:hariti_bundles, 'textmanip', 0)
    vmap <C-H> <Plug>(textmanip-move-left)
    vmap <C-J> <Plug>(textmanip-move-down)
    vmap <C-K> <Plug>(textmanip-move-up)
    vmap <C-L> <Plug>(textmanip-move-right)
endif

if get(g:hariti_bundles, 'tsuquyomi', 0)
    let g:tsuquyomi_completion_detail= 1
endif

if get(g:hariti_bundles, 'go', 0)
    " stop modification for $GOPATH arbitrarily
    let g:go_autodetect_gopath= 0
endif

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

if executable('isort')
    command! GyokuroISort %!isort -
endif

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

inoremap <C-\>            <Leader>
inoremap <Leader><Leader> <Leader>
inoremap <Leader>H        <Home>
inoremap <Leader>e        <End>
inoremap <Leader>h        <Esc>I

" convinient tab window
nnoremap <silent> <Leader>tt :<C-U>tabnew<CR>
nnoremap <silent> <Leader>t0 :<C-U>call <SID>tabselect(0)<CR>
nnoremap <silent> <Leader>t1 :<C-U>call <SID>tabselect(1)<CR>
nnoremap <silent> <Leader>t2 :<C-U>call <SID>tabselect(2)<CR>
nnoremap <silent> <Leader>t3 :<C-U>call <SID>tabselect(3)<CR>
nnoremap <silent> <Leader>t4 :<C-U>call <SID>tabselect(4)<CR>
nnoremap <silent> <Leader>t5 :<C-U>call <SID>tabselect(5)<CR>
nnoremap <silent> <Leader>t6 :<C-U>call <SID>tabselect(6)<CR>
nnoremap <silent> <Leader>t7 :<C-U>call <SID>tabselect(7)<CR>
nnoremap <silent> <Leader>t8 :<C-U>call <SID>tabselect(8)<CR>
nnoremap <silent> <Leader>t9 :<C-U>call <SID>tabselect(9)<CR>
nnoremap <silent> <C-N>      :<C-U>tabn<CR>
nnoremap <silent> <C-P>      :<C-U>tabN<CR>
nnoremap <silent> <C-W>C     :<C-U>tabclose<CR>

" misc
nnoremap <expr> <Leader>cl  <SID>toggle_cursorline()
nnoremap <expr> <Leader>ve  <SID>toggle_virtualedit()
nnoremap <silent> <Leader>o :<C-U>TagbarToggle<CR>
nnoremap <silent> <C-H>     :<C-U>nohlsearch<CR>
nnoremap <silent> <C-L>     :<C-U>redraw<CR>

nnoremap zl                    zL
nnoremap zL                    zl
nnoremap zh                    zH
nnoremap zH                    zh
" keep center
nnoremap *                     *zzzv
nnoremap #                     #zzzv
nnoremap n                     nzzzv
nnoremap N                     Nzzzv
nnoremap ]c                    ]czz
nnoremap [c                    [czz

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

function! s:invoke_completefunc() abort
    if &l:filetype ==# 'vim'
        return "\<C-X>\<C-V>\<C-P>"
    else
        return "\<C-X>\<C-O>\<C-P>"
    endif
endfunction

" inoremap <C-F> <C-R>=pumvisible() ? "\<lt>C-Y>\<lt>C-X>\<lt>C-F>" : "\<lt>C-X>\<lt>C-F>"<CR>
inoremap <C-F> <C-X><C-F>
inoremap <expr> <C-L> <SID>invoke_completefunc()

" avoiding powershell <BS> moving cursor to left
" cnoremap <C-H> <Space><BS><Left>
" cnoremap <C-L> <Space><BS><Right>
cnoremap <C-Y> <Space><BS>

function! s:invoke_complete() abort
    if &l:filetype ==# 'vim'
        return "\<C-X>\<C-V>\<C-P>"
    else
        return "\<C-X>\<C-U>\<C-P>"
    endif
endfunction

function! GyokuroCompletefunc(findstart, base) abort
    if &omnifunc ==# ''
        return -1
    endif

    if a:findstart
        return call(&omnifunc, [a:findstart, a:base])
    else
        let candidates= call(&omnifunc, [a:findstart, a:base])
        if type(candidates) == type([])
            for candidate in candidates
                let candidate.icase= &ignorecase
            endfor
        endif
        return candidates
    endif
endfunction

set completefunc=GyokuroCompletefunc

inoremap <expr> <C-L> <SID>invoke_complete()
" avoid typo
inoremap <C-@> <Space>
inoremap <C-F> <C-X><C-F>

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
" TODO: make manager plugin for uncrustify
" autocmd gyokuro FileType java let &l:equalprg= 'uncrustify -c ~/dotfiles/uncrustify.conf/java.conf -l JAVA'
autocmd gyokuro BufNewFile,BufRead *.tsv setfiletype tsv
autocmd gyokuro BufNewFile,BufRead *.tgo setfiletype gotexttmpl

" When editing a file, always jump to the last cursor position
autocmd gyokuro BufReadPost * if line("'\"") > 0 && line ("'\"") <= line("$")
autocmd gyokuro BufReadPost *     exe "normal! g'\"zz"
autocmd gyokuro BufReadPost * endif

colorscheme hydrangea
if get(g:hariti_bundles, 'csapprox', 0)
    if has('vim_starting')
        autocmd gyokuro VimEnter * CSApprox!
    else
        CSApprox!
    endif
endif

let s:local_vimrc_filename= $MYVIMRC . '.local'
if filereadable(s:local_vimrc_filename)
    execute 'source' s:local_vimrc_filename
endif
