"
"
"	João Alexandre de Toledo
"	https://github.com/jalexandretoledo/
"
"
"

" Adding runtimepath for windows so we can use .vim instead of _vim
if !exists("g:loaded_runtime")
  set runtimepath=~/.vim,$VIMRUNTIME,~/.vim/bundle/vundle,~/.vim/after
  let g:loaded_runtime = 1
endif


set nocompatible		" be iMproved, required
filetype off			" required


"
" ===============================================================================
"  Vundle
" ===============================================================================
"
set rtp+=~/vimfiles/bundle/Vundle.vim/
call vundle#begin('~/vimfiles/')

" Keep Plugin commands between vundle#begin/end.
Plugin 'VundleVim/Vundle.vim'	" let Vundle manage Vundle


" Gui Plugins
if has("gui_running")
  Bundle 'bling/vim-airline'
  Bundle 'altercation/vim-colors-solarized.git'
endif

call vundle#end()		" required
filetype plugin indent on	" required

"
" ===============================================================================
"


" kj exits insert mode
:imap kj <ESC>			

" KJ also exits insert mode
:imap KJ <ESC>			

" replace current word with yanked text
nnoremap S "_diwP

" ????
nnoremap X diw"0P

set encoding=utf-8		" encoding :)

" Configura solarized
" color darkblue			" color desert
syntax enable
if has("gui_running")
  set background=light
else
  set background=dark
endif
let g:solarized_italic=0
colorscheme solarized

set rnu number			" relative line numbers
set numberwidth=5		" line number alignment -> doesn't work with solarized

source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin



set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

" Exibe uma DialogBox com o texto
" echom ">^.^<"
"

