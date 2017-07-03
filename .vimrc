"
"
"	João Alexandre de Toledo
"	https://github.com/jalexandretoledo/
"
"
"

" Adding runtimepath for windows so we can use .vim instead of _vim
if !exists("g:loaded_runtime")
  set runtimepath=~/.vim,$VIMRUNTIME,~/.vim/bundle,~/.vim/after
  let g:loaded_runtime = 1
endif


set nocompatible		" be iMproved, required
filetype off			" required


"
" ===============================================================================
"  Vundle
" ===============================================================================
"
" JAT, 2017-06-15: Vundle plugings will be put under ~/.vim/bundle
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin('~/.vim/bundle/')

" Keep Plugin commands between vundle#begin/end.
Plugin 'VundleVim/Vundle.vim'	" let Vundle manage Vundle





" ===============================================================================
" 	Essential
" ===============================================================================
Plugin 'tpope/vim-surround'



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
" Erlang
" ===============================================================================
Plugin 'vim-erlang/vim-erlang-runtime'
Plugin 'vim-erlang/vim-erlang-compiler'
Plugin 'vim-erlang/vim-erlang-omnicomplete'
Plugin 'vim-erlang/vim-erlang-tags'

" ===============================================================================
" Python 
" (see https://realpython.com/blog/python/vim-and-python-a-match-made-in-heaven/)
" ===============================================================================
" Plugin 'scrooloose/nerdtree'
Plugin 'Konfekt/FastFold'
Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim'

" Plugin 'Valloric/YouCompleteMe'


" Plugin 'scrooloose/syntastic'
Plugin 'nvie/vim-flake8'

" ===============================================================================
" Python (at work)
" ===============================================================================
Plugin 'w0rp/ale'
Plugin 'davidhalter/jedi-vim'
" Plugin 'Valloric/YouCompleteMe'



" ===============================================================================
" FSharp
" ===============================================================================
Plugin 'fsharp/vim-fsharp'
" Plugin 'vim-syntastic/syntastic'
" Plugin 'ervandew/supertab'


" ===============================================================================
" Experimental
" ===============================================================================
Plugin 'coderifous/textobj-word-column.vim'
Plugin 'wellle/targets.vim'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-speeddating'



" ===============================================================================
" Gui Plugins
" ===============================================================================
if has("gui_running")
  Bundle 'bling/vim-airline'
  Bundle 'altercation/vim-colors-solarized.git'
  " Bundle 'bounceme/poppy.vim'
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

" \l   (\ + lower L)
nnoremap <leader>l :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>

" Fonte: http://vim.wikia.com/wiki/Highlight_current_line
" Highlight the current line and keep it highlighted after the cursor is
" moved; it also sets mark h so you can type 'h to come back to the line;
" enter :match to clear the highlighting
"
nnoremap <silent> <Leader>h mh:execute 'match Search /\%'.line('.').'l/'<CR>

" \d    delete to the black hole register
" source: https://www.reddit.com/r/vim/comments/6fujzj/easier_access_to_the_black_hole_register/dil4kro/
nnoremap <leader>d "_d

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
else
  if has("macunix")
    "
    highlight CursorLine ctermbg=DarkBlue
  else
    highlight CursorLine ctermbg=DarkBlue
  endif
endif

if has("macunix")
        " for now disable cursorline
        set cursorline			" highlight current line
else
        set cursorline			" highlight current line
endif

set rnu number			" relative line numbers
set numberwidth=5		" line number alignment -> doesn't work with solarized
set expandtab			" expand tabs into spaces


" ===============================================================================
" Python configuration
" (see https://realpython.com/blog/python/vim-and-python-a-match-made-in-heaven/)
" ===============================================================================
" let g:ycm_autoclose_preview_window_after_completion=1
" map <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>
let python_highlight_all=1

if has("win32")
  source $VIMRUNTIME/vimrc_example.vim
  source $VIMRUNTIME/mswin.vim
  behave mswin
  " echom ">^.^<"
endif


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

