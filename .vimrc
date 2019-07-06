" ~/.vimrc

" Vundle.vim
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'fatih/vim-go'
Plugin 'scrooloose/nerdtree'
Plugin 'prabirshrestha/async.vim'
Plugin 'prabirshrestha/vim-lsp'
Plugin 'SirVer/ultisnips'
Plugin 'Shougo/unite.vim'
Plugin 'cohama/lexima.vim'
call vundle#end()
filetype plugin indent on

set ttyfast                    " Indicate fast terminal conn for faster redraw
set ttymouse=xterm2            " Indicate terminal type for mouse codes
set ttyscroll=3                " Speedup scrolling
set number                     " Show line numbers
set noerrorbells               " No beeps
set noshowmatch                " Do not show matching brackets by flickering
set laststatus=2               " Show status line always
set title                      " Show title
set spell                      " Spelling checker set spelllang=en,cjk Language to check spelling
set encoding=utf-8             " Set default encoding to UTF-8
set ambiwidth=double           " Ambiguous character width
set confirm                    " If there are unstored files, save before saving
set hidden                     " Buffer should still exist if window is closed
set autoread                   " Automatically read changed files
set nobackup                   " Don't create annoying backup files
set noswapfile                 " Don't use swapfile
set wildmode=list:longest,full " Complement mode
set showcmd                    " Show me what I'm typing
set autowrite                  " Automatically save before :next, :make etc
set autoindent                 " Enable auto indent
set backspace=indent,eol,start " Makes backspace key more powerful
set helplang=ja                " Display help in Japanese
set guifont=Monaco:h12         " GUI font
set linespace=2                " Set line spacing
set cursorline                 " Show cursor line
" Show Invisible character
set list
set listchars=tab:>_,trail:_,extends:>,precedes:<,nbsp:%
set clipboard+=unnamed " clipboard

" color scheme
syntax on
" Show double bytes space
function! DoubleBytesSpace()
    highlight DoubleBytesSpace ctermfg=15 ctermbg=88 guifg=#ffffff guibg=#990000
endfunction

if has('syntax')
    augroup DoubleBytesSpace
        autocmd!
        autocmd ColorScheme       * call DoubleBytesSpace()
        autocmd VimEnter,WinEnter * match DoubleBytesSpace /　/
    augroup END
    call DoubleBytesSpace()
endif

augroup highlight
    autocmd!
    autocmd ColorScheme * highlight SpecialKey ctermfg=244 ctermbg=NONE guifg=#8e9292 guibg=NONE gui=none
                      \ | highlight clear SpellBad
                      \ | highlight SpellBad cterm=underline gui=underline
augroup END

colorscheme darcula

" This enables us to undo files even if you exit Vim.
if has('persistent_undo')
    set undofile
    set undodir=~/.vim/undo//
endif

" key bind
let mapleader = "\<Space>"
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>
inoremap <silent> jj <ESC>
noremap j gj
noremap k gk

" Indent by file type
if has("autocmd")
    " sw=softtabstop, sts=shiftwidth, ts=tabstop, et=expandtab
    autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType json setlocal ts=2 sts=2 sw=2 expandtab
endif

" go-langserver
if executable('go-langserver')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'go-langserver',
        \ 'cmd': {server_info->['go-langserver', '-mode', 'stdio']},
        \ 'whitelist': ['go'],
        \ })
endif

" vim-go
let g:go_fmt_command = "goimports"
let g:go_autodetect_gopath = 1
let g:go_list_type = "quickfix"
"let g:go_auto_type_info = 1
"let g:go_auto_sameids = 1
let g:go_metalinter_autosave = 1
let g:go_term_mode = 'split'

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_generate_tags = 1

" Open :GoDeclsDir with ctrl-g
nmap <C-g> :GoDeclsDir<cr>
imap <C-g> <esc>:<C-u>GoDeclsDir<cr>

augroup go
    autocmd!
    " Show by default 4 spaces for a tab
    autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
    " :GoBuild and :GoTestCompile
    autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
    " :GoRun
    autocmd FileType go nmap <leader>r  <Plug>(go-run)
    " :GoTest
    autocmd FileType go nmap <leader>t  <Plug>(go-test)
    " :GoMetaLinter
    autocmd FileType go nmap <Leader>l <Plug>(go-metalinter)
    " :GoDoc
    autocmd FileType go nmap <Leader>d <Plug>(go-doc)
    " :GoInfo
    autocmd FileType go nmap <Leader>i <Plug>(go-info)
    " :GoCoverageToggle
    autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
    " :GoDef but opens in a vertical split
    autocmd FileType go nmap <Leader>v <Plug>(go-def-vertical)
    " :GoDef but opens in a horizontal split
    autocmd FileType go nmap <Leader>s <Plug>(go-def-split)
    " :GoAlternate  commands :A, :AV, :AS and :AT
    autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
    autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
    autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
    autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
augroup END

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
    let l:file = expand('%')
    if l:file =~# '^\f\+_test\.go$'
        call go#test#Test(0, 1)
    elseif l:file =~# '^\f\+\.go$'
        call go#cmd#Build(0)
    endif
endfunction

" NERDTree
nmap <C-n><C-t> :NERDTreeToggle<CR>

" unite.vim
