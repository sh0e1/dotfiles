lua require('config.lazy')
lua require('config.keymaps')
lua require('config.terminal')

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
set clipboard+=unnamedplus
set expandtab
set tabstop=4
set softtabstop=4
set autoindent
set smartindent
set shiftwidth=4
set mouse=a
set completeopt-=preview
set sh=zsh
set cmdheight=2

" this enables us to undo files even if you exit Vim.
if has('persistent_undo')
  set undofile
  set undodir=~/.vim/undo//
endif

" coc-fzf
let g:coc_fzf_preview = 'right:50%'
let g:coc_fzf_opts = ['--reverse', '--inline-info']

nmap <Leader>f [fzf-p]

nnoremap <silent> [fzf-p]<space> :<C-u>CocFzfList<CR>
nnoremap <silent> [fzf-p]D       :<C-u>CocFzfList diagnostics<CR>
nnoremap <silent> [fzf-p]d       :<C-u>CocFzfList diagnostics --current-buf<CR>
nnoremap <silent> [fzf-p]c       :<C-u>CocFzfList commands<CR>
nnoremap <silent> [fzf-p]e       :<C-u>CocFzfList extensions<CR>
nnoremap <silent> [fzf-p]l       :<C-u>CocFzfList location<CR>
nnoremap <silent> [fzf-p]o       :<C-u>CocFzfList outline<CR>
nnoremap <silent> [fzf-p]s       :<C-u>CocFzfList -I symbols<CR>
nnoremap <silent> [fzf-p]p       :<C-u>CocFzfListResume<CR>
nnoremap <silent> [fzf-p]b       :<C-u>Buffers<CR>
nnoremap <silent> [fzf-p]r       :<C-u>Rg<CR>
nnoremap <silent> [fzf-p]f       :<C-u>Files<CR>
nnoremap <silent> [fzf-p]h       :<C-u>History<CR>
nnoremap <silent> [fzf-p]:       :<C-u>History:<CR>
nnoremap <silent> [fzf-p]/       :<C-u>History/<CR>

" neosnippet.vim
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

" imap <expr><TAB>
"   \ pumvisible() ? "\<C-n>" :
"   \ neosnippet#expandable_or_jumpable() ?
"   \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
  \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" if has('conceal')
"   set conceallevel=2 concealcursor=niv
" endif

let g:neosnippet#disable_runtime_snippets = { 'go' : 1 }
let g:neosnippet#snippets_directory = '~/.local/share/nvim/lazy/snippets/snippets'

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
let g:fzf_layout = { 'down': '40%' }

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

command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number -- '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case --hidden --glob "!.git/*" %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang Rg call RipgrepFzf(<q-args>, <bang>0)

" fern.vim
nnoremap <Leader>e :Fern . -reveal=%<CR>

function! s:init_fern() abort
  nmap <buffer> C     <Plug>(fern-action-copy)
  nmap <buffer> c     <Plug>(fern-action-clipboard-copy)
  nmap <buffer> p     <Plug>(fern-action-clipboard-paste)
  nmap <buffer> m     <Plug>(fern-action-move)
  nmap <buffer> v     <Plug>(fern-action-open:side)
  nmap <buffer> t     <Plug>(fern-action-open:tabedit)
  nmap <buffer> s     <Plug>(fern-action-open:select)
  nmap <buffer> o     <Plug>(fern-action-expand)
  nmap <buffer> K     <Plug>(fern-action-new-dir)
  nmap <buffer> N     <Plug>(fern-action-new-file)
  nmap <buffer> d     <Plug>(fern-action-remove)
  nmap <buffer> r     <Plug>(fern-action-rename)
  nmap <buffer> !     <Plug>(fern-action-terminal)
  nmap <buffer> x     <Plug>(fern-action-open:system)
  nmap <buffer> yy    <Plug>(fern-action-yank:path)
  nmap <buffer> .     <Plug>(fern-action-hidden:toggle)
  nmap <buffer> ;     <Plug>(fern-action-repeat)
  nmap <buffer> ~     <Plug>(fern-action-cd)
  nmap <buffer> a     <Plug>(fern-action-choice)
  nmap <buffer> R     <Plug>(fern-action-reload:all)
  nmap <buffer> <C-h> <C-w>h
  nmap <buffer> <C-l> <C-w>l
endfunction

augroup fern-custom
  autocmd! *
  autocmd FileType fern call s:init_fern()
augroup END

let g:fern#default_hidden                    = 1
let g:fern#mark_symbol                       = '* '
let g:fern#renderer#default#collapsed_symbol = '+ '
let g:fern#renderer#default#expanded_symbol  = '- '
let g:fern#renderer#default#leaf_symbol      = '| '
let g:fern#renderer#default#root_symbol      = '~ '
let g:fern#default_exclude = '^\%(\.git\)$'
