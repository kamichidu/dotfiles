let s:save_cpo= &cpo
set cpo&vim

let s:action_add= {
\   'is_selectable': 1,
\}

function! s:action_add.func(candidates)
    let candidates= (type(a:candidates) == type([])) ? a:candidates : [a:candidates]

    let modules= map(copy(candidates), 'v:val.action__module')
    let name= fnamemodify(getcwd(), ':t')

    if confirm('Are you okay to vitalize with `' . name . "'", "&Yes\n&No") == 2
        let name= input('input name for vitalize: ')
    endif

    if !empty(name)
        execute 'Vitalize' '--name=' . name '.' join(map(modules, '"+" . v:val'), ' ')
    else
        echomsg 'skipped'
    endif
endfunction

let s:vitalizer= {
\   'name': 'vitalize2/add',
\   'action_table': {
\       'vitalize': s:action_add,
\   },
\   'default_action': 'vitalize',
\}

function! s:vitalizer.gather_candidates(args, context)
    return map(copy(vitalizer#complete('', 'Vitalize . ', 12)), "
    \   {
    \       'word': v:val,
    \       'action__module': v:val,
    \   }
    \")
endfunction

let s:action_delete= {
\   'is_selectable': 1,
\}

function! s:action_delete.func(candidates)
    let candidates= (type(a:candidates) == type([])) ? a:candidates : [a:candidates]

    let modules= map(copy(candidates), 'v:val.action__module')

    if confirm('Are you okay to remove these items?', "&Yes\n&No") == 1
        execute 'Vitalize' '.' join(map(modules, '"-" . v:val'), ' ')
    else
        echomsg 'skipped'
    endif
endfunction

let s:deleter= {
\   'name': 'vitalize2/delete',
\   'action_table': {
\       'vitalize': s:action_delete,
\   },
\   'default_action': 'vitalize',
\}

function! s:deleter.gather_candidates(args, context)
    let vital_file= glob('autoload/vital/*.vital')

    if !filereadable(vital_file)
        return []
    endif

    let modules= readfile(vital_file)[3 : ]

    return map(modules, "
    \   {
    \       'word': v:val,
    \       'action__module': v:val,
    \   }
    \")
endfunction

function! unite#sources#vitalize2#define()
    return [deepcopy(s:vitalizer), deepcopy(s:deleter)]
endfunction

let &cpo= s:save_cpo
unlet s:save_cpo
