"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=$HOME/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state($HOME . '/.cache/dein')
  call dein#begin($HOME . '/.cache/dein')

  " Let dein manage dein
  " Required:
  call dein#add($HOME . '/.cache/dein/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here like this:
  "call dein#add('Shougo/neosnippet.vim')
  "call dein#add('Shougo/neosnippet-snippets')
  "call dein#add('fatih/vim-go', {'lazy': 1})

  call dein#add('Shougo/deoplete.nvim')
  let g:deoplete#enable_at_startup = 1

  call dein#add('itchyny/lightline.vim')
  let g:lightline = {'colorscheme': 'wombat'}

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

set number
set noerrorbells
set noshowmatch
set laststatus=2
set title
set spell
set encoding=utf-8
set ambiwidth=double
set confirm
set hidden
set autoread
set nobackup
set noswapfile
set wildmode=list:longest,full
set showcmd
set autowrite
set autoindent
set backspace=indent,eol,start
set helplang=ja
set linespace=2
set cursorline
set showtabline=2
set noshowmode
set hlsearch
set ignorecase
set smartcase
set wrapscan
set incsearch
set list
set listchars=tab:>_,trail:_,extends:>,precedes:<,nbsp:%
set clipboard+=unnamedplus

syntax on

function! DoubleBytesSpace()
  highlight DoubleBytesSpace ctermfg=15 ctermbg=88 guifg=#ffffff guibg=990000
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

" key mapping
let mapleader = "\<Space>"
inoremap <silent> jj <ESC>
noremap j gj
noremap k gk
vnoremap j gj
vnoremap k gk
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

