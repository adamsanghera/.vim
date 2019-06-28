" Automatically installs vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins section
call plug#begin('~/.vim/plugged')

"" Ledger
Plug 'ledger/vim-ledger'

"" Languages

""" Jsx
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

""" Flow (react)
Plug 'flowtype/vim-flow'

""" Rust
Plug 'neomake/neomake', { 'for': ['rust'] }
if executable('rustc')
    Plug 'rust-lang/rust.vim', { 'for': 'rust' }
    Plug 'racer-rust/vim-racer', { 'for': 'rust' }
endif

""" Markdown / Pandoc
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'

"" Misc
Plug 'ervandew/supertab'

""" Spotify
Plug 'HendrikPetertje/vimify'

""" HackerNews
Plug 'adelarsq/vim-hackernews'

""" Reddit
Plug 'DougBeney/vim-reddit'

""" Buffer management
Plug 'qpkorr/vim-bufkill'

""" Web Search
Plug 'linluk/vim-websearch'

""" Buffer management
Plug 'qpkorr/vim-bufkill'

""" Web Search
Plug 'linluk/vim-websearch'

""" Snippets
Plug 'sirver/ultisnips'

""" Color
Plug 'tomasr/molokai'

""" Search
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

""" NERDTree, for browsing the fs
Plug 'scrooloose/nerdtree'

""" Makes it easier to deal with brackets and such
Plug 'tpope/vim-surround'

""" Source Code exploration
Plug 'majutsushi/tagbar'

""" Syntax Checking
Plug 'w0rp/ale'

Plug 'junegunn/vim-easy-align'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
Plug 'Shougo/vimproc.vim', {'do':'make'}
Plug 'Shougo/vimshell.vim'
Plug 'honza/vim-snippets'

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" End plugins
call plug#end()

let g:UltiSnipsExpandTrigger           = '<tab>'
let g:UltiSnipsJumpForwardTrigger      = '<tab>'
let g:UltiSnipsJumpBackwardTrigger     = '<s-tab>'

" Custom mappings, etc.
"" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set bomb
set binary
set ttyfast

"" Fix backspace indent
set backspace=indent,eol,start

"" Tabs. May be overriten by autocmd rules
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab

"" Map leader to ,
let mapleader=','

"" Enable hidden buffers
set hidden

"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

"" Directories for swp files
set nobackup
set noswapfile

set fileformats=unix,dos,mac

if exists('$SHELL')
    set shell=$SHELL
else
    set shell=/bin/sh
endif

" session management
let g:session_directory = "~/.vim/session"
let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1

syntax on
set ruler
set number

let no_buffers_menu=1
if !exists('g:not_finish_vimplug')
  let g:rehash256 = 1
  let g:molokai_original = 1
  silent! colorscheme molokai
endif

set mousemodel=popup
set t_Co=256
set guioptions=egmrti
set gfn=Monospace\ 10

"" Disable the blinking cursor.
set gcr=a:blinkon0
set scrolloff=5

"" Status bar
set laststatus=2

"" Use modeline overrides
set modeline
set modelines=10

set title
set titleold="Terminal"
set titlestring=%F

set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

if exists("*fugitive#statusline")
  set statusline+=%{fugitive#statusline()}
endif

" vim-airline
let g:airline_theme = 'powerlineish'
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline_skip_empty_sections = 1

" Change how tabs are displayed
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4

augroup completion_preview_close
  autocmd!
  if v:version > 703 || v:version == 703 && has('patch598')
    autocmd CompleteDone * if !&previewwindow && &completeopt =~ 'preview' | silent! pclose | endif
  endif
" augroup END

" The Go experience
let g:go_list_type = "quickfix"
let g:go_fmt_command = "goimports"
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_structs = 1

augroup go
  au!
  au Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  au Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  au Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
  au Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

  au FileType go nmap <Leader>dd <Plug>(go-def-vertical)
  au FileType go nmap <Leader>dv <Plug>(go-doc-vertical)
  au FileType go nmap <Leader>db <Plug>(go-doc-browser)

  au FileType go nmap <leader>r  <Plug>(go-run)
  au FileType go nmap <leader>t  <Plug>(go-test)
  au FileType go nmap <Leader>gt <Plug>(go-coverage-toggle)
  au FileType go nmap <Leader>i <Plug>(go-info)
  au FileType go nmap <silent> <Leader>l <Plug>(go-metalinter)
  au FileType go nmap <C-g> :GoDecls<cr>
  au FileType go nmap <leader>dr :GoDeclsDir<cr>
  au FileType go imap <C-g> <esc>:<C-u>GoDecls<cr>
  au FileType go imap <leader>dr <esc>:<C-u>GoDeclsDir<cr>
  au FileType go nmap <leader>rb :<C-u>call <SID>build_go_files()<CR>
augroup END

" Split
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>

" Tagbar
nmap <silent> <F4> :TagbarToggle<CR>
let g:tagbar_autofocus = 1

"" Tabs
" nnoremap <Tab> gt
" nnoremap <S-Tab> gT
" nnoremap <silent> <S-t> :tabnew<CR>

" Disable visualbell
set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif

" Load spotify token
source ~/.spotify

" Configure websearch
let g:web_search_engine = 'duckduck'
let g:web_search_browser = 'lynx -vikeys'

" Fixing weird bd default behavior
let g:nerdtree_tabs_autoclose=0

" Support for jsx files
augroup FiletypeGroup
    autocmd!
    au BufNewFile,BufRead *.jsx set filetype=javascript.jsx
augroup END

" Syntax checking
let g:ale_linters_explicit = 1
let g:ale_python_pylint_change_directory = 0
let g:ale_python_pylint_options = '--rcfile=/Users/adam.sanghera/data/.arc/.pylintrc'
let g:ale_linters_aliases = {'jsx': ['css', 'javascript']}
let g:ale_linters = {
\    'go': ['bingo', 'vet', 'golint', 'errcheck', 'go build'],
\    'python': ['pylint'],
\    'javascript': ['eslint', 'prettier'],
\    'proto': ['protoc-gen-lint'],
\}
let g:ale_fixers = {
\    'go': ['gofmt', 'goimports'],
\    '*': ['remove_trailing_lines', 'trim_whitespace'],
\    'javascript': [],
\}
let g:ale_go_bingo_executable = 'gopls'
let g:ale_fix_on_save = 1

" Rust experience
let g:racer_cmd = "/Users/adamsanghera/.cargo/bin/racer"
let g:racer_experimental_completer = 1
au FileType rust nmap <leader>rx <Plug>(rust-doc)
au FileType rust nmap <leader>rd <Plug>(rust-def)
au FileType rust nmap <leader>rs <Plug>(rust-def-split)

" JS sane defaults
autocmd Filetype javascript setlocal tabstop=2
autocmd Filetype javascript setlocal shiftwidth=2

" vertical f
nnoremap <leader>f :<c-u>exe line('.').'/\%'.col('.').'c'.nr2char(getchar())<cr>

" ledger config
au BufNewFile,BufRead *.ldg,*.ledger setf ledger | comp ledger
let g:ledger_maxwidth = 120
let g:ledger_fold_blanks = 1
function LedgerSort()
    :%! ledger -f - print --sort 'date, amount'
    :%LedgerAlign
endfunction
command LedgerSort call LedgerSort()
