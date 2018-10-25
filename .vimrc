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
Plugin 'tpope/vim-sensible'



" ===============================================================================
" Not essential at all... But it's cuttie
" ===============================================================================
Plugin 'bling/vim-airline'


" ===============================================================================
""" Experimental
" ===============================================================================
""" General Functionality
Plugin 'davidhalter/jedi-vim'
Plugin 'lifepillar/vim-mucomplete'
Plugin 'tmhedberg/SimpylFold'
Plugin 'Konfekt/FastFold'
Plugin 'nvie/vim-flake8'
Plugin 'tpope/vim-apathy'

Plugin 'ludovicchabant/vim-lawrencium'

"" Plugin 'jalvesaq/Nvim-R'
"" Plugin 'scrooloose/syntastic'
"" Plugin 'sirver/ultisnips'
"" Plugin 'honza/vim-snippets'
"" Plugin 'tpope/vim-commentary'
"" Plugin 'chiel92/vim-autoformat'

Plugin 'jalexandretoledo/visSum.vim'

Plugin 'jamessan/vim-gnupg'
"" Plugin 'vim-scripts/gnupg.vim'

"Plugin 'hoffstein/vim-tsql'
Plugin 'vim-scripts/sqlserver.vim'

" ===============================================================================
" Powershell
" ===============================================================================
Plugin 'PProvost/vim-ps1'

" ===============================================================================
" FSharp
" ===============================================================================
Plugin 'fsharp/vim-fsharp'

" ===============================================================================
" Gui Plugins
" ===============================================================================
if has("gui_running")
  Plugin 'altercation/vim-colors-solarized.git'
  Plugin 'elmindreda/vimcolors.git'
endif

call vundle#end()		" required
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

" if dotfiles are hidden, then how can I go to the parent directory?
" let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+' " hide dotfiles

let g:netrw_hide = 1 " hide dotfiles by default
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
nnoremap <leader>b :ls <enter>
nnoremap gp :bp <enter>
nnoremap gn :bn <enter>

" Last *viewed* buffer
nnoremap gh :b#<CR>

" List then choose
nnoremap gb :ls<CR>:b<Space>


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
  let g:solarized_italic=0
  colorscheme solarized
  " colorscheme phosphor
  " colorscheme elmindreda

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
  " source $VIMRUNTIME/vimrc_example.vim
  " source $VIMRUNTIME/mswin.vim
  " behave mswin
  " echom ">^.^<"
 

  " Vim is still compiled to be run with Python 3.5...
  " However, this is not guaranteed to work
  set pythonthreedll=python36.dll

  "
  " https://github.com/davidhalter/jedi-vim/issues/870
  py3 import os; sys.executable=os.path.join(sys.prefix, 'python.exe')
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

inoremap <expr> <c-e> mucomplete#popup_exit("\<c-e>")
inoremap <expr> <c-y> mucomplete#popup_exit("\<c-y>")
inoremap <expr>  <cr> mucomplete#popup_exit("\<cr>")

let g:mucomplete#enable_auto_at_startup = 0


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


"
" Utiliza o módulo json.tool do Python3 para formatar o range de linhas
" informado. Cuidado! A versão do módulo distribuída com o Python2 muda
" reordena os ítens!
"
" Fonte: https://stackoverflow.com/questions/16620835/how-to-fix-json-indentation-in-vim
"
command! -range -nargs=0 -bar JsonTool <line1>,<line2>!py -3 -m json.tool

noremap <silent> <leader>I :call <sid>ilist_qf(0)<CR>
" noremap <silent> ]I :call <sid>ilist_qf(1)<CR>
