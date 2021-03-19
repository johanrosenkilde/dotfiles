" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2002 Sep 19
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc
"



"### BRAM's STUFF ###############################
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
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" Don't use Ex mode, use Q for formatting
map Q gq

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

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

  " For all text files set 'textwidth' to 79 characters.
  autocmd FileType text setlocal textwidth=79

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")


set backup backupdir=~/.vim
"### MY GUI SETUP ###############################
set bs=2 ts=8 sts=4 sw=4 tw=79 ai nohls is showmatch nojs et noea fo=tcroq
set visualbell
if has("gui_running")
    set modeline
    set modelines=5
    set mousemodel=popup
    set scrolloff=3
    set columns=80
    "set guioptions=aegimrLt
    set guioptions=agim
    set guifont=DejaVu\ Sans\ Mono\ 7
    set linespace=1 "ONLY BECAUSE OF BUG IN DejaVu Sans Mono 7
else
    " For VimOrganizer: Make sure that Ctrl-Enter actually maps to Ctrl-Enter 
    " and not new-line in terminals
    map <NL> <C-Enter>
    map T <S-Enter> 
endif


"### MY KEY MAPPINGS ###############################
"Backspace to backspace
map  <BS>
" F2 saves and calls make
map <F2> :w<CR>:make
" F3 saves and calls !<last command> (e.g. for special makes)
map <F3> :w<CR>:!<Up><CR>
"Capital S := stamp of last yank over current word or current selection
nnoremap S diw"0P
vnoremap S "0P

" For Tagbar
function! ToggleTagbarWidth()
    if &columns == 121 
        set columns=80 
    else 
        set columns=121 
    endif
endfunction
map <F8> :TagbarToggle<CR>:call ToggleTagbarWidth()<CR>

" For quick macro editing functionality qp,qd
noremap qp n"qp
noremap qd G0"qd$:q!

" For Enhanced Commentify
let g:EnhCommentifyUserBindings = 'yes'
vmap <C-c> :call EnhancedCommentify('','guess')<CR>
vmap <C-x> :call EnhancedCommentify('','comment')<CR>
vmap <C-o> :call EnhancedCommentify('','decomment')<CR>

"### FILE TYPES ###############################
"Illegal C++ keywords (e.g. dispose) are not highlighted when editing  Java
let java_allow_cpp_keywords = 1
"For ml, set tab size to 2
au BufNewFile,BufRead {*.ml,*.mly,*.mll} set sts=2 sw=2
au BufNewfile,BufRead *.tex syntax sync minlines=300 maxlines=500
"Detect Sage files as Python
augroup filetypedetect
au BufNewfile,BufRead *.sage        set filetype=python
au BufNewfile,BufRead *.sheet       set filetype=python
augroup END
"Detect F# files
augroup filetypedetect
au BufNewfile,BufRead *.fs          set filetype=fs
augroup END

" Define what is words in LaTeX for my style of labels
au FileType tex     set iskeyword=@,48-57,_,-,:,192-255

"For VimOrganizer
function! LoadOrg()
    call org#SetOrgFileType()
    map <A-h> <A-left>
    map <A-j> <A-down>
    map <A-k> <A-up>
    map <A-l> <A-right>
    set guioptions-=m
    set syntax=on
    colo distinguished
endfunction
au! BufRead,BufWrite,BufWritePost,BufNewFile *.org 
au BufRead,BufNewFile *.org      call LoadOrg()
au! BufRead,BufWrite,BufWritePost,BufNewFile *.org 



map <C-enter> ?###v/###<C-s>
