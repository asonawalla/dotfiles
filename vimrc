" Personal settings
set mouse=a
set nowrap
set background=dark
set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
set t_Co=256 " needed for airline support
highlight Normal ctermfg=grey ctermbg=black
syntax on

" Vundle settings
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" vim-go
Plugin 'fatih/vim-go'
  let g:go_auto_sameids=1
  let g:go_fmt_command="goimports"

" You Complete Me
Plugin 'Valloric/YouCompleteMe'

" Highlight closing XML/HTML tags
Plugin 'Valloric/MatchTagAlways'

" ctrlp = fuzzy file finder
Plugin 'ctrlpvim/ctrlp.vim'

" GoDef
Bundle 'dgryski/vim-godef'
	let g:godef_split=3

" For sql stuff
Plugin 'exu/pgsql.vim'
  let g:sql_type_default = 'pgsql'

" Protocol Buffers
Plugin 'uarun/vim-protobuf'

" VCS
Plugin 'tpope/vim-fugitive'

" Better tree display
Plugin 'scrooloose/nerdtree'

" Lightweight powerline alternative
Plugin 'vim-airline/vim-airline'
  let g:airline#extensions#tabline#enabled = 1
  let g:airline_powerline_fonts = 1
  let g:airline_theme='simple'
Plugin 'vim-airline/vim-airline-themes'

" Highlight stupid whitespace
Plugin 'ntpeters/vim-better-whitespace'

" Dim inactive windows
" Plugin 'blueyed/vim-diminactive'

" All of your (Vundle) Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Because I can't type for shit
command W w
command Q q

" Configuration for vim-diminactive
" let g:diminactive_use_colorcolumn = 0
" let g:diminactive_use_syntax = 1
" let g:diminactive = 1

" Underline stuff in the active window
" augroup ActiveWindowUnderline
"   autocmd!
"   autocmd WinEnter * set cul
"   autocmd WinLeave * set nocul
" augroup END

