if has("gui_gtk2")
    set guifont=Ubuntu\ Mono\ 15
elseif has("gui_win32")
    set guifont=Consolas:h11:cDEFAULT
elseif has("gui_macvim")
    set guifont=Menlo\ Regular:h14
endif

set guioptions-=m " Turn off menubar
set guioptions-=T " Turn off toolbar
set guioptions-=r " Turn off right-hand scrollbar
set guioptions-=R " Turn off right-hand scrollbar when split
set guioptions-=L " Turn off left-hand scrollbar
set guioptions-=l " Turn off left-hand=scrollbar when split
set guicursor+=a:blinkon0 " Turn off blinking cursor

function! Projetor() abort
    if has("gui_gtk2")
        set guifont=Ubuntu\ Mono\ 18
    elseif has("gui_win32")
        set guifont=Consolas:h16:cDEFAULT
    elseif has("gui_macvim")
        set guifont=Menlo\ Regular:h18
    endif

    colorscheme zellner
    set background=light
endfunction
