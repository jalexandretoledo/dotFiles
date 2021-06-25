"
"
"	João Alexandre de Toledo
"	https://github.com/jalexandretoledo/
"
"
"
if !exists("g:loaded_runtime")
  set packpath+=~/.vim
  set runtimepath=~/.vim,$VIMRUNTIME
  let g:loaded_runtime = 1
endif

set nocompatible		" be iMproved, required
filetype off			" required

filetype plugin indent on	" required

" ===============================================================================
" Some experiments
" ===============================================================================
set hidden " Allow background buffers without saving
set splitright " Split to right by default

"" Text Wrapping
set textwidth=79
set colorcolumn=80
set nowrap

"" Search and Substitute
"" set gdefault " use global flag by default in s: commands
set hlsearch " highlight searches
set ignorecase 
set smartcase " don't ignore capitals in searches

"" Tabs
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

set encoding=utf-8		" encoding :)


" ===============================================================================
" NetRW
" ===============================================================================
let g:netrw_liststyle = 1 " Detail View
let g:netrw_sizestyle = "H" " Human-readable file sizes

let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+' " hide dotfiles
let g:netrw_hide = 1 " hide dotfiles by default; see :help netrw-a
let g:netrw_banner = 0 " Turn off banner

""" Explore in vertical split
nnoremap <Leader>e :Explore! <enter>

" ===============================================================================
" Key mappings
" ===============================================================================

" kj and KJ exit insert mode
inoremap kj <ESC>			
inoremap KJ <ESC>			

" replace current word with yanked text, discard current word
nnoremap S "_diwP

" replace current word with yanked text, yank current word
nnoremap X diw"0P

" \l   (\ + lower L)
nnoremap <leader>l :match<cr>:nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>

" Source: http://vim.wikia.com/wiki/Highlight_current_line
" Highlight the current line and keep it highlighted after the cursor is
" moved; it also sets mark h so you can type 'h to come back to the line;
" enter :match to clear the highlighting
"
nnoremap <silent> <Leader>h mh:execute 'match Search /\%'.line('.').'l/'<CR>

" \d    delete to the black hole register
" source: https://www.reddit.com/r/vim/comments/6fujzj/easier_access_to_the_black_hole_register/dil4kro/
nnoremap <leader>d "_d

" navigate between buffers
nnoremap ]b :ls <enter>
nnoremap ]p :bp <enter>
nnoremap ]n :bn <enter>

""" Reload current buffer (if not modified)
nnoremap ]r :e<CR>G

" Last *viewed* buffer
nnoremap ]v :b#<CR>

" List then choose
nnoremap ]b :ls<CR>:b<Space>


" \f : fold da tag que inicia na linha atual (XML)
nnoremap <leader>f 0f<lmb*mf'bzf'fj

" ===============================================================================
" Visual
" ===============================================================================


" Configura solarized
color darkblue			" it could also be 'color desert'
set background=dark

syntax enable

if has("gui_running")

  packadd vim-colors-solarized.git
  packadd vimcolors.git

  let g:solarized_italic=0
  colorscheme solarized
  " colorscheme phosphor
  " colorscheme elmindreda

  source $HOME/.gvimrc
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

"
" Utiliza o módulo json.tool do Python3 para formatar o range de linhas
" informado. Cuidado! A versão do módulo distribuída com o Python2 muda
" reordena os ítens!
"
" Fonte: https://stackoverflow.com/questions/16620835/how-to-fix-json-indentation-in-vim
"
" command! -range -nargs=0 -bar JsonTool <line1>,<line2> !python3 -m json.tool

if has("win32")
  " source $VIMRUNTIME/vimrc_example.vim
  " source $VIMRUNTIME/mswin.vim
  " behave mswin
  " echom ">^.^<"
 

  " Vim is still compiled to be run with Python 3.5...
  " However, this is not guaranteed to work
  " set pythonthreedll=python37.dll

  "
  " https://github.com/davidhalter/jedi-vim/issues/870
  py3 import os; sys.executable=os.path.join(sys.prefix, 'python.exe')

  "
  " JsonTool
  "
  command! -range -nargs=0 -bar JsonTool <line1>,<line2> !python -m json.tool

  " 
  " Increment/Decrement
  "
  " On Windows, C-a e C-x are used to select all and cut...
  "
  nnoremap <A-a> <C-a> 
  nnoremap <A-x> <C-x>

  " FINDSTR? No!
  set grepprg=grep
else
  command! -range -nargs=0 -bar JsonTool <line1>,<line2> !python3 -m json.tool
endif

" I've never needed this backup... after all, we user versioning system for that :)
set nobackup
set nowritebackup
set noswapfile

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Turn persistent undo on 
" "    means that you can undo even when you close a buffer/VIM
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
try
  set undodir=~/.vim/temp_dirs/undodir
  set undofile
catch
endtry


"" Autocompletion
" required by MUcomplete
set completeopt=menuone,noinsert,noselect
set shortmess+=c " Turn off completion messages

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 
" GnuPG config
" 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Tell the GnuPG plugin to armor new files.
let g:GPGPreferArmor=1

" Tell the GnuPG plugin to sign new files.
let g:GPGPreferSign=1

augroup GnuPGExtra
" Set extra file options.
    autocmd BufReadCmd,FileReadCmd *.\(gpg\|asc\|pgp\) call SetGPGOptions()
" Automatically close unmodified files after inactivity.
    autocmd CursorHold *.\(gpg\|asc\|pgp\) quit
augroup END

function! SetGPGOptions()
" Set updatetime to 1 minute.
    set updatetime=60000
" Fold at markers.
    set foldmethod=marker
" Automatically close all folds.
    set foldclose=all
" Only open folds with insert commands.
    set foldopen=insert
endfunction


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 
" show :ilist or ]I results in the quickfix window
" 
" source: https://www.reddit.com/r/vim/comments/1rzvsm/do_any_of_you_redirect_results_of_i_to_the/cdsvh8i/
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:ilist_qf(start_at_cursor)
  redir => output
    silent! exec 'normal! '.(a:start_at_cursor ? ']' : '[')."I"
  redir END
  let lines = split(output, '\n')
  if lines[0] =~ '^Error detected'
    echomsg "Could not find the word in file"
    return
  endif
  let [filename, line_info] = [lines[0], lines[1:-1]]
  "turn the :ilist output into a quickfix dictionary
  let qf_entries = map(line_info, "{
        \ 'filename': filename,
        \ 'lnum': split(v:val)[1],
        \ 'text': getline(split(v:val)[1])
        \ }")
  call setqflist(qf_entries)
  cwindow
endfunction

function! Outline()
    " My preferred outline mode
    setlocal foldmethod=expr
    setlocal foldexpr=getline(v\:lnum)=~'^\\s*$'?'0'\:'1'
    " setlocal foldcolumn=2
endfunction


noremap <silent> <leader>I :call <sid>ilist_qf(0)<CR>
" noremap <silent> ]I :call <sid>ilist_qf(1)<CR>
