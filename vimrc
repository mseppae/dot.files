" Standard settings
set nocompatible
" Needed for omni-completion
filetype plugin indent on
set omnifunc=syntaxcomplete#Complete

set autoread            " Reload files when changed on disk
set clipboard=unnamed
set visualbell          " No stupid beeping
set autoindent		    " always set autoindenting on
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set history=1000	   " keep 1000 lines of command line history
set updatetime=100

" Backup
set nobackup		   " do not keep a backup file, use versions instead
set noswapfile

"" Searching
set hlsearch           " highlight search
set incsearch          " do incremental searching (search while typing)
set ignorecase
set smartcase

" Encoding
set encoding=UTF-8     " Set encoding
set fileencoding=utf-8
set fileencodings=utf-8

" Tabs
set tabstop=4          " Number of visual spaces in tab
set shiftwidth=4
set softtabstop=4      " Number of spaces in tab when editing
set expandtab          " Tabs are spaces

" Buffers
set hidden              " Enable hidden buffers

" Visual
syntax enable            " Enable syntax processing
set number               " Set line numbers
set ruler		         " show the cursor position all the time
set t_Co=16
set laststatus=2         " Statusline visible all the time
set background=light
set colorcolumn=80
set showcmd		         " display incomplete commands

" Fuzzy searching
"" fzf integration
set rtp+=/usr/local/opt/fzf

" Gundo - Graphical undo tree
let g:gundo_prefer_python3 = 1

" Linting
"" w0rp/ale provides linting and code quality services
let g:ale_linters = {
\   'javascript': ['eslint', 'jslint'],
\   'typescript': ['eslint', 'tslint'],
\   'ruby': ['rubocop']
\}
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace']
\}
let g:ale_fix_on_save = 1
let g:airline#extensions#ale#enabled = 1

" Vim Airline
"" provides status line
let g:airline_powerline_fonts = 1
let g:airline_theme='solarized'
let g:airline_solarized_bg='light'
let g:airline_section_b = '%{strftime("%a %d.%m.%Y %H:%M")}'
let g:airline_left_sep          = '▶'
let g:airline_left_alt_sep      = '»'
let g:airline_right_sep         = '◀'
let g:airline_right_alt_sep     = '«'

" Language packs
let g:polyglot_disabled = ['graphql']

" Rust
"" Code completion
""" provides code completion for Rust
let g:racer_cmd = "/Users/mseppae/Development/target/release/racer"
let $RUST_SRC_PATH="/Users/mseppae/Development/rust/rust/src"

" Other configurations
let g:solarized_termcolors=256
colorscheme solarized
let mapleader="\<Space>"
let maplocalleader="\<Space>"

" Automatically open, but do not go to (if there are errors) the quickfix /
" location list window, or close it when is has become empty.
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

" Mappings
"" Open undotree
nnoremap <leader>u :GundoToggle<CR>
"" Press Space to turn off highlighting and clear any message already displayed.
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
"" Quick way for editing and reloading vim configuration
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
"" Search and replace with confirmation
nnoremap <leader>r :%s/<C-r><C-w>//gc<Left><Left><Left>
nnoremap <leader>gb :Gblame<CR>
vmap v <Plug>(expand_region_expand)
vmap <c-v> <Plug>(expand_region_shrink)
"" Quicker way of doing mundane tasks
nnoremap <C-f> :Files<Cr>
nnoremap <C-b> :Buffers<Cr>
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
map $ <Nop>
map ^ <Nop>
map { <Nop>
map } <Nop>
noremap K     {
noremap J     }
noremap H     ^
noremap L     $
" move vertically by visual line
nnoremap j gj
nnoremap k gk
"" Quick escape from insert and visual mode...
inoremap jk <esc>
vnoremap fd <esc>
"" Unmap esc (too far to reach)
inoremap <esc> <nop>
"" Split screen handling
""" Close all the other splits
nnoremap <leader>c :on<CR>
""" Split vertically
nnoremap <leader>v :vsplit<CR>
""" Split horizontally
nnoremap <leader>h :split<CR>

inoremap <> <><Left>
inoremap () ()<Left>
inoremap {} {}<Left>
inoremap [] []<Left>
inoremap "" ""<Left>
inoremap '' ''<Left>
inoremap `` ``<Left>

" Filetypes
"" Ruby
au BufNewFile,BufRead *.rb        set filetype=ruby
au BufNewFile,BufRead *.ru        set filetype=ruby
au BufNewFile,BufRead *.rabl      set filetype=ruby
au BufNewFile,BufRead *.gemspec   set filetype=ruby
au BufNewFile,BufRead Rakefile    set filetype=ruby
au BufNewFile,BufRead Gemfile     set filetype=ruby
au BufNewFile,BufRead Vagrantfile set filetype=ruby

"" Rust
au BufNewFile,BufRead *.rs        set filetype=rust

"" C, C++
au BufRead,BufNewFile *.h,*.c     set filetype=c.doxygen

"" Javascript & Typescript
au BufNewFile,BufRead *.js        set filetype=javascript
au BufNewFile,BufRead *.jsx       set filetype=javascript
au BufNewFile,BufRead *.ts        set filetype=typescript
au BufNewFile,BufRead *.tsx       set filetype=typescript

" Tweaks
"" Enable matchit (RubyBlock needs this)
runtime macros/matchit.vim
"" Speed up syntax highlighting in big files
syntax sync minlines=200
"" Highlight lines over 80 chars
augroup vimrc_autocmds
 autocmd BufEnter * highlight OverLength ctermbg=black guibg=#592929
 autocmd BufEnter * match OverLength /\%80v.*/
augroup END
