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
" JAT, 2016-04-27: I don't know why, but Vundle suggests the bundle directory,
" but my configuration (at least on Windows) doesn't have it
set rtp+=~/vimfiles/Vundle.vim/
set rtp+=~/vimfiles/bundle/Vundle.vim/
call vundle#begin('~/vimfiles/')

" Keep Plugin commands between vundle#begin/end.
Plugin 'VundleVim/Vundle.vim'	" let Vundle manage Vundle







" ===============================================================================
" 	Google's vim-codefmt: https://github.com/google/vim-codefmt
" ===============================================================================
"
" Add maktaba and codefmt to the runtimepath.
" (The latter must be installed before it can be used.)
Plugin 'google/vim-maktaba'
Plugin 'google/vim-codefmt'

" Also add Glaive, which is used to configure codefmt's maktaba flags. See
" `:help :Glaive` for usage.
Plugin 'google/vim-glaive'





" ===============================================================================
" Gui Plugins
" ===============================================================================
if has("gui_running")
  Bundle 'bling/vim-airline'
  Bundle 'altercation/vim-colors-solarized.git'
endif

call vundle#end()		" required
filetype plugin indent on	" required





" ===============================================================================
" 	Finish Google's vim-codefmt configuration
" ===============================================================================
" the glaive#Install() should go after the "call vundle#end()"
call glaive#Install()
" Optional: Enable codefmt's default mappings on the <Leader>= prefix.
Glaive codefmt plugin[mappings]







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

" \+L
nnoremap <leader>l :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>

set encoding=utf-8		" encoding :)

" Configura solarized
" color darkblue			" color desert
syntax enable
if has("gui_running")
  "set background=light
  set background=dark
  let g:solarized_italic=0
  colorscheme solarized

  if has("gui_w32")
    source $HOME/.gvimrc
  endif
endif

set rnu number			" relative line numbers
set numberwidth=5		" line number alignment -> doesn't work with solarized
set cursorline			" highlight current line

source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin


set nobackup			" I've never needed this backup... after all, we user versioning system for that :)

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

