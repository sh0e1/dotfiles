" ~/.vimrc

" Vundle.vim
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'Shougo/deoplete.nvim'
if !has('nvim')
  Plugin 'roxma/nvim-yarp'
  Plugin 'roxma/vim-hug-neovim-rpc'
endif
Plugin 'Shougo/neosnippet.vim'
Plugin 'Shougo/neosnippet-snippets'
Plugin 'autozimu/languageclient-neovim'
Plugin 'itchyny/lightline.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'fatih/vim-go'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
Plugin 'junegunn/fzf.vim'
Plugin 'cohama/lexima.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'arcticicestudio/nord-vim'
Plugin 'plasticboy/vim-markdown'
Plugin 'previm/previm'
call vundle#end()
filetype plugin indent on
syntax enable

set encoding=utf-8
scriptencoding utf-8
set fileencoding=utf-8
set fileencodings=ucs-boms,utf-8,euc-jp,cp932
set fileformats=unix,dos,mac
set ambiwidth=double
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
set clipboard+=unnamed
set expandtab
set tabstop=4
set softtabstop=4
set autoindent
set smartindent
set shiftwidth=4
set mouse=a

function! DoubleBytesSpace()
    highlight DoubleBytesSpace ctermfg=15 ctermbg=88 guifg=#ffffff guibg=#bf616a
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

" colorscheme
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
let g:nord_cursor_line_number_background = 1
let g:nord_bold = 1
let g:nord_italic = 1
let g:nord_italic_comments = 1
let g:nord_underline = 1
colorscheme nord

if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" This enables us to undo files even if you exit Vim.
if has('persistent_undo')
    set undofile
    set undodir=~/.vim/undo//
endif

" key mappings
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

" Indent by file type
if has("autocmd")
    " sw=softtabstop, sts=shiftwidth, ts=tabstop, et=expandtab
    autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType json setlocal ts=2 sts=2 sw=2 expandtab
endif

" LanguageClient-neovim
let g:LanguageClient_serverCommands = {
  \ 'go': ['gopls']
  \ }
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
let g:LanguageClient_useVirtualText = 0
set signcolumn=yes

" neosnippet.vim
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

" deoplete
let g:deoplete#enable_at_startup = 1
inoremap <expr><Tab> pumvisible() ? "\<DOWN>" : "\<Tab>"
inoremap <expr><S-Tab> pumvisible() ? "\<UP>" : "\<S-Tab>"

" lightline
let g:lightline = {'colorscheme': 'nord'}

" NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeShowHidden=1
let g:NERDTreeIgnore=['\.git$', '\.idea$']

" vim-go
let g:go_fmt_command = "goimports"
let g:go_autodetect_gopath = 1
let g:go_list_type = "quickfix"
"let g:go_auto_type_info = 1
"let g:go_auto_sameids = 1
let g:go_metalinter_command = "golangci-lint"
let g:go_metalinter_enabled = ["govet", "errcheck", "staticcheck", "unused", "gosimple", "structcheck", "varcheck", "ineffassign", "deadcode"]
let g:go_metalinter_autosave = 1
let g:go_metalinter_autosave_enabled = ["govet", "errcheck", "staticcheck", "unused", "gosimple", "structcheck", "varcheck", "ineffassign", "deadcode"]
let g:go_term_mode = 'split'

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_generate_tags = 1

let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_referrers_mode = 'gopls'
let g:go_gopls_enabled = 1
let g:go_snippet_engine = "neosnippet"
let g:go_gopls_complete_unimported = 1

"let g:go_debug = ["shell-commands"]
"
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

" fzf.vim
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
let $FZF_DEFAULT_OPTS = '--reverse --inline-info'
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }
let g:fzf_buffers_jump = 1
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
let g:fzf_tags_command = 'ctags -R'
let g:fzf_commands_expect = 'alt-enter,ctrl-x'

nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case --hidden --glob "!.git/*" %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang Rg call RipgrepFzf(<q-args>, <bang>0)

" vim-gitgutter
nmap [h <Plug>(GitGutterPrevHunk)
nmap ]h <Plug>(GitGutterNextHunk)

" vim-markdown
let g:vim_markdown_folding_disabled = 1

" previm/previm
autocmd BufRead,BufNewFile *.md set filetype=markdown
let g:previm_open_cmd = 'open -a Google\ Chrome'
