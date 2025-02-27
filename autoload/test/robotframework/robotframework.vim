if !exists('g:test#robotframework#file_pattern')
  let g:test#robotframework#file_pattern = '\v\.robot$'
endif

function! test#robotframework#test_file(file) abort
    return a:file =~# g:test#robotframework#file_pattern
endfunction

function! test#robotframework#build_position(type, position) abort
    if a:type ==# 'nearest'
        let name = s:nearest_test(a:position)
        if !empty(name)
            return [a:position['file'].'::'.name]
        else
            return [a:position['file']]
        endif
    elseif a:type ==# 'file'
        return [a:position['file']]
    else
        return []
    endif
endfunction

function! test#robotframework#build_args(args) abort
    return a:args
endfunction

function! test#robotframework#executable() abort
    return 'robot'
endfunction

function! s:nearest_test(position) abort
    let name = test#base#nearest_test(a:position, g:test#robotframework#patterns)
    return join(name['test'], '.')
endfunction
