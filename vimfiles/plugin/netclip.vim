if exists("loaded_netclip") || &cp
    finish
endif
let loaded_netclip = 1

let s:save_cpo = &cpo
set cpo&vim

function! s:share_clipboard(event) abort
    if index(['+', '*', 'c'], a:event.regname) < 0
        return
    endif
    let data = join(a:event.regcontents, "\n")
    let job = job_start(["netclip", "copy"])
    let stdin = job_getchannel(job)
    let stderr = job_getchannel(job)
    call ch_sendraw(stdin, data)
    call ch_close(stdin)
    while job_status(job) ==# 'run'
        sleep 10m
    endwhile
    if ch_canread(stderr)
        let err = ch_readraw(stderr)
        if err !=# ''
            echoerr err
        endif
    endif
endfunction

if executable('netclip')
    autocmd gyokuro TextYankPost * call s:share_clipboard(v:event)
endif

let &cpo = s:save_cpo
