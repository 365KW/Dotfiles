syntax on
filetype plugin indent on
set autoindent

set tabstop=4 shiftwidth=4 expandtab
autocmd BufEnter * if &filetype == "go" | setlocal noexpandtab | endif

set number
"set relativenumber

set incsearch hlsearch ignorecase smartcase

set clipboard=unnamedplus
set mouse=a
set wildmenu

"set iminsert=0
"set imsearch=0

"set noesckeys
set cinoptions=l1
set modeline
"set autochdir

autocmd BufNewFile,BufRead ?\+.c3 setf c

map gf :e <cfile><CR>
map <leader>D :execute 'normal! a' . system('date -u "+(%Y%m%d-%H%M%S)"')<CR>
