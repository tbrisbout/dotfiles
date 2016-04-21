set nocompatible                " choose no compatibility with legacy vi
filetype off                    " required!

" Vundle (Plugin Management)

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" required!
Plugin 'gmarik/Vundle.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/nerdtree'
Plugin 'antlypls/vim-colors-codeschool'
Plugin 'geekjuice/vim-mocha'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
Plugin 'sirver/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'kchmck/vim-coffee-script'
Plugin 'marijnh/tern_for_vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'majutsushi/tagbar'
Plugin 'cohama/lexima.vim'
Plugin 'alvan/vim-closetag'
Plugin 'digitaltoad/vim-jade'
Plugin 'wavded/vim-stylus'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'ryanoasis/vim-webdevicons'
Plugin 'tpope/vim-commentary'
Plugin 'moll/vim-node'
Plugin 'pangloss/vim-javascript'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'flazz/vim-colorschemes'
Plugin 'elzr/vim-json'

Plugin 'elixir-lang/vim-elixir'

Plugin 'tbrisbout/vim-babeljs'
Plugin 'scrooloose/syntastic'

Plugin 'elmcast/elm-vim'

call vundle#end()
filetype plugin indent on       " load file type plugins + indentation

syntax enable
" set encoding=utf-8

colorscheme Tomorrow-Night-Eighties
let g:airline_theme='tomorrow'


"" Whitespace
set nowrap                      " don't wrap lines
set tabstop=2 shiftwidth=2      " a tab is two spaces (or set this to 4)
set expandtab                   " use spaces, not tabs (optional)
set backspace=indent,eol,start  " backspace through everything in insert mode
set list listchars=trail:·,tab:▸\ ,nbsp:·

"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter

set grepprg=ag\ --nogroup\ --nocolor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
nnoremap <Leader>f :grep!<SPACE>

"" Status Bar
set ruler                       " show the cursor position all the time
set showcmd                     " display incomplete commands
set laststatus=2                " show status line all the time
let g:airline_powerline_fonts=1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" Buffer Top bar
" let g:airline#extensions#tabline#enabled = 1

"" GUI Stuff
set number                      " Display line number
set showmatch                   " Show matching brackets.
set cursorline
set splitbelow                 " More natural split

"" JS concealing
set conceallevel=0
" set concealcursor=nvic
" highlight Conceal cterm=bold ctermbg=NONE ctermfg=67
" JavaScript thanks to pangloss/vim-javascript
let g:javascript_conceal_function = "λ"
let g:javascript_conceal_this = "@"
let g:javascript_conceal_return = "«"
let g:javascript_conceal_prototype = "#"

let g:syntastic_javascript_checkers = ['eslint']
" let g:syntastic_javascript_eslint_exec = './node_modules/gulp-eslint/node_modules/eslint/bin/eslint.js'
let g:syntastic_javascript_eslint_exec = './node_modules/.bin/eslint'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1


" Elm stuff
let g:elm_format_autosave = 1

" Avoid backup files~
set nobackup
set noswapfile
set nowb

set autoread
set hidden

" Keyboards Shortcuts
set mouse=a
let mapleader = " "
vnoremap <Leader>y "+y
vnoremap <Leader>d "+d
nnoremap <Leader>p "+p
nnoremap <Leader>P "+P
vnoremap <Leader>p "+p
vnoremap <Leader>P "+P
nnoremap <Leader>o o<Esc>k
nnoremap <Leader>O O<Esc>j
nnoremap <Leader>w :w<CR>

nnoremap <leader>r :make<cr>

" insert comma / semicolon at end of line
nnoremap <Leader>, m`A,<Esc>``
nnoremap <Leader>; m`A;<Esc>``

" visually select a function (WIP)
nnoremap <Leader>vf va{V

" insert comment at beginning
nmap <Leader>c gcc
vmap <Leader>c gc

let g:UltiSnipsExpandTrigger="<c-l>"
let g:UltiSnipsJumpForwardTrigger="<tab>"

" Move to the next buffer
nnoremap <leader>l :bnext<CR>

" Move to the previous buffer
nnoremap <leader>h :bprevious<CR>

" Delete current buffer
nnoremap <leader>bd :bd<CR>

" Open buffer list
nnoremap <leader><leader> :CtrlPBuffer<cr>

" Exit insert mode faster
inoremap jj <Esc>
inoremap jk <Esc>:w<CR>
inoremap j; <Esc>m`A;<Esc>``

" Clear search highlight
nnoremap <Leader>noh :noh<CR>

" Test with NERDTree
silent! nmap <F2> :NERDTreeToggle<CR>
silent! map <F3> :NERDTreeFind<CR>

let g:NERDTreeMapActivateNode="<F3>"
let g:NERDTreeMapPreview="<F4>"

" Move to prev / next change
silent! nnoremap <Leader>gn :GitGutterNextHunk<CR>
silent! nnoremap <Leader>gp :GitGutterPrevHunk<CR>
silent! nnoremap <Leader>gr :GitGutterRevertHunk<CR>

" Path ignore (wildmenu, ctrlp..)
set wildignore+=*/.git/*,*/node_modules/*,*/bower_components/*,*/dist/*

" Escape to Normal mode in Nvim terminal
if has('nvim')
  tnoremap <Esc> <C-\><C-n>
endif

" AutoCorrect typos in Insert Mode
iabbrev lenght length
iabbrev heigth height
iabbrev widht width
iabbrev fucntion function
iabbrev funciton function

augroup vimrc_autocmds
  autocmd!
  autocmd BufNewFile,BufRead *.md set filetype=markdown
  autocmd Filetype gitcommit highlight OverLength ctermbg=red guibg=#592929
  autocmd Filetype gitcommit match OverLength /\%72v.*/
  autocmd Filetype xls setlocal noexpandtab
  autocmd BufEnter * set completeopt-=preview
  autocmd FileType javascript nnoremap <buffer> <Leader>r :!node --harmony-proxies "%:p"<CR>
  autocmd FileType javascript setlocal makeprg=node\ %
  autocmd Filetype elm setlocal makeprg=elm-make\ %
augroup END
