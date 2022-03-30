" dein
if &compatible
  set nocompatible
endif
" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
  call dein#add('junegunn/fzf', {'build': './install --all', 'merged': 0})
  call dein#add('junegunn/fzf.vim', {'depends': 'fzf'})
  call dein#add('cohama/lexima.vim')
  call dein#add('airblade/vim-gitgutter')
  call dein#add('godlygeek/tabular', {'lazy': 1, 'on_ft': 'md'})
  call dein#add('plasticboy/vim-markdown', {'lazy': 1, 'on_ft': 'md'})
  call dein#add('tpope/vim-surround')
  call dein#add('bfredl/nvim-miniyank')
  call dein#add('easymotion/vim-easymotion')
  call dein#add('tpope/vim-repeat')
  call dein#add('neoclide/coc.nvim', { 'merged': 0, 'rev': 'release' })
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('christoomey/vim-tmux-navigator')
  call dein#add('antoinemadec/coc-fzf', { 'rev': 'release' })
  call dein#add('editorconfig/editorconfig-vim')
  call dein#add('sh0e1/snippets')
  call dein#add('lambdalisue/fern.vim')
  call dein#add('kassio/neoterm')
  call dein#add('andymass/vim-matchup')
  call dein#add('nvim-treesitter/nvim-treesitter', {'hook_post_update': 'TSUpdate'})
  call dein#add('nvim-treesitter/playground')
  call dein#add('projekt0n/github-nvim-theme')
  call dein#add('ray-x/go.nvim')
  call dein#add('nvim-lualine/lualine.nvim')

  call dein#end()
  call dein#save_state()
endif

" neoterm
let &runtimepath.=',~/.vim/bundle/neoterm'

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
set clipboard+=unnamedplus
set expandtab
set tabstop=4
set softtabstop=4
set autoindent
set smartindent
set shiftwidth=4
set mouse=a
set signcolumn=yes
set completeopt-=preview
set sh=zsh

" nvim-treesitter
lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
  }
}

require"nvim-treesitter.highlight".set_custom_captures {
  ["function.builtin"] = "TSFunction",
}
EOF

" color scheme
lua << EOF
require("github-theme").setup({
  theme_style = "dimmed",
  keyword_style = "NONE",
  dark_float = true,
  colors = {
    bg_search = "#ffea80",
  },
  overrides = function(c)
    return {
      Type = { fg = c.fg },
      TSType = { link = "Type" },
      TSTypeBuiltin = { link = "Type" },
      TSProperty = { fg = c.bright_blue },
      TSOperator = { fg = c.bright_blue },
      SpellBad = {},
      SpellCap = { link = SpellBad },
    }
  end
})
EOF

" this enables us to undo files even if you exit Vim.
if has('persistent_undo')
  set undofile
  set undodir=~/.vim/undo//
endif

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
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>
nnoremap [b :bprevious<CR>
nnoremap ]b :bnext<CR>
nnoremap [c :cprevious<CR>
nnoremap ]c :cnext<CR>

tnoremap <silent> <ESC> <C-\><C-n>
nnoremap <Leader>to :Topen<CR>
nnoremap <Leader>tc :Tclose!<CR>
let g:neoterm_autoinsert = 1

" nvim-miniyank
map p <Plug>(miniyank-autoput)
map P <Plug>(miniyank-autoPut)

" coc.nvim
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

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

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
nmap <silent> gs :call CocAction('jumpDefinition', 'split')<CR>
nmap <silent> gv :call CocAction('jumpDefinition', 'vsplit')<CR>

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
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
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

" coc extensions
let g:coc_global_extensions = [
  \ 'coc-word',
  \ 'coc-neosnippet',
  \ 'coc-lists',
  \ 'coc-dictionary',
  \ 'coc-yaml',
  \ 'coc-json',
  \ 'coc-spell-checker',
  \]

" goimport
autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')

" coc-fzf
let g:coc_fzf_preview = 'right:50%'
let g:coc_fzf_opts = ['--reverse', '--inline-info']

nmap <Leader>f [fzf-p]

nnoremap <silent> [fzf-p]<space> :<C-u>CocFzfList<CR>
nnoremap <silent> [fzf-p]a       :<C-u>CocFzfList diagnostics<CR>
nnoremap <silent> [fzf-p]b       :<C-u>CocFzfList diagnostics --current-buf<CR>
nnoremap <silent> [fzf-p]c       :<C-u>CocFzfList commands<CR>
nnoremap <silent> [fzf-p]e       :<C-u>CocFzfList extensions<CR>
nnoremap <silent> [fzf-p]l       :<C-u>CocFzfList location<CR>
nnoremap <silent> [fzf-p]o       :<C-u>CocFzfList outline<CR>
nnoremap <silent> [fzf-p]s       :<C-u>CocFzfList symbols<CR>
nnoremap <silent> [fzf-p]p       :<C-u>CocFzfListResume<CR>
nnoremap <silent> [fzf-p]b       :<C-u>Buffers<CR>
nnoremap <silent> [fzf-p]r       :<C-u>Rg<CR>
nnoremap <silent> [fzf-p]f       :<C-u>GFiles<CR>

" neosnippet.vim
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

imap <expr><TAB>
  \ pumvisible() ? "\<C-n>" :
  \ neosnippet#expandable_or_jumpable() ?
  \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
  \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

let g:neosnippet#disable_runtime_snippets = { 'go' : 1 }
let g:neosnippet#snippets_directory = '~/.cache/dein/repos/github.com/sh0e1/snippets/snippets'

lua << EOF
require('lualine').setup {
  options = {
    theme = "auto",
    icons_enabled = false,
    section_separators = '',
    component_separators = '',
  },
  extensions = {
    'fern',
    'fzf',
  }
}
EOF

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

" vim-gitgutter
let g:gitgutter_preview_win_floating = 0

nmap [h  <Plug>(GitGutterPrevHunk)
nmap ]h  <Plug>(GitGutterNextHunk)
nmap ghs <Plug>(GitGutterStageHunk)
nmap ghu <Plug>(GitGutterUndoHunk)
nmap ghp <Plug>(GitGutterPreviewHunk)
omap ih  <Plug>(GitGutterTextObjectInnerPending)
omap ah  <Plug>(GitGutterTextObjectOuterPending)
xmap ih  <Plug>(GitGutterTextObjectInnerVisual)
xmap ah  <Plug>(GitGutterTextObjectOuterVisual)

function! GitGutterNextHunkCycle()
  let line = line('.')
  silent! GitGutterNextHunk
  if line('.') == line
    1
    GitGutterNextHunk
  endif
endfunction

" vim-markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

" vim-easymotion
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
nmap s <Plug>(easymotion-overwin-f)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap s <Plug>(easymotion-overwin-f2)

" Turn on case-insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" fern.vim
nnoremap <Leader>d :Fern . -reveal=%<CR>

function! s:init_fern() abort
  nmap <buffer> C     <Plug>(fern-action-copy)
  nmap <buffer> c     <Plug>(fern-action-clipboard-copy)
  nmap <buffer> p     <Plug>(fern-action-clipboard-paste)
  nmap <buffer> m     <Plug>(fern-action-move)
  nmap <buffer> E     <Plug>(fern-action-open:side)
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
let g:fern#renderer#default#leading          = ' '
let g:fern#renderer#default#leaf_symbol      = ' '
let g:fern#renderer#default#root_symbol      = '~ '
let g:fern#default_exclude = '^\%(\.git\)$'

" ray-x/go.nvim
lua << EOF
require('go').setup({
  goimport = 'gopls',
  fillstruct = 'gopls',
  gofmt = 'gopls',
})

vim.cmd("autocmd FileType go nmap <Leader>l :GoLint<cr>")
EOF
