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
  let g:go_fmt_command="goimports"

Plug 'uarun/vim-protobuf'

Plug 'ekalinin/Dockerfile.vim'

Plug 'editorconfig/editorconfig-vim'

Plug 'dag/vim-fish'

Plug 'solarnz/thrift.vim'

" VCS Tools
Plug 'tpope/vim-fugitive'

" Other vim enhancement plugins
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --gocode-completer' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'jiangmiao/auto-pairs'
" Plug 'ntpeters/vim-better-whitespace'

" OSX specific, but shouldn't hurt on Linux
Plug 'bradens/vim-iterm2-navigator'

call plug#end()

syntax enable
set t_Co=256
set background=dark
colorscheme desert

set mouse=a
set hlsearch
set incsearch
set ruler
set nobackup
set noswapfile
set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
set backspace=indent,eol,start

set completeopt=longest,menuone,preview

" Show line numbers and make them grey
set number
highlight LineNr ctermfg=grey guifg=grey

" Highlight extra whitespace at the end of lines
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$/

" Shortcut for NERDTree
map <C-n> :NERDTreeToggle<CR>

" Avoid the conflict on c-c in sql files
let g:omni_sql_no_default_maps=1

