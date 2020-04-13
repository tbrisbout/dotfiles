set nocompatible                " choose no compatibility with legacy vi
set encoding=utf-8
filetype off                    " required!

call plug#begin('~/.vim/plugged')

" UI Plugins
Plug 'tyrannicaltoucan/vim-quantum'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
Plug 'trevordmiller/nova-vim'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Snippets
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'
Plug 'epilande/vim-es2015-snippets'
Plug 'epilande/vim-react-snippets'

" Autocomplete
Plug 'marijnh/tern_for_vim', { 'do': 'npm install' }
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Valloric/YouCompleteMe', { 'do': './install.py --tern-completer' }
endif
let g:deoplete#enable_at_startup = 1

" Misc
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-commentary'
Plug 'w0rp/ale'

" Languages Utils
Plug 'sheerun/vim-polyglot'
Plug 'cohama/lexima.vim'
Plug 'alvan/vim-closetag'

" JS
Plug 'moll/vim-node', { 'for': 'javascript' }
Plug 'jelera/vim-javascript-syntax', { 'for': 'javascript' }
Plug 'tbrisbout/vim-babeljs', { 'for': 'javascript' }
Plug 'mxw/vim-jsx', { 'for': 'javascript' }

" Writing
Plug 'reedes/vim-wordy', { 'for': 'markdown' }
Plug 'junegunn/goyo.vim', { 'for': 'markdown' }
Plug 'junegunn/limelight.vim', { 'for': 'markdown' }

call plug#end()
filetype plugin indent on       " load file type plugins + indentation

syntax enable

colorscheme nova
let g:lightline = {
  \ 'colorscheme': 'nova',
  \ }

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

"" Status Bar
set ruler                       " show the cursor position all the time
set showcmd                     " display incomplete commands
set laststatus=2                " show status line all the time

"" GUI Stuff
set number                      " Display line number
set showmatch                   " Show matching brackets.
set cursorline
set splitbelow splitright       " More natural split

" Linting
let g:jsx_ext_required = 0

let g:ale_linters = {
  \ 'javascript': ['eslint']
  \ }

let g:ale_fixers = {
  \ 'javascript': ['prettier', 'eslint']
  \ }

" Avoid draining laptop battery
let g:ale_fix_on_save=1
let g:ale_lint_on_text_changed='normal'
let g:ale_lint_on_insert_leave=1

let g:ale_sign_error = '✖'
let g:ale_sign_warning = '⚠'

" Elm stuff
let g:ycm_semantic_triggers = { 'elm' : ['.'] }

" Avoid backup files~
set nobackup
set noswapfile
set nowb

set autoread
set hidden

let g:closetag_filenames = '*.html,*.xml,*.js'

" Keyboards Shortcuts
set mouse=a
let mapleader = " "

" Copy / Paste
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

" next/prev entry in location list (e.g. linter issue)
" n and N mimic behavior of * word search
nnoremap <leader>n :lnext<cr>
nnoremap <leader>N :lprev<cr>

" insert comma / semicolon at end of line
nnoremap <Leader>, m`A,<Esc>``
nnoremap <Leader>; m`A;<Esc>``

" open es module import
nnoremap <Leader>gf 0f'gf

" visually select a function (WIP)
nnoremap <Leader>vf va{V

" wrap visual selection with console.log
vnoremap <leader>log cconsole.log()<esc>P
vnoremap <leader>lg c(console.log(<esc>pa), )<esc>P

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

nnoremap <C-P> :Files<cr>

" Open buffer list
nnoremap <leader><leader> :Buffers<cr>

" Exit insert mode faster
inoremap jj <Esc>
inoremap jk <Esc>:w<CR>
inoremap j; <Esc>m`A;<Esc>``

" faster search
nnoremap <leader>f :Ag<cr>
nnoremap <leader>: :History:<cr>
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

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

nnoremap <leader>gs :Gstatus<cr>

set wildmenu
set wildmode=list:longest,full
" Path ignore (wildmenu, search...)
set wildignore+=*/.git/*,*/node_modules/*,*/bower_components/*,*/dist/*,*/elm-stuff/*

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

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

augroup vimrc_autocmds
  autocmd!
  autocmd BufNewFile,BufRead *.md set filetype=markdown
  autocmd BufNewFile,BufRead .{babel,eslint}rc set filetype=json

  autocmd Filetype gitcommit highlight OverLength ctermbg=red guibg=#592929
  autocmd Filetype gitcommit match OverLength /\%72v.*/

  autocmd Filetype xls setlocal noexpandtab
  autocmd BufEnter * set completeopt-=preview
  autocmd FileType javascript setlocal makeprg=node\ %
  autocmd Filetype elm setlocal makeprg=elm-make\ %
augroup END
