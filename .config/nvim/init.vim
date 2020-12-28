" dein
if &compatible
  set nocompatible
endif
" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('itchyny/lightline.vim')
  call dein#add('fatih/vim-go')
  call dein#add('junegunn/fzf', {'build': './install --all', 'merged': 0})
  call dein#add('junegunn/fzf.vim', {'depends': 'fzf'})
  call dein#add('cohama/lexima.vim')
  call dein#add('neoclide/coc.nvim', {'merged': 0, 'rev': 'release'})
  call dein#add('airblade/vim-gitgutter')
  call dein#add('plasticboy/vim-markdown', {'lazy': 1, 'on_ft': 'md'})
  call dein#add('previm/previm', {'lazy': 1, 'on_ft': 'md'})
  call dein#add('kristijanhusak/vim-hybrid-material')
  call dein#add('tpope/vim-surround')
  call dein#add('bfredl/nvim-miniyank')
  call dein#add('easymotion/vim-easymotion')
  call dein#add('Shougo/defx.nvim')

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

if &term =~ "xterm"
  let &t_SI .= "\e[?2004h"
  let &t_EI .= "\e[?2004l"
  let &pastetoggle = "\e[201~"

  function XTermPasteBegin(ret)
    set paste
    return a:ret
  endfunction

  inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif

augroup highlight
  autocmd!
  autocmd ColorScheme * highlight SpecialKey ctermfg=244 ctermbg=NONE guifg=#8e9292 guibg=NONE gui=none
                    \ | highlight clear SpellBad
                    \ | highlight SpellBad cterm=underline gui=underline
augroup END

" color scheme
set termguicolors
let g:enable_bold_font = 1
let g:enable_italic_font = 1
colorscheme hybrid_reverse

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
map [c :cprevious<CR>
map ]c :cnext<CR>

" nvim-miniyank
map p <Plug>(miniyank-autoput)
map P <Plug>(miniyank-autoPut)

if has("autocmd")
  " sw=softtabstop, sts=shiftwidth, ts=tabstop, et=expandtab
  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType json setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType js   setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType vue  setlocal ts=2 sts=2 sw=2 expandtab
endif

" deoplete.nvim
let g:deoplete#enable_at_startup = 1

" coc.nvim
" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
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
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" neosnippet.vim
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

" lightline
function! CocCurrentFunction()
  let f = get(b:, 'coc_current_function', '')
  return f == '' ? '' : f . '()'
endfunction

" Helper function for LightlineCoc*() functions.
function! s:lightline_coc_diagnostic(kind, sign) abort
  let info = get(b:, 'coc_diagnostic_info', 0)
  if empty(info) || get(info, a:kind, 0) == 0
    return ''
  endif
  return printf("%s %d", a:sign, info[a:kind])
endfunction

" Used in LightLine config to show diagnostic messages.
function! LightlineCocErrors() abort
  return s:lightline_coc_diagnostic('error', '●')
endfunction
function! LightlineCocWarnings() abort
    return s:lightline_coc_diagnostic('warning', "●")
endfunction
function! LightlineCocInfos() abort
  return s:lightline_coc_diagnostic('information', "●")
endfunction
function! LightlineCocHints() abort
  return s:lightline_coc_diagnostic('hints', "●")
endfunction

let g:lightline = {
  \ 'colorscheme': 'wombat',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'readonly', 'relativepath', 'modified' ],
  \             [ 'coc_error', 'coc_warning', 'coc_info', 'coc_hint' ], ] },
  \ 'component_expand': {
  \   'coc_error': 'LightlineCocErrors',
  \   'coc_warning': 'LightlineCocWarnings',
  \   'coc_info': 'LightlineCocInfos',
  \   'coc_hint': 'LightlineCocHints' },
  \ 'component_type': {
  \   'coc_error': 'error',
  \   'coc_warning': 'warning',
  \   'coc_info': 'tabsel',
  \   'coc_hint': 'middle' },
  \ 'component_function': {
  \   'currentfunction': 'CocCurrentFunction' },
  \ }

autocmd User CocDiagnosticChange call lightline#update()

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
let g:go_gopls_complete_unimported = 1
let g:go_decls_mode = "fzf"
let g:go_snippet_engine = "neosnippet"

"let g:go_debug = ["shell-commands"]

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
nmap [h <Plug>(GitGutterPrevHunk)
nmap ]h <Plug>(GitGutterNextHunk)

" vim-markdown
let g:vim_markdown_folding_disabled = 1

" previm/previm
autocmd BufRead,BufNewFile *.md set filetype=markdown
let g:previm_open_cmd = 'open -a Google\ Chrome'

" vim-easymotion
" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)

" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

" defx.nvim
nnoremap <silent> <Leader>e :<C-u>silent call <SID>open_defx()<CR>
autocmd FileType defx call s:defx_map_settings()
autocmd FileType defx call defx#custom#column('mark', {
  \   'length': 1,
  \   'readonly_icon': 'X',
  \   'selected_icon': '*',
  \ })
autocmd FileType call defx#custom#column('indent', {
  \   'indent': '  ',
  \ })
autocmd FileType call defx#custom#column('icon', {
  \   'directory_icon': '▸',
  \   'opened_icon':    '▾',
  \   'root_icon':      '  ',
  \ })

function! s:defx_map_settings() abort
  " Define mappings
  nnoremap <silent><buffer><expr> <CR>    defx#do_action('open')
  nnoremap <silent><buffer><expr> c       defx#do_action('copy')
  nnoremap <silent><buffer><expr> m       defx#do_action('move')
  nnoremap <silent><buffer><expr> p       defx#do_action('paste')
  nnoremap <silent><buffer><expr> l       defx#do_action('open')
  nnoremap <silent><buffer><expr> E       defx#do_action('open', 'vsplit')
  nnoremap <silent><buffer><expr> t       defx#do_action('open', 'tabnew')
  nnoremap <silent><buffer><expr> P       defx#do_action('preview')
  nnoremap <silent><buffer><expr> o       defx#do_action('open_tree', 'toggle')
  nnoremap <silent><buffer><expr> K       defx#do_action('new_directory')
  nnoremap <silent><buffer><expr> N       defx#do_action('new_file')
  nnoremap <silent><buffer><expr> M       defx#do_action('new_multiple_files')
  nnoremap <silent><buffer><expr> C       defx#do_action('toggle_columns', 'mark:indent:icon:filename:type:size:time')
  nnoremap <silent><buffer><expr> S       defx#do_action('toggle_sort', 'time')
  nnoremap <silent><buffer><expr> d       defx#do_action('remove')
  nnoremap <silent><buffer><expr> r       defx#do_action('rename')
  nnoremap <silent><buffer><expr> !       defx#do_action('execute_command')
  nnoremap <silent><buffer><expr> x       defx#do_action('execute_system')
  nnoremap <silent><buffer><expr> yy      defx#do_action('yank_path')
  nnoremap <silent><buffer><expr> .       defx#do_action('toggle_ignored_files')
  nnoremap <silent><buffer><expr> ;       defx#do_action('repeat')
  nnoremap <silent><buffer><expr> h       defx#do_action('cd', ['..'])
  nnoremap <silent><buffer><expr> ~       defx#do_action('cd')
  nnoremap <silent><buffer><expr> q       defx#do_action('quit')
  nnoremap <silent><buffer><expr> <Space> defx#do_action('toggle_select') . 'j'
  nnoremap <silent><buffer><expr> *       defx#do_action('toggle_select_all')
  nnoremap <silent><buffer><expr> j       line('.') == line('$') ? 'gg' : 'j'
  nnoremap <silent><buffer><expr> k       line('.') == 1 ? 'G' : 'k'
  nnoremap <silent><buffer><expr> <C-l>   defx#do_action('redraw')
  nnoremap <silent><buffer><expr> <C-g>   defx#do_action('print')
  nnoremap <silent><buffer><expr> cd      defx#do_action('change_vim_cwd')
endfunction

autocmd BufWritePost * call defx#redraw()

function! s:open_defx() abort
  let opts = [
    \   '-no-show-ignored-files',
    \   '-ignored-files=.git',
    \ ]
  call defx#util#call_defx('Defx', join(opts, ' '))
endfunction
