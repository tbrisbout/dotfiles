set nocompatible                " choose no compatibility with legacy vi
filetype off                    " required!

" Vundle (Plugin Management)

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/Vundle.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'bling/vim-airline'
Bundle 'blueeyed/vim-colors-solarized'
Bundle 'wookiehangover/jshint.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'antlypls/vim-colors-codeschool'
Bundle 'geekjuice/vim-mocha'
Bundle 'airblade/vim-gitgutter'
Bundle 'tpope/vim-fugitive'
Bundle 'sirver/ultisnips'
Bundle 'honza/vim-snippets'
Bundle 'kchmck/vim-coffee-script'
Bundle 'marijnh/tern_for_vim'
Bundle 'Valloric/YouCompleteMe'
Bundle 'majutsushi/tagbar'
Bundle 'cohama/lexima.vim'
Bundle 'alvan/vim-closetag'
Bundle 'digitaltoad/vim-jade'
Bundle 'wavded/vim-stylus'
Bundle 'editorconfig/editorconfig-vim'
Bundle 'ryanoasis/vim-webdevicons'
Bundle 'tpope/vim-commentary'
Bundle 'moll/vim-node'
Bundle 'calebsmith/vim-lambdify'
Bundle 'jelera/vim-javascript-syntax'

filetype plugin indent on       " load file type plugins + indentation

syntax enable
set encoding=utf-8

" solarized scheme
if has('gui_running')
  set background=light
  set guifont=Monaco\ for\ Powerline:h14
else
  set background=dark
endif

set t_Co=16
colorscheme solarized


"" Whitespace
set nowrap                      " don't wrap lines
set tabstop=2 shiftwidth=2      " a tab is two spaces (or set this to 4)
set expandtab                   " use spaces, not tabs (optional)
set backspace=indent,eol,start  " backspace through everything in insert mode
set list listchars=trail:·

"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter

set grepprg=ag\ --nogroup\ --nocolor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

"" Status Bar
set ruler                       " show the cursor position all the time
set showcmd                     " display incomplete commands
set laststatus=2                " show status line all the time
let g:airline_powerline_fonts=1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" Buffer Top bar
let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#left_sep = ' '
" let g:airline#extensions#tabline#left_alt_sep = '|'
" let g:airline#extensions#tabline#fnamemod = ':t'

"" GUI Stuff
set number                      " Display line number
set showmatch                   " Show matching brackets.

" Avoid backup files~
set nobackup
set noswapfile
set nowb

set hidden

" Keyboards Shortcuts
set mouse=a
let mapleader = " "
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P
nnoremap <Leader>o o<Esc>k
nnoremap <Leader>O O<Esc>j
nnoremap <Leader>w :w<CR>

" insert comma / semicolon at end of line
nnoremap <Leader>, m`A,<Esc>``
nnoremap <Leader>; m`A;<Esc>``

" visually select a function (WIP)
nnoremap <Leader>vf va{V

" insert comment at beginning
nmap <Leader>c gcc
vmap <Leader>c gc

let g:UltiSnipsExpandTrigger="<c-l>"

" run mocha specs
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

" Move to the next buffer
nnoremap <leader>l :bnext<CR>

" Move to the previous buffer
nmap <leader>h :bprevious<CR>

" Delete current buffer
nmap <leader>bd :bd<CR>

" Exit insert mode faster
inoremap jj <Esc>
inoremap jk <Esc>:w<CR>
inoremap j; <Esc>m`A;<Esc>``

" Clear search highlight
nmap <Leader><Leader> :noh<CR>

" Test with NERDTree
silent! nmap <F2> :NERDTreeToggle<CR>
silent! map <F3> :NERDTreeFind<CR>

let g:NERDTreeMapActivateNode="<F3>"
let g:NERDTreeMapPreview="<F4>"

" Path ignore (wildmenu, ctrlp..)
set wildignore+=*/.git/*,*/node_modules/*,*/bower_components/*

" AutoCorrect typos in Insert Mode
iabbrev lenght length
iabbrev heigth height
iabbrev widht width
iabbrev fucntion function
iabbrev funciton function
iabbrev clog console.log

augroup vimrc_autocmds
  autocmd BufNewFile,BufRead *.md set filetype=markdown
  autocmd Filetype gitcommit highlight OverLength ctermbg=red guibg=#592929
  autocmd Filetype gitcommit match OverLength /\%72v.*/
  autocmd Filetype xls setlocal noexpandtab
  autocmd BufEnter * set completeopt-=preview
  autocmd BufNewFile *.js exe "normal O'use strict';"
  autocmd FileType javascript nnoremap <Leader>r :!node "%:p"<CR>
  autocmd FileType javascript set makeprg=node\ %
augroup END
