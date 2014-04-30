" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=1000	" keep 1000 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" Indententation
set sw=2 sts=2 et                         " Default intendation
autocmd FileType ruby setlocal expandtab shiftwidth=2 softtabstop=2
autocmd FileType javascript setlocal expandtab shiftwidth=4 softtabstop=4
autocmd FileType typescript setlocal expandtab shiftwidth=4 softtabstop=4

set visualbell                            " No stupid beeping
set number                                " Set line numbers
set encoding=UTF-8                        " Set encoding
set autoread                              " Reload files when changed on disk

" Press Space to turn off highlighting and clear any message already displayed.
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

syntax on
set background=light
set t_Co=16
let g:solarized_termcolors=256
colorscheme solarized

set hidden

" Vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'kien/ctrlp.vim'
let g:ctrlp_working_path_mode = 'r'
let g:ctrlp_regexp = 1
let g:ctrlp_max_files = 0           " Scan all files for search
let g:ctrlp_clear_cache_on_exit = 0 " Cross-session caching
let g:ctrlp_show_hidden = 1         " Include hidden files & folders
map <c-b> :CtrlPBuffer<CR>
set wildignore+=*/tmp/*,*.so,*.swp,*.zip

Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-endwise'
Bundle 'altercation/vim-colors-solarized'
au BufRead,BufNewFile *.ts setlocal filetype=typescript
Bundle 'leafgarland/typescript-vim'
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install (update) bundles
" :BundleSearch(!) foo - search (or refresh cache first) for foo
" :BundleClean(!)      - confirm (or auto-approve) removal of unused bundles

" Highlight unwanted whitespace
highlight RedundantSpaces ctermbg=red guibg=red
match     RedundantSpaces "\s\+$\| \+\ze\t"

" Remove whitespace
map ,w :%s/\s\+$\\| \+\ze\t//g<CR>

" Search and replace with confirmation
map ,s :%s/<C-r><C-w>//gc<Left><Left><Left>

" Rabl syntax
au BufRead,BufNewFile *.rabl setf ruby

" Enable matchit (RubyBlock needs this)
runtime macros/matchit.vim

" Speed up syntax highlighting in big files
syntax sync minlines=200

" Highlight lines over 80 chars
augroup vimrc_autocmds
 autocmd BufEnter * highlight OverLength ctermbg=black guibg=#592929
 autocmd BufEnter * match OverLength /\%80v.*/
augroup END

set clipboard=unnamed

set colorcolumn=80
