" Standard settings
set nocompatible
filetype plugin indent on
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
set hlsearch
set incsearch          " do incremental searching
set ignorecase
set smartcase

" Encoding
set encoding=UTF-8     " Set encoding
set fileencoding=utf-8
set fileencodings=utf-8

" Tabs
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Buffers
set hidden              " Enable hidden buffers

" Visual
syntax on
set number               " Set line numbers
set ruler		         " show the cursor position all the time
set t_Co=16
set laststatus=2         " Statusline visible all the time
set background=light
set colorcolumn=80
set showcmd		         " display incomplete commands

" Vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#begin()
Plugin 'gmarik/vundle'
"" provides git blame
Plugin 'tpope/vim-fugitive'
"" provides fast file search
Plugin 'kien/ctrlp.vim'
let g:ctrlp_custom_ignore = '\.git$\|log$\|build$\|node_modules$\|\.tscache$'
let g:ctrlp_working_path_mode = 'r'
let g:ctrlp_regexp = 1
let g:ctrlp_max_files = 0           " Scan all files for search
let g:ctrlp_show_hidden = 1         " Include hidden files & folders
set wildignore+=*/.git/*,*/tmp/*,*.so,*.swp,*.zip,*.xml
"" Use ripgrep for blazing fast search
if executable('rg')
  set grepprg=rg\ --color=never
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
  let g:ctrlp_use_caching = 0
endif
"" provides adding an end after keyword
Plugin 'tpope/vim-endwise'
Plugin 'altercation/vim-colors-solarized'
"" provides linting and code quality services
Plugin 'w0rp/ale'
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
"" provides code completion
Plugin 'Valloric/YouCompleteMe'
"" provides status line
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
let g:airline_powerline_fonts = 1
let g:airline_theme='solarized'
let g:airline_solarized_bg='light'
let g:airline_section_b = '%{strftime("%a %d.%m.%Y %H:%M")}'
let g:airline_left_sep          = '▶'
let g:airline_left_alt_sep      = '»'
let g:airline_right_sep         = '◀'
let g:airline_right_alt_sep     = '«'
"" provides signs for file changes
Plugin 'airblade/vim-gitgutter'
"" provides automatic closing of quotes, parenthesis, brackets, etc.
Plugin 'Raimondi/delimitMate'
"" provides commenting via gc
Plugin 'tpope/vim-commentary'
"" provides multiple cursors
Plugin 'terryma/vim-multiple-cursors'
"" Languages
Plugin 'leafgarland/typescript-vim'
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow
Plugin 'rust-lang/rust.vim'
Plugin 'phildawes/racer'
let g:racer_cmd = "/Users/mseppae/Development/target/release/racer"
let $RUST_SRC_PATH="/Users/mseppae/Development/rust/rust/src"
Plugin 'elixir-lang/vim-elixir'
Plugin 'rhysd/vim-crystal'
call vundle#end()

" Other configurations
set omnifunc=syntaxcomplete#Complete
let g:solarized_termcolors=256
colorscheme solarized
let mapleader="\<Space>"
let maplocalleader="\<Space>"

" Mappings
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
nnoremap <leader>p :CtrlP<CR>
nnoremap <leader>B :CtrlPBuffer<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
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

" Filetypes
"" Ruby
au BufNewFile,BufRead *.rb        set filetype=ruby
au BufNewFile,BufRead *.ru        set filetype=ruby
au BufNewFile,BufRead *.rabl      set filetype=ruby
au BufNewFile,BufRead *.gemspec   set filetype=ruby
au BufNewFile,BufRead Rakefile    set filetype=ruby
au BufNewFile,BufRead Gemfile     set filetype=ruby
au BufNewFile,BufRead Vagrantfile set filetype=ruby
au Filetype ruby call RubySettings()
au Filetype ruby call RubySpecificMappings()
function! RubySettings()
  setlocal expandtab
  setlocal tabstop=2
  setlocal shiftwidth=2
  setlocal softtabstop=2
endfunction

function! RubySpecificMappings()
    nnoremap <leader>c I# <esc>
endfunction

"" Rust
au BufNewFile,BufRead *.rs        set filetype=rust

"" C, C++
au BufRead,BufNewFile *.h,*.c     set filetype=c.doxygen

"" Javascript & Typescript
au BufNewFile,BufRead *.js        set filetype=javascript
au BufNewFile,BufRead *.ts        set filetype=typescript
au BufNewFile,BufRead *.tsx       set filetype=typescript

"" HTML
au Filetype eruby call RubySettings()
au Filetype html call RubySettings()
au Filetype typescript call RubySettings()

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
