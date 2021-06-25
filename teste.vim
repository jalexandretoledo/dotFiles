"
"    Created as an answer to https://vi.stackexchange.com/q/18843/11384
"
"    |...|...|...|...|...|...|...|...|...|...|...|
"    >...|...>...|...|...|...|...|...|...|...|...|
"    >...|...|>..|...|...|...|...|...|...|...|...|
"    >...|...|.>.|...|...|...|...|...|...|...|...|
"    >...|...|..>|...|...|...|...|...|...|...|...|
"    >...|...|...>...|...|...|...|...|...|...|...|
"    >...|...>...|...|>..>...>...>...>...|...|...|
"    >...|...|>..|...|.>.|.>.|.>.|.>.|...|...|...|
"    >...|...|.>.|...|..>|..>|..>|..>|...|...|...|
"    >...|...|..>|...|...>...>...|...>...|...|...|
"    >...|...|...>...|...|...>...|..>|.>.|>..|...|
"    |...|...|...|...|...|...|...|...|...|...|...|
"
" :%s/>\.*/\t/g
" :call ReplaceMiddleTabs()
" :%s/\t/>###/g
"
"
function! ReplaceMiddleTabs() abort
    let s:linenum = line('.')
    let s:current_line = getline(s:linenum)
    let s:temp = Format_tabs(s:current_line)
    call setline(s:linenum, s:temp)
endfunction

function! Format_tabs(line)
    let s:tablen = &ts
    let s:start = match(a:line, '^\s\+\zs.\ze')

    let s:temp = a:line
    let s:control = 1
    while s:control > 0
        let s:next = match(s:temp, '\t', s:start + 1)
        if s:next > 0
            let s:mod = (s:next % s:tablen)
            if s:mod == 0
                let s:mod = 4
            endif
            let s:substlen = s:tablen - s:mod + 1

            let s:temp = s:temp[0:s:next - 1] . repeat(' ', s:substlen) . s:temp[s:next + 1:]
        else
            let s:control = 0
        endif
    endwhile

    return s:temp
endfunction


" 
" 
" .....0.....
" .....1.....
" ...........<-------unknown number of lines, the 6th column is not blank
" .....3.....
" .....4.....
" .....5.....<-------your cursor at 5
" .....6.....
" .....7.....
" ...........<-------unknown number of lines, the 6th column is not blank
" .....9.....
" .....0.....
" 
" 

function! SeekUp(to_search)
    let s:col = col('.')
    if s:col < col('$') - 1
        let s:row = line('.')
        let s:char = getline(s:row)[s:col - 1]
        echom 'Searching for '. s:char

        let s:prev_found = ''
        let s:previous_row = s:row - 1
        while s:previous_row > 0
            " echom 'Verifying line ' . s:previous_row
            let s:current = getline(s:previous_row)

            if len(s:current) >= s:col
                let s:char_at_pos = s:current[s:col - 1]
                " echom 'Found ' . s:char_at_pos
                if s:char_at_pos ==# a:to_search
                    " echom 'Done at line ' . s:previous_row
                    let s:prev_found = s:char_at_pos
                endif
            else
                break
            endif

            let s:previous_row = s:previous_row - 1
        endwhile

        if (s:prev_found !=# '')
            echom 'Last up is at row ' . s:previous_row 
            
        endif

        let s:next_row = s:row + 1
        let s:last_row = line('$')
        while s:next_row <= s:last_row
            " echom 'Verifying line ' . s:next_row
            let s:current = getline(s:next_row)

            if len(s:current) >= s:col
                let s:char_at_pos = s:current[s:col - 1]
                " echom 'Found ' . s:char_at_pos
                if s:char_at_pos ==# a:to_search
                    " echom 'Done at line ' . s:next_row
                    let s:next_found = s:char_at_pos
                endif
            else
                break
            endif

            let s:next_row = s:next_row + 1
        endwhile

        if (s:next_found !=# '')
            echom 'Last down is at row ' . s:next_row 
        endif

        if (s:prev_found !=# '')
            if (s:next_found !=# '')
                echom 'Found from ' . s:previous_row . ' to ' . s:next_row . ' -> [' . s:prev_found . '][' . s:next_found . ']'
            endif
        endif
    endif


endfunction
