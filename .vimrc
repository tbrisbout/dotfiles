let g:python3_host_prog='/usr/bin/python3.8' " required for deoplete

set nocompatible                " choose no compatibility with legacy vi
set encoding=utf-8
filetype off                    " required!

call plug#begin('~/.vim/plugged')

" UI Plugins
" Plug 'tyrannicaltoucan/vim-quantum'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
Plug 'arcticicestudio/nord-vim'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Snippets
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'
Plug 'epilande/vim-es2015-snippets'
" Plug 'epilande/vim-react-snippets'

" Autocomplete
" Plug 'marijnh/tern_for_vim', { 'do': 'npm install' }
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Valloric/YouCompleteMe', { 'do': './install.py --tern-completer' }
endif
let g:deoplete#enable_at_startup = 1

" Misc
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-commentary'
Plug 'dense-analysis/ale'

" Languages Utils
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'sheerun/vim-polyglot'
Plug 'cohama/lexima.vim'
Plug 'alvan/vim-closetag'
Plug 'AndrewRadev/splitjoin.vim'

" JS
Plug 'moll/vim-node', { 'for': 'javascript' }
Plug 'jelera/vim-javascript-syntax', { 'for': 'javascript' }
Plug 'mxw/vim-jsx', { 'for': 'javascript' }

" Writing
Plug 'reedes/vim-wordy'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

call plug#end()
filetype plugin indent on       " load file type plugins + indentation

syntax enable

colorscheme nord

" fix background and visual mode
" do not work well in tmux
if has('termguicolors')
  set termguicolors
endif

let g:lightline = {'colorscheme': 'nord'}

"" Whitespace
set nowrap                      " don't wrap lines
set tabstop=2 shiftwidth=2      " a tab is two spaces (or set this to 4)
set expandtab                   " use spaces, not tabs (optional)
set backspace=indent,eol,start  " backspace through everything in insert mode
set list listchars=trail:·,tab:·\ ,nbsp:·

"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter
highlight clear SignColumn

set grepprg=ag\ --nogroup\ --nocolor\ --ignore\ node_modules

"" Status Bar
set noruler                     " show the cursor position all the time
set showcmd                     " display incomplete commands
set laststatus=0                " hide status line all the time

"" GUI Stuff
set showmatch                   " Show matching brackets.
set splitbelow splitright       " More natural split
set foldcolumn=2                " Use foldcolumn for left padding

" Linting
let g:jsx_ext_required = 0

let g:ale_linters = {
  \ 'javascript': ['eslint'],
  \ 'go': ['gobuild', 'govet', 'staticcheck']
  \ }

let g:ale_fixers = {
  \ 'javascript': ['prettier', 'eslint'],
  \ 'javascriptreact': ['prettier', 'eslint'],
  \ 'typescript': ['prettier', 'eslint'],
  \ 'typescriptreact': ['prettier', 'eslint']
  \ }

let g:ale_sign_error = '•'
let g:ale_sign_warning = '◦'

let g:ale_echo_msg_format = '[%linter%] %s'
let g:ale_open_list=1
let g:ale_list_window_size = 5

let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_changed = 0
let g:ale_fix_on_save = 1

let g:ale_virtualtext_cursor = 1
let g:ale_floating_preview = 1
let g:ale_floating_window_border = []


" Go Stuff
let g:go_fmt_command = "goimports"
let g:go_doc_popup_window=1

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

" edit vimrc
nnoremap <leader>ev :e $HOME/.vimrc<cr>

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
nnoremap <silent> <leader>n :ALENext<cr>
nnoremap <silent> <leader>N :ALEPrevious<cr>

" insert comma / semicolon at end of line
nnoremap <Leader>, m`A,<Esc>``
nnoremap <Leader>; m`A;<Esc>``

" open es module import
nnoremap <Leader>gf 0f'gf

nnoremap <silent> gr :ALEFindReferences<cr>
nnoremap <leader>I :ALEDetail<cr>


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

" Open fuzzy finder in current dir of current buffer (find sibling files)
nnoremap <silent> <Leader>. :Files <C-r>=expand("%:h")<CR>/<CR>

" Open command palette
nnoremap <silent> <C-K> :Commands<cr>

" Open buffer list
nnoremap <leader><leader> :Buffers<cr>

" Exit insert mode faster
inoremap jj <Esc>
inoremap jk <Esc>:w<CR>
inoremap j; <Esc>m`A;<Esc>``

" faster search
nnoremap <leader>f :Ag<cr>
nnoremap <leader>: :History:<cr>
nnoremap <leader>K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" Clear search highlight
nnoremap <Leader>noh :noh<CR>

" Test with NERDTree
silent! nmap <F2> :NERDTreeToggle<CR>
silent! map <F3> :NERDTreeFind<CR>

let g:NERDTreeMapActivateNode="<F3>"
let g:NERDTreeMapPreview="<F4>"
let NERDTreeMinimalUI=1
let NERDTreeAutoDeleteBuffer=1

" Move to prev / next change
silent! nnoremap <Leader>gn :GitGutterNextHunk<CR>
silent! nnoremap <Leader>gp :GitGutterPrevHunk<CR>
silent! nnoremap <Leader>gr :GitGutterUndoHunk<CR>

nnoremap <leader>gs :Git<cr>

set wildmenu
set wildmode=list:longest,full
" Path ignore (wildmenu, search...)
set wildignore+=*/.git/*,*/node_modules/*,*/bower_components/*,*/dist/*,*/elm-stuff/*

if has('nvim')
  set inccommand=nosplit " live preview of substitutions command
  autocmd FileType fzf tnoremap <buffer> <Esc> <Esc>
endif

" AutoCorrect typos in Insert Mode
iabbrev lenght length
iabbrev heigth height
iabbrev widht width
iabbrev fucntion function
iabbrev funciton function
iabbrev retunr return
iabbrev reutrn return
iabbrev fitler filter

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

  autocmd FileType go nmap <leader>r  <Plug>(go-run)
  autocmd FileType go nmap <leader>b  <Plug>(go-build)
  autocmd FileType go nmap <leader>t  <Plug>(go-test)
  autocmd FileType go nmap <leader>s  :GoAlternate!<CR>
  autocmd FileType go nnoremap <leader>god  :GoDecls<CR>
  autocmd FileType go nnoremap <leader>gor  :GoReferrers<CR>
  autocmd FileType go nnoremap <leader>goi  :GoImplements<CR>

  autocmd FileType javascript,typescript,typescriptreact nnoremap <silent> K :ALEHover<cr>
  autocmd FileType javascript,typescript,typescriptreact map <silent> <buffer> <c-]> :ALEGoToDefinition<cr>
  autocmd FileType javascript,typescript,typescriptreact nnoremap <silent> <leader>t :npm test -s -- -- --bail --ci %:p:h<cr>
augroup END
