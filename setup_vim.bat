
mkdir .vim\pack
pushd .vim\pack
git init

:: carregados na inicialização
git submodule add https://github.com/tpope/vim-surround               plugins/start/vim-surround
git submodule add https://github.com/tpope/vim-sensible               plugins/start/vim-sensible
git submodule add https://github.com/bling/vim-airline                plugins/start/vim-airline
git submodule add https://github.com/chrisbra/csv.vim                 plugins/start/csv.vim
git submodule add https://github.com/jalexandretoledo/visSum.vim      plugins/start/visSum.vim
git submodule add https://github.com/jamessan/vim-gnupg               plugins/start/vim-gnupg
git submodule add https://github.com/neoclide/coc.nvim                plugins/start/coc.nvim

:: opcionais
git submodule add https://github.com/altercation/vim-colors-solarized.git       plugins/opt/vim-colors-solarized.git
git submodule add https://github.com/elmindreda/vimcolors.git                   plugins/opt/vimcolors.git
