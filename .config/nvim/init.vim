" dein.vim
if &compatible
  set nocompatible
endif
" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
  call dein#add('kristijanhusak/vim-hybrid-material')
  call dein#add('nvim-treesitter/nvim-treesitter', {'hook_post_update': 'TSUpdate'})

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

if dein#check_install()
  call dein#install()
endif

let s:removed_plugins = dein#check_clean()
if len(s:removed_plugins) > 0
  call map(s:removed_plugins, "delete(v:val, 'rf')")
  call dein#recache_runtimepath()
endif

" options
set encoding=utf-8
scriptencoding utf-8
set fileencoding=utf-8
set fileencodings=utf-8,euc-jp,cp932
set fileformats=unix,dos,mac
set number
set noerrorbells
set noshowmatch
set laststatus=2
set title
set spell
set confirm
set hidden
set autoread
set nobackup
set noswapfile
set wildmode=list:longest,full
set showcmd
set autowrite
set backspace=indent,eol,start
set linespace=2
set cursorline
set showtabline=2
set hlsearch
set ignorecase
set smartcase
set wrapscan
set incsearch
set list
set listchars=tab:>_,trail:_,extends:>,precedes:<,nbsp:%
set clipboard+=unnamedplus
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set smartindent
set sh=zsh

" autocmd
autocmd CursorHold * wall
autocmd CursorHoldI * wall

" key maps
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
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

" color schema
augroup highlight
  autocmd!
  autocmd ColorScheme * highlight SpecialKey ctermfg=244 ctermbg=NONE guifg=#8e9292 guibg=NONE gui=none
                    \ | highlight clear SpellBad
                    \ | highlight SpellBad cterm=underline gui=underline
augroup END

syntax enable
let g:enable_bold_font = 1
let g:enable_italic_font = 1
set background=dark
colorscheme hybrid_reverse
