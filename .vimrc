set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" add plugins here:
Plugin 'vim-pandoc/vim-pandoc'
Plugin 'vim-pandoc/vim-pandoc-syntax' 
Plugin 'itchyny/lightline.vim'
Plugin 'scrooloose/syntastic'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required


set backspace=indent,eol,start
set incsearch
set hlsearch
set textwidth=78
set encoding=utf-8
set softtabstop=4
set shiftwidth=4
set expandtab
set number
set cursorline
set smartindent
set wildmode=list:longest 
set ignorecase 
set smartcase
set title
set scrolloff=3
set mouse=a
set t_Co=256
set tabpagemax=20

" (extra) Settings for statusline
set laststatus=2


" (extra) Settings for syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

syntax on

" Mappings
map <F9> <Esc>:setlocal spell spelllang=en<CR>
" Turn the Control+F5 key into a compile tex document now key
" The % is the current file name. With annotation :r only the root withouth
" extension is used.
map <C-F5> <Esc>:! xelatex %; biber %:r; xelatex %<CR><CR>
