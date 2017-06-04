set nocompatible
filetype off

" If vim's launched from a fish shell, shit gets weird.
" Set the shell to sh if launched from fish.
if &shell =~# 'fish$'
  set shell=sh
endif

call plug#begin('~/.vim/plugged')

" Language tools
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
  let g:go_auto_sameids=1
  let g:go_fmt_command="goimports"

Plug 'uarun/vim-protobuf'

Plug 'ekalinin/Dockerfile.vim'

Plug 'editorconfig/editorconfig-vim'

Plug 'dag/vim-fish'

" VCS Tools
Plug 'tpope/vim-fugitive'

" Other vim enhancement plugins
Plug 'scrooloose/nerdtree'
" Plug 'Valloric/YouCompleteMe', { 'do': './install.py --gocode-completer' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" OSX specific, but shouldn't hurt on Linux
Plug 'bradens/vim-iterm2-navigator'

call plug#end()

syntax enable
set t_Co=256
set background=dark
colorscheme desert

set mouse=a
set number
set hlsearch
set incsearch
set ruler
set nobackup
set noswapfile
set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab

set completeopt=longest,menuone,preview

highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$/

