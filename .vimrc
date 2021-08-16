" General
set nocompatible      " Run in actual Vim mode
set nolangremap       " For compatibility
set encoding=utf-8
set history=1000      " Remember last thousand commands
set undofile          " Enable persistent undo, so even after closing a file and opening it again, you can use the undo functionality
set autochdir         " Change the directory automatically when opening a file

if has('mouse')       " Enable mouse if available
  set mouse=a
  set mousemodel=popup
endif

" Display
set display=truncate  " Show '@@@' to indicate that the last line is truncated
set nrformats-=octal  " Do not treat numbers starting with 0 as octal numbers

"" Line numbers
set number            " Show line numbers in the left margin
set numberwidth=3
set textwidth=78

"" Statusline
set ruler
set showcmd
set laststatus=2
set statusline=
set statusline+=%n⟩                                                 " buffernumber⟩
set statusline+=\ %t\ %M\ %y                                        " filename modified [type]
set statusline+=\ (%{&spelllang},\ %{''.(&fenc!=''?&fenc:&enc).''}) " (spelling language, encoding)
set statusline+=\ %{RutedStatus()}                                  " ruted mode 
set statusline+=\ %=\ (%l,%c)\ ⟨%3p%%\ |                            " row, column ⟨location in %

"" Cursor
set cursorline

"" (Auto) completion
set omnifunc=syntaxcomplete#Complete
set wildmenu

"" Syntax highlighting
syntax on

" Indenting
set softtabstop=2
set shiftwidth=2
set shiftround
set expandtab
set autoindent

" ESC behavior
set ttimeout
set ttimeoutlen=100 " Set the ESC timeout to 100ms instead of a full second!

" Backspace behavior
set backspace=indent,eol,start " Backspace behavior

" Search behavior
set incsearch " Incremental search shows matches while typing the search pattern.
set hlsearch " Highlight matches

" GUI
set guioptions-=T "Do not show the toolbar in gvim because I never use it!

" Key mappings
map <F9>  <Esc>:setlocal spell spelllang=en<CR>
map <F10> <Esc>:setlocal spell spelllang=nl<CR>

"   Mimick default copy/cut/paste keys
vnoremap <C-c> "+y
vnoremap <C-x> "+c
vnoremap <C-v> c<ESC>"+p


" Specific behavior for filetypes
filetype plugin indent on " Automatically detect filetype and use appropriate indentation.
augroup vimrcEx
  au!
  autocmd FileType text setlocal textwidth=78
augroup END

" Plugins installed in VIMHOME/pack/huubspackages/opt/*
packadd! coc.nvim


"" Coc for language server integration. See https://github.com/neoclide/coc.nvim
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType haskell,javascript,java,json,yaml,latex,tex setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

packadd! vim-LanguageTool
let g:languagetool_jar='$HOME/bin/LanguageTool/languagetool-commandline.jar'
let g:languagetool_lang='en-US'
""" For rules, see https://community.languagetool.org/rule/list?lang=en&offset=10&max=100
let g:languagetool_enable_rules='PASSIVE_VOICE,TOO_LONG_SENTENCE,PARAGRAPH_REPEAT_BEGINNING_RULE,EN_SPECIFIC_CASE,EN_PLAIN_ENGLISH_REPLACE,EN_REDUNDANCY_REPLACE,READABILITY_RULE_DIFFICULT,EN_SIMPLE_REPLACE,EN_WORD_COHERENCY,EN_COMPOUNDS,ENGLISH_WORD_REPEAT_BEGINNING_RULE,EN_A_VS_AN,ENGLISH_WORD_REPEAT_RULE'
let g:languagetool_enable_categories='CASING,PUNCTUATION,REDUNDANCY,PLAIN_ENGLISH,TYPOS,CONFUSED_WORDS'
let g:languagetool_disable_rules='DASH_RULE,EN_QUOTES,MULTIPLICATION_SIGN'
let g:languagetool_win_height=''

hi LanguageToolGrammarError  guisp=blue gui=undercurl guifg=NONE guibg=NONE ctermfg=white ctermbg=blue term=underline cterm=none
hi LanguageToolSpellingError guisp=red  gui=undercurl guifg=NONE guibg=NONE ctermfg=white ctermbg=red  term=underline cterm=none

packadd! ruted-vim

" Support for calculation-style proofs by coloring text in between {}
" differently. TODO: make this a plugin and fix color scheme in GVIM.
function SetupCalculationStyle()
  execute ':highlight StepCommentStyle ctermfg=green guifg=green'
  execute ':match StepCommentStyle /{[^}]\+}/'
endfunction

autocmd BufNewFile,BufRead *.md  call SetupCalculationStyle()
autocmd BufNewFile,BufRead *.txt call SetupCalculationStyle()


