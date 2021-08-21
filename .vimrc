" Install vim-plug if needed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins section
call plug#begin('~/.vim/plugged')

"" Random plugins offering language-specific support
""" Ledger
Plug 'ledger/vim-ledger'
""" Thrift
Plug 'solarnz/thrift.vim'
""" Syntax highlighting for jsx
Plug 'maxmellon/vim-jsx-pretty'
""" Erlang
Plug 'vim-erlang/vim-erlang-runtime'
Plug 'vim-erlang/vim-erlang-compiler'
Plug 'vim-erlang/vim-erlang-omnicomplete'
Plug 'vim-erlang/vim-erlang-tags'
""" Rust
Plug 'neomake/neomake', { 'for': ['rust'] }
if executable('rustc')
    Plug 'rust-lang/rust.vim', { 'for': 'rust' }
    Plug 'racer-rust/vim-racer', { 'for': 'rust' }
endif
""" Markdown / Pandoc
Plug 'vim-pandoc/vim-pandoc-syntax'
""" Csv
Plug 'chrisbra/csv.vim'

"" Efficiecny in Motions
""" Async dispatch for things like make
Plug 'tpope/vim-dispatch'
""" Toggling between files
Plug 'tpope/vim-projectionist'
""" Kill a buffer without killing its window
Plug 'qpkorr/vim-bufkill'
""" Code Snippets
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'
""" Fuzzy file finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
""" Filesystem browsing
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
""" Bracket-based motions
Plug 'tpope/vim-surround'
""" Little windows that describe things
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
""" Sessions
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
""" Autocomplete & deps
Plug 'Shougo/deoplete.nvim'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'ervandew/supertab'
""" Syntax-linting/fixing Engine
Plug 'w0rp/ale'
""" Testing things
Plug 'janko/vim-test'

"" Silly things
""" Spotify
Plug 'HendrikPetertje/vimify'
""" HackerNews
Plug 'adelarsq/vim-hackernews'
""" Reddit
Plug 'DougBeney/vim-reddit'
""" Web Search
Plug 'linluk/vim-websearch'

"" Aesthetics
""" Color
Plug 'tomasiser/vim-code-dark'

"" ???
Plug 'junegunn/vim-easy-align'
Plug 'Shougo/vimproc.vim', {'do':'make'}
Plug 'Shougo/vimshell.vim'

" End plugins
call plug#end()

" Plugin config
" Session
let g:session_directory = "~/.vim/session"
let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1
"" Deoplete
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option({
  \'auto_complete_delay': 1000,
  \'sources': {
  \  '_': ['ale', 'buffer'],
  \  'py': ['ale'],
  \}
\})

map <F2> :call deoplete#toggle()<CR>
"" UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsListSnippets="<c-tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsSnippetsDir="~/.vim/myUltiSnips"
let g:UltiSnipsSnippetDirectories=["myUltiSnips"]

" Vim config
"" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
"" Misc.
set bomb
set fileformats=unix,dos,mac
set binary
set ttyfast
set hidden
set backspace=indent,eol,start
"" Tabs, overriten by autocmd rules
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab
"" Leader
let mapleader=','
"" Search
set hlsearch
set incsearch
set ignorecase
set smartcase
"" Yolo 4 speed
set nobackup
set noswapfile
"" Bash me up
if exists('$SHELL')
    set shell=$SHELL
else
    set shell=/bin/sh
endif
"" Disable the blinking cursor.
set gcr=a:blinkon0
set scrolloff=5
"" Status bar
set laststatus=2
set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\
"" Use modeline overrides
set modeline
set modelines=10
"" Title
set title
set titleold="Terminal"
set titlestring=%F
"" Unsorted
syntax on
set ruler
set number
let no_buffers_menu=1
if !exists('g:not_finish_vimplug')
  let g:rehash256 = 1
  let g:molokai_original = 1
  silent! colorscheme codedark
endif
set mousemodel=popup
set t_Co=256
set guioptions=egmrti
set gfn=Monospace\ 10


" Mappings
"" Search centers on line of interest.
nnoremap n nzzzv
nnoremap N Nzzzv
"" Easier splits
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>
"" FZF fast
noremap <Leader>f :call fzf#run({'source': 'fd --type f --hidden -E .git', 'sink': 'e'})<CR>
noremap <Leader>r :Rg!<CR>
"" Projectionoist fast
noremap <Leader>a :A<CR>

if exists("*fugitive#statusline")
  set statusline+=%{fugitive#statusline()}
endif

" vim-airline
let g:airline_theme = 'codedark'
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline_skip_empty_sections = 1
let g:airline_disable_statusline = 1
let g:airline_highlighting_cache = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#branch#enabled = 0

" Change how tabs are displayed
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd BufNewFile,BufRead *.py setlocal noautoindent

autocmd FileType proto setlocal foldmethod=indent

augroup completion_preview_close
  autocmd!
  if v:version > 703 || v:version == 703 && has('patch598')
    autocmd CompleteDone * if !&previewwindow && &completeopt =~ 'preview' | silent! pclose | endif
  endif
augroup END

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
augroup python
  au!
  au FileType python nmap gd <esc>:ALEGoToDefinition<cr>
augroup END

" Tagbar
nmap <silent> <F4> :TagbarToggle<CR>
let g:tagbar_autofocus = 1

" Disable visualbell
set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
  filetype plugin indent on
endif

" Load spotify token
source ~/.spotify

" Configure websearch
let g:web_search_engine = 'duckduck'
let g:web_search_browser = 'lynx -vikeys'

" Fixing weird bd default behavior
let g:nerdtree_tabs_autoclose=0
let g:NERDTreeIgnore=['.git', '\.pyc$']

" Support for jsx files
augroup FiletypeGroup
    autocmd!
    au BufNewFile,BufRead *.jsx set filetype=javascript.jsx
    au BufRead,BufNewFile *.proto set filetype=proto
    au BufRead,BufNewFile *.avsc set filetype=json
    au BufRead,BufNewFile *.aurora set filetype=python
    au BufRead,BufNewFile *.pro set filetype=prolog

augroup END

" Syntax checking
let g:ale_virtualenv_dir_names = ['.virtualenvs']
let g:ale_linters_explicit = 1
let g:ale_python_pylint_change_directory = 0
let g:ale_python_pylint_options = '--rcfile /Users/adam.sanghera/data/pylintrc'
let g:ale_linters_aliases = {'jsx': ['css', 'javascript']}
let g:ale_lint_on_text_changed='never'
let g:ale_linters = {
\  'go': ['bingo', 'vet', 'golint', 'errcheck', 'go build'],
\  'html': ['prettier'],
\  'javascript': ['eslint', 'prettier', 'flow', 'flow-language-server'],
\  'json': ['jsonlint'],
\  'prolog': ['swipl'],
\  'proto': ['protoc-gen-lint'],
\  'python': ['pylint', 'pyls', 'pydocstyle'],
\  'sql': ['sqlint'],
\  'tf': ['tflint'],
\  'xml': ['xmllint'],
\}
let g:ale_fixers = {
\  '*': 'trim_whitespace',
\  'go': ['gofmt', 'goimports'],
\  'html': ['prettier'],
\  'javascript': ['prettier'],
\  'json': ['jq'],
\  'python': ['isort', 'black'],
\  'sql': ['pgformatter'],
\  'xml': ['xmllint'],
\  'yml': ['prettier'],
\}
let g:ale_go_bingo_executable = 'gopls'
let g:ale_fix_on_save = 0
let g:ale_python_pydocstyle_options = '--ignore D102,D101,D100,D106,D203,D213,D107'
let g:ale_proto_protoc_gen_lint_options = '-I /Users/adam.sanghera/data/protobuf/src'
let g:ale_python_pls_options = '-vv --log-file ~/yeet'
let g:ale_python_pyls_config = {
\  'pyls': {
\    'plugins': {
\      'pycodestyle': {
\        'enabled': v:false
\      },
\      'pylint': {
\        'enabled': v:false
\      },
\      'pyflakes': {
\        'enabled': v:false
\      },
\      'pydocstyle': {
\        'enabled': v:false
\      },
\      'rope': {
\        'enabled': v:false
\      },
\      'mccabe': {
\        'enabled': v:false
\      },
\      'autopep8': {
\        'enabled': v:false
\      },
\      'papf': {
\        'enabled': v:false
\      }
\    }
\  },
\}

" Rust experience
let g:racer_cmd = "/Users/adamsanghera/.cargo/bin/racer"
let g:racer_experimental_completer = 1
au FileType rust nmap <leader>rx <Plug>(rust-doc)
au FileType rust nmap <leader>rd <Plug>(rust-def)
au FileType rust nmap <leader>rs <Plug>(rust-def-split)

" JS sane defaults
autocmd Filetype javascript setlocal tabstop=2
autocmd Filetype javascript setlocal shiftwidth=2

" ledger config
au BufNewFile,BufRead *.ldg,*.ledger setf ledger | comp ledger
let g:ledger_maxwidth = 120
let g:ledger_fold_blanks = 1
function LedgerSort()
    :%! ledger -f - print --sort 'date, amount'
    :%LedgerAlign
endfunction
command LedgerSort call LedgerSort()

" Projectionist config
let g:projectionist_heuristics = {
    \ "*": {
    \   "*_test.py": {
    \     "alternate": "{}.py",
    \     "dispatch": "cd $DATA_REPO && $DATA_REPO/pants test $(echo {file|dirname}:{basename}_test | sed -e \"s|$DATA_REPO/||\")",
    \     "type": "test"
    \   },
    \   "*.py": {
    \     "alternate": "{}_test.py",
    \     "type": "source"
    \   },
    \   "*.test.js": {
    \     "alternate": "{}.js",
    \     "dispatch": "cd $DATA_REPO && npm test {file}",
    \     "type": "test"
    \   },
    \   "*.js": {
    \     "alternate": "{}.test.js",
    \     "type": "source"
    \   },
    \   "*.test.jsx": {
    \     "alternate": "{}.jsx",
    \     "dispatch": "cd $DATA_REPO && npm test {file}",
    \     "type": "test"
    \   },
    \   "*.jsx": {
    \     "alternate": "{}.test.jsx",
    \     "type": "source"
    \   }
    \ },
    \}

let g:SuperTabDefaultCompletionType = "<c-n>"

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --glob !.git --column --line-number --hidden --ignore-case --no-heading --color=always --colors "path:fg:190,220,255" --colors "line:fg:128,128,128" '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview({}, 'up:60%')
  \           : fzf#vim#with_preview({}, 'right:50%:hidden', '?'),
  \   <bang>0)

let g:fzf_history_dir = '~/.local/share/fzf-history'

set colorcolumn=88

highlight BadWhitespace ctermbg=red guibg=red
" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
" Make trailing whitespace be flagged as bad.
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
