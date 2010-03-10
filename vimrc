"
" vimrc
"
syntax enable
color desert

" turn these ON:
set backspace=indent,eol,start
set history=1000    " keep 50 lines of command line history
set incsearch hlsearch
set tabstop=2 shiftwidth=2 expandtab smarttab autoindent smartindent
set digraph esckeys hidden ruler showcmd wildmenu
set visualbell showmatch title
set wrap
set backspace=2 formatoptions=cqrt laststatus=2 shortmess=at
set whichwrap=<,>,h,l
set comments=b:#,:%,fb:-,n:>,n:)
set viminfo=%,'50,\"100,:100,n~/.viminfo

"nnoremap <F2> :set invpaste paste?<CR>
"set pastetoggle=<F2>
"set invpaste paste
nmap <silent> ,p :set invpaste<CR>:set paste?<CR>

if has("vms")
  set nobackup    " do not keep a backup file, use versions instead
else
  set backup      " keep a backup file
endif

" turn these OFF:
set noerrorbells nostartofline nocompatible nocp

vnoremap p <Esc>:let current_reg = @"<CR>gvs<C-R>=current_reg<CR><Esc>

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " For all text files set 'textwidth' to 78 characters.
  " au FileType text setlocal tw=78

  " When editing a file, always jump to the last known cursor position.
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

endif " has("autocmd")

" Make # keep its normal indentation so it works as a comment
inoremap # X#

" mappings:
map <C-Z> :shell<CR>
map <C-A> <Home>
map <C-E> <End>
map <C-K> d$A <ESC>
map  :set hls!<CR>
map T :retab<CR>
map ,v :e ~/.vimrc<CR>

highlight comment ctermfg=yellow

set t_mr=[0;1;37;44m  " Make the status bar blue
set t_me=[m           " The bottom line is bold-white
set t_vb=               " Shhhhh!

if filereadable(expand($HOME . "/.vim/syntax/puppet.vim"))
  source ~/.vim/syntax/puppet.vim
endif

let g:pydiction_location = '~/.vim/ftplugin/pydiction/complete-dict'
