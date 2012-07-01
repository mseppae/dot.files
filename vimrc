" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

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

" Pathogen
silent! call pathogen#helptags()
silent! call pathogen#infect()

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

" Indententation with 2 spaces
set sw=2 sts=2 et

" No beeping.
set visualbell

" Line numbering
set number

" Encoding
set encoding=UTF-8

" Press Space to turn off highlighting and clear any message already displayed.
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

colorscheme vividchalk

set hidden

" FuzzyFinder
let mapleader = ","
nmap ,f :FufCoverageFile<CR>

" Highlight unwanted whitespace
highlight RedundantSpaces ctermbg=red guibg=red
match     RedundantSpaces "\s\+$\| \+\ze\t"

" Remove whitespace
map ,w :%s/\s\+$\\| \+\ze\t//g<CR>

" Search and replace with confirmation
map ,s :%s/<C-r><C-w>//gc<Left><Left><Left>

" Coffee script compiling
map ,cc :CoffeeCompile<CR>

" Rabl syntax
au BufRead,BufNewFile *.rabl setf ruby

" Enable matchit (RubyBlock needs this)
runtime macros/matchit.vim

" Highlight lines over 80 chars
augroup vimrc_autocmds
 autocmd BufEnter * highlight OverLength ctermbg=darkgrey guibg=#592929
 autocmd BufEnter * match OverLength /\%80v.*/
augroup END

" remove stupid warning when doing git commit
let g:LustyExplorerSuppressRubyWarning = 1
