" Standard settings
set nocompatible
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set nobackup		       " do not keep a backup file, use versions instead
set noswapfile
set history=1000	       " keep 1000 lines of command line history
set ruler		       " show the cursor position all the time
set showcmd		       " display incomplete commands
set incsearch		       " do incremental searching
set autoindent		       " always set autoindenting on
set visualbell                 " No stupid beeping
set number                     " Set line numbers
set encoding=UTF-8             " Set encoding
set autoread                   " Reload files when changed on disk
set clipboard=unnamed
set colorcolumn=80
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set hidden
set background=light
set t_Co=16
set laststatus=2                " Statusline visible all the time
let g:solarized_termcolors=256
colorscheme solarized
syntax on
let mapleader="\<Space>"

" Highlight unwanted whitespace
highlight RedundantSpaces ctermbg=red guibg=red
match     RedundantSpaces "\s\+$\| \+\ze\t"

" Mappings - Normal mode
" Press Space to turn off highlighting and clear any message already displayed.
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" Quick way for editing and reloading vim configuration
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Remove whitespace
nnoremap <leader>w :%s/\s\+$\\| \+\ze\t//g<CR>

" Search and replace with confirmation
nnoremap <leader>sr :%s/<C-r><C-w>//gc<Left><Left><Left>

nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit<CR>

vmap v <Plug>(expand_region_expand)
vmap <c-v> <Plug>(expand_region_shrink)

" Quicker way of doing mundane tasks
nnoremap <leader>p :CtrlP<CR>
nnoremap <leader>b :CtrlPBuffer<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>

" Mappings - Insert mode
" Quick escape from insert and visual mode...
inoremap jk <esc>
vnoremap df <esc>
" ... and enforce using it
inoremap <esc> <nop>

" Filetypes
" Ruby
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

" C, C++
au BufRead,BufNewFile *.h,*.c set filetype=c.doxygen

function! CSpecificMappings()
    set expandtab
    set tabstop=4
    set shiftwidth=4
    set softtabstop=4
endfunction

" Javascript & Typescript
au BufNewFile,BufRead *.js        set filetype=javascript
au BufNewFile,BufRead *.ts        set filetype=typescript

" HTML
au Filetype eruby call RubySettings()
au Filetype html call RubySettings()

" Vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'tpope/vim-fugitive'
Bundle 'kien/ctrlp.vim'
" Ctrlp config
let g:ctrlp_working_path_mode = 'r'
let g:ctrlp_regexp = 1
let g:ctrlp_max_files = 0           " Scan all files for search
let g:ctrlp_show_hidden = 1         " Include hidden files & folders
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.xml

Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-endwise'
Bundle 'altercation/vim-colors-solarized'
Bundle 'leafgarland/typescript-vim'
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow
Bundle 'scrooloose/syntastic'
let g:syntastic_ruby_checkers = ['rubocop']
Bundle 'Valloric/YouCompleteMe'
Bundle 'terryma/vim-expand-region'
Bundle 'skalnik/vim-vroom'
Bundle 'bling/vim-airline'
let g:airline_theme='solarized'
let g:airline_solarized_bg='light'
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_section_z=''

" Tweaks
" Enable matchit (RubyBlock needs this)
runtime macros/matchit.vim

" Speed up syntax highlighting in big files
syntax sync minlines=200

" Highlight lines over 80 chars
augroup vimrc_autocmds
 autocmd BufEnter * highlight OverLength ctermbg=black guibg=#592929
 autocmd BufEnter * match OverLength /\%80v.*/
augroup END
