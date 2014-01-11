set nocompatible                " choose no compatibility with legacy vi
filetype off                    " required!

" Vundle (Plugin Management)

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" My Bundles
Bundle 'kien/ctrlp.vim'
Bundle 'bling/vim-airline'

filetype plugin indent on       " load file type plugins + indentation

syntax enable
set encoding=utf-8

"" Whitespace
set nowrap                      " don't wrap lines
set tabstop=2 shiftwidth=2      " a tab is two spaces (or set this to 4)
set expandtab                   " use spaces, not tabs (optional)
set backspace=indent,eol,start  " backspace through everything in insert mode

"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter

"" Status Bar
set ruler		                    " show the cursor position all the time
set showcmd                     " display incomplete commands
set laststatus=2                " show status line all the time

"" UI Stuff
set number                      " Display line number
set showmatch   		            " Show matching brackets.

" Avoid backup files~
set nobackup
set noswapfile
set nowb

