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
filetype plugin indent on

" packadd coc.nvim

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
set shiftround
set expandtab

set encoding=utf-8		" encoding :)

set belloff=all         " desativa avisos sonoros

" 2023-04-05
set smartindent

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
nnoremap ]d :bp\|bd# <enter>
nnoremap ]c :bd % <enter>

""" Reload current buffer (if not modified)
nnoremap ]r :e<CR>G

" Last *viewed* buffer
nnoremap ]v :b#<CR>

" List then choose
nnoremap ]b :ls<CR>:b<Space>

" reselect pasted text
nnoremap gp `[v`]

" \f : fold da tag que inicia na linha atual (XML)
nnoremap <leader>f 0f<lmb*mf'bzf'fj

" ===============================================================================
" Visual
" ===============================================================================


" Configura solarized
" color darkblue			" it could also be 'color desert'
" set background=dark
packadd nordtheme git
colorscheme nord

syntax enable

if has("gui_running")

  " packadd vim-colors-solarized.git
  " packadd vimcolors.git

  " let g:solarized_italic=0
  " colorscheme solarized
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
" set completeopt=menuone,noinsert,noselect
set shortmess+=c      " Don't give |ins-completion-menu| messages. 

" Always show the signcolumn
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

packadd coc.nvim

if exists('g:did_coc_loaded')
    " Comandos que dependem do coc-nvim devem ficar aqui;
    " caso contrário, acaba impactando também o VSVIM

    "" {{{coc-nvim config
    
    " Use tab for trigger completion with characters ahead and navigate
    " NOTE: There's always complete item selected by default, you may want to enable
    " no select by `"suggest.noselect": true` in your configuration file
    " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
    " other plugin before putting this into your config
    inoremap <silent><expr> <TAB>
          \ coc#pum#visible() ? coc#pum#next(1) :
          \ CheckBackspace() ? "\<Tab>" :
          \ coc#refresh()
    inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
    
    " Make <CR> to accept selected completion item or notify coc.nvim to format
    " <C-g>u breaks current undo, please make your own choice
    inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                                  \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
    
    function! CheckBackspace() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    " Use <c-space> to trigger completion.
    if has('nvim')
      inoremap <silent><expr> <c-space> coc#refresh()
    else
      inoremap <silent><expr> <c-@> coc#refresh()
    endif

    " Use `[g` and `]g` to navigate diagnostics
    nmap <silent> [g <Plug>(coc-diagnostic-prev)
    nmap <silent> ]g <Plug>(coc-diagnostic-next)

    " Remap keys for gotos
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    " Used to expand decorations in worksheets
    nmap <Leader>ws <Plug>(coc-metals-expand-decoration)

    " Use K to either doHover or show documentation in preview window
    nnoremap <silent> K :call ShowDocumentation()<CR>
    
    function! ShowDocumentation()
      if CocAction('hasProvider', 'hover')
        call CocActionAsync('doHover')
      else
        call feedkeys('K', 'in')
      endif
    endfunction

    " Highlight symbol under cursor on CursorHold
    autocmd CursorHold * silent call CocActionAsync('highlight')

    " Remap for rename current word
    nmap <leader>rn <Plug>(coc-rename)

    " Formatting selected code
    xmap <leader>f  <Plug>(coc-format-selected)
    nmap <leader>f  <Plug>(coc-format-selected)

    augroup mygroup
      autocmd!
      " Setup formatexpr specified filetype(s)
      autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')      
      " Update signature help on jump placeholder
      autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    augroup end

    " Applying code actions to the selected code block
    " Example: `<leader>aap` for current paragraph
    xmap <leader>a  <Plug>(coc-codeaction-selected)
    nmap <leader>a  <Plug>(coc-codeaction-selected)
    
    " Remap keys for applying code actions at the cursor position
    nmap <leader>ac  <Plug>(coc-codeaction-cursor)
    " Remap keys for apply code actions affect whole buffer
    nmap <leader>as  <Plug>(coc-codeaction-source)
    " Apply the most preferred quickfix action to fix diagnostic on the current line
    nmap <leader>qf  <Plug>(coc-fix-current)
    
    " Remap keys for applying refactor code actions
    nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
    xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
    nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
    
    " Run the Code Lens action on the current line
    nmap <leader>cl  <Plug>(coc-codelens-action)

    " Map function and class text objects
    " NOTE: Requires 'textDocument.documentSymbol' support from the language server
    xmap if <Plug>(coc-funcobj-i)
    omap if <Plug>(coc-funcobj-i)
    xmap af <Plug>(coc-funcobj-a)
    omap af <Plug>(coc-funcobj-a)
    xmap ic <Plug>(coc-classobj-i)
    omap ic <Plug>(coc-classobj-i)
    xmap ac <Plug>(coc-classobj-a)
    omap ac <Plug>(coc-classobj-a)
    
    " Remap <C-f> and <C-b> to scroll float windows/popups
    if has('nvim-0.4.0') || has('patch-8.2.0750')
      nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
      nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
      inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
      inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
      vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
      vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    endif
    
    " Use CTRL-S for selections ranges
    " Requires 'textDocument/selectionRange' support of language server
    nmap <silent> <C-s> <Plug>(coc-range-select)
    xmap <silent> <C-s> <Plug>(coc-range-select)
    
    " Add `:Format` command to format current buffer
    command! -nargs=0 Format :call CocActionAsync('format')
    
    " Add `:Fold` command to fold current buffer
    command! -nargs=? Fold :call     CocAction('fold', <f-args>)
    
    " Add `:OR` command for organize imports of the current buffer
    command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')
    
    " Add (Neo)Vim's native statusline support
    " NOTE: Please see `:h coc-status` for integrations with external plugins that
    " provide custom statusline: lightline.vim, vim-airline
    set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
    
    " Mappings for CoCList
    " Show all diagnostics
    nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
    " Manage extensions
    nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
    " Show commands
    nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
    " Find symbol of current document
    nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
    " Search workspace symbols
    nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
    " Do default action for next item
    nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
    " Do default action for previous item
    nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
    " Resume latest coc list
    nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>    

    "coc-nvin config }}}
endif

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

"
" https://vim.fandom.com/wiki/Insert-mode_only_Caps_Lock
"
" Insert and command-line mode Caps Lock.
" Lock search keymap to be the same as insert mode.
set imsearch=-1

" Load the keymap that acts like capslock.
set keymap=insert-only_capslock

" Turn it off by default.
set iminsert=0

" Cursor changes when CAPSLOCK is on
highlight Cursor guifg=NONE guibg=Green
highlight lCursor guifg=NONE guibg=Cyan

" Kill the capslock when leaving insert mode.
autocmd InsertLeave * set iminsert=0
