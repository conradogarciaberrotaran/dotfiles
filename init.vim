"" Cono's nvim configuration

"" Pre-requisites:
"" - pyenv with pyenv-virtualenv installed
"" - create a virtualenv called nvim
"" - install pynvim, black and flake8
"" - install the silver searcher (Ag)

"" Plugin installation
call plug#begin(expand('~/.config/nvim/plugged'))
  " Core
  Plug 'preservim/nerdtree'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-fugitive'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'Yggdroot/indentLine'
  Plug 'machakann/vim-highlightedyank'
  Plug 'mg979/vim-visual-multi', {'branch': 'master'}
  Plug 'yuttie/comfortable-motion.vim'
  Plug 'mileszs/ack.vim'
  Plug 'godlygeek/tabular'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
  Plug 'junegunn/fzf.vim'
  " Python
  Plug 'davidhalter/jedi-vim'
  Plug 'raimon49/requirements.txt.vim', {'for': 'requirements'}
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'zchee/deoplete-jedi'
  Plug 'fisadev/vim-isort'
  Plug 'vim-test/vim-test'
  Plug 'psf/black'
  Plug 'SirVer/ultisnips'
  Plug 'honza/vim-snippets'
  Plug 'dense-analysis/ale'
call plug#end()

" Set the python interpreter as nvim's virtualenv interpreter
let g:python3_host_prog = '~/.pyenv/versions/nvim/bin/python3'


"" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set ttyfast

"" Fix backspace indent
set backspace=indent,eol,start

"" Enable silver searcher
if executable('ag')
  let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ackprg = 'ag --vimgrep'
endif


"" Tabs.
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab

"" Set map leader
let mapleader=','

"" Enable hidden buffers
set hidden

"" Enable searching
set hlsearch
set incsearch
set ignorecase
set smartcase

"" Set shell
if exists('$SHELL')
    set shell=$SHELL
else
    set shell=/bin/sh
endif

"" Visual settings
set ruler
set number
set mousemodel=popup
set t_Co=256
set guioptions=egmrti
set gfn=Monospace\ 10
let no_buffers_menu=1

set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\


if exists("*fugitive#statusline")
  set statusline+=%{fugitive#statusline()}
endif

" vim-airline
let g:airline_theme = 'powerlineish'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_skip_empty_sections = 1

"" Abbreviations
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

"" NERDTree configuration
let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize = 50

" make nerdtree buffer unable to open files on
nnoremap <silent> <expr> <C-P> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":FZF\<cr>"
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite

" add clipboard support
set clipboard+=unnamedplus

"" Mappings
noremap YY "+y<CR>
noremap <leader>p "+gP<CR>
noremap XX "+x<CR>

"" Go to the next error
nmap <silent> <C-k> <Plug>(ale_next_wrap)

"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

"" Buffer nav
noremap <leader>q :bp<CR>
noremap <leader>w :bn<CR>
noremap <leader>x :bd<CR>

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

"" NERDTree Mappings
nnoremap <silent> <C-N> :NERDTreeToggle<CR>

" Clean search (highlight)
nnoremap <silent> <leader><space> :noh<cr>

"" Python config

" vim-python
augroup vimrc-python
  autocmd!
  autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=8
      \ formatoptions+=croq softtabstop=4
      \ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
augroup END

" jedi-vim
let g:jedi#popup_on_dot = 0
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = "<leader>d"
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#rename_command = "<leader>r"
let g:jedi#show_call_signatures = "0"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#smart_auto_mappings = 0

" Multicursor mapping
let g:VM_maps = {}
let g:VM_maps['Find Under']         = '<C-t>'           " replace C-n
let g:VM_maps['Find Subword Under'] = '<C-t>'           " replace visual C-n

autocmd FileType python setlocal completeopt-=preview

" Highlighted yank duration
let g:highlightedyank_highlight_duration = 300

" vim-test mapping
nmap <leader>t :TestNearest<CR>

" Enable deoplete
let g:deoplete#enable_at_startup = 1

" Isort
let g:vim_isort_config_overrides = {
  \ 'profile': 'black'}

autocmd BufWritePost *.py silent! execute ':Isort'

" run black on save
autocmd BufWritePost *.py silent! execute ':Black'

" ale
let g:ale_linters = {}
:call extend(g:ale_linters, {
    \'python': ['flake8'], })

" black
nnoremap <F9> :Black<CR>
let g:black#settings = {
    \ 'fast': 1,
    \ 'line_length': 88
\}

" autocomplete
let g:jedi#completions_enabled = 1

" vim-airline
let g:airline#extensions#virtualenv#enabled = 1

" Syntax highlight
let python_highlight_all = 1

