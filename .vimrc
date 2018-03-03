set nocompatible "Enable the "improved" part of Vi-Improved
set encoding=utf-8

set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab
set backspace=indent,eol,start
set autoindent

set backup
set history=100 "Remember 100 search strings and commands

set ruler " Show the position of the cursor in the lower-right corner
set showcmd
set textwidth=78

set number " Show line numbers in the left margin
set numberwidth=3
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

set cursorline " Underline the line with the cursor on it
set autochdir " Change the directory automatically when opening a file
set omnifunc=syntaxcomplete#Complete

set mouse=a "Enable mouse in graphical mode

set incsearch "Enable incremental search: it highlights all items matching the current search string
set hlsearch "Colorize items found

syntax on "Apply syntax highlighting
filetype plugin indent on

" Key bindings
map <F9> <Esc>:setlocal spell spelllang=en<CR>
map <F10> <Esc>:setlocal spell spelllang=nl<CR>

" Packages
" Match it to have '%' match the corresponding bracked
packadd! matchit

" The Syntastic syntax checker. See https://github.com/vim-syntastic/syntastic
packadd! syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_html_checkers = ['tidy', 'eslint']
