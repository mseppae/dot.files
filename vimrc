" Setting up plugins
"   Prerequisite: mkdir -p ~/.vim/pack/plugins/start/
"
"   fzf
"   git clone --depth 1 https://github.com/junegunn/fzf.vim ~/.vim/pack/plugins/start/fzf
"   Prerequisities: brew install fzf
"                   $(brew --prefix)/opt/fzf/install
"
"   ale (asynchronous lint engine)
"   git clone --depth 1 https://github.com/dense-analysis/ale ~/.vim/pack/plugins/start/ale
"
"   vim-airline
"   git clone --depth 1 https://github.com/vim-airline/vim-airline ~/.vim/pack/plugins/start/vim-airline
"   fonts: https://github.com/runsisi/consolas-font-for-powerline
"
"   vim-airline-themse
"   git clone --depth 1 https://github.com/vim-airline/vim-airline-themes ~/.vim/pack/plugins/start/vim-airline-themes
"   Run: :helptags ~/.vim/pack/plugins/start/vim-airline-themes/doc
"
"   vim-colors-solarized
"   git clone --depth 1 https://github.com/altercation/vim-colors-solarized ~/.vim/pack/plugins/start/vim-colors-solarized
"
"   nerdTREE
"   git clone --depth 1 https://github.com/scrooloose/nerdtree.git ~/.vim/pack/plugins/start/nerdtree
"
"   vim-fugitive
"   git clone --depth 1 https://github.com/tpope/vim-fugitive.git ~/.vim/pack/plugins/start/vim-fugitive
"
"   vim-wiki
"   git clone --depth 1 https://github.com/vimwiki/vimwiki ~/.vim/pack/plugins/start/vimwiki
"
"   vim-go
"   git clone --depth 1 https://github.com/fatih/vim-go.git ~/.vim/pack/plugins/start/vim-go
"   Run: :GoInstallBinaries
"   cheatsheet: https://tpaschalis.github.io/vim-go-setup/#cheatsheet
"
"   Gundo
"   git clone --depth 1 https://github.com/sjl/gundo.vim ~/.vim/pack/plugins/start/gundo
"
"   vim-prettier
"   git clone --depth 1 https://github.com/vim-airline/vim-airline ~/.vim/pack/plugins/start/vim-prettier

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

" Undo
set undofile           " Maintain undo history between sessions
set undodir=~/.vim/undodir

"" Searching
set hlsearch           " highlight search
set incsearch          " do incremental searching (search while typing)
set ignorecase
set smartcase

" Encoding
set encoding=utf-8     " Set encoding
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
set background=dark
" set colorcolumn=80
set showcmd		         " display incomplete commands

" vim-go - Go development
" let g:go_fmt_command = "goimports"  " Run go imports along go fmt on each save
let g:go_auto_type_info = 1         " Automatically get signature/type info for object under curso" Automatically open autocomplete on .
au filetype go inoremap <buffer> . .<C-x><C-o>

" Fuzzy searching
"" fzf integration
set rtp+=/opt/homebrew/opt/fzf

" Gundo - Graphical undo tree
let g:gundo_prefer_python3 = 1

" Linting
"" w0rp/ale provides linting and code quality services
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'typescript': ['eslint', 'tslint'],
\   'ruby': ['rubocop']
\}
let g:ale_fixers = {
\   'javascript': ['prettier'],
\   'typescript': ['prettier'],
\   '*': ['remove_trailing_lines', 'trim_whitespace']
\}
let g:ale_fix_on_save = 1
let g:airline#extensions#ale#enabled = 1

" Vim Airline
"" provides status line
let g:airline_powerline_fonts = 1
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'
let g:airline_section_b = '%{strftime("%a %d.%m.%Y %H:%M")}'

" Language packs
let g:polyglot_disabled = ['graphql']

" Vim Wiki
let g:vimwiki_list = [{'path': '~/Development/notes/'}]

" Rust
"" Code completion
""" provides code completion for Rust
let g:racer_cmd = "/Users/mseppae/Development/target/release/racer"
let $RUST_SRC_PATH="/Users/mseppae/Development/rust/rust/src"

" Vim-prettier
packloadall

" NERDTree plugin specific commands
:nnoremap <C-g> :NERDTreeToggle<CR>

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
nnoremap <leader>gb :Git blame<CR>
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
"" inoremap <esc> <nop>
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
au BufNewFile,BufRead Dockerfile* set syntax=dockerfile

"" Rust
au BufNewFile,BufRead *.rs        set filetype=rust

"" C, C++
au BufRead,BufNewFile *.h,*.c     set filetype=c.doxygen

"" Javascript & Typescript
au BufNewFile,BufRead *.js        set filetype=javascript
au BufNewFile,BufRead *.jsx       set filetype=javascript
au BufNewFile,BufRead *.ts        set filetype=typescript
au BufNewFile,BufRead *.tsx       set filetype=typescript

" Tabs
autocmd Filetype html setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype ruby setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype javascript setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype typescript setlocal ts=2 sw=2 sts=2 expandtab
autocmd Filetype html setlocal ts=2 sw=2 sts=2 expandtab

" Tweaks
"" Enable matchit (RubyBlock needs this)
runtime macros/matchit.vim
"" Speed up syntax highlighting in big files
syntax sync minlines=200
"" Highlight lines over 80 chars
"augroup vimrc_autocmds
" autocmd BufEnter * highlight OverLength ctermbg=black guibg=#592929
" autocmd BufEnter * match OverLength /\%80v.*/
"augroup END
