" dein
if &compatible
  set nocompatible
endif
" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
  call dein#add('itchyny/lightline.vim')
  call dein#add('fatih/vim-go')
  call dein#add('junegunn/fzf', {'build': './install --all', 'merged': 0})
  call dein#add('junegunn/fzf.vim', {'depends': 'fzf'})
  call dein#add('cohama/lexima.vim')
  call dein#add('airblade/vim-gitgutter')
  call dein#add('plasticboy/vim-markdown', {'lazy': 1, 'on_ft': 'md'})
  call dein#add('previm/previm', {'lazy': 1, 'on_ft': 'md'})
  call dein#add('kristijanhusak/vim-hybrid-material')
  call dein#add('tpope/vim-surround')
  call dein#add('bfredl/nvim-miniyank')
  call dein#add('easymotion/vim-easymotion')
  call dein#add('tpope/vim-repeat')
  call dein#add('sheerun/vim-polyglot')
  call dein#add('neoclide/coc.nvim', { 'merged': 0 })
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('christoomey/vim-tmux-navigator')
  call dein#add('antoinemadec/coc-fzf', { 'rev': 'release' })
  call dein#add('editorconfig/editorconfig-vim')
  call dein#add('sh0e1/snippets')
  call dein#add('lambdalisue/fern.vim')

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
set signcolumn=yes
set completeopt-=preview

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

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" coc extensions
let g:coc_global_extensions = [
  \ 'coc-word',
  \ 'coc-neosnippet',
  \ 'coc-lists',
  \ 'coc-dictionary',
  \ 'coc-yaml',
  \ 'coc-json',
  \]

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

" lightline.vim
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
let g:go_version_warning = 1
let g:go_code_completion_enabled = 0
let g:go_code_completion_icase = 0
let g:go_test_show_name = 1
let g:go_test_timeout = '10s'
let g:go_play_browser_command = 'chrome'
let g:go_play_open_browser = 1
let g:go_auto_type_info = 0
let g:go_info_mode = 'gopls'
let g:go_auto_sameids = 0
let g:go_updatetime = 800
let g:go_jump_to_error = 0
let g:go_fmt_autosave = 1
let g:go_fmt_command = 'goimports'
let g:go_fmt_options = {}
let g:go_fmt_fail_silently = 0
let g:go_fmt_experimental = 0
let g:go_imports_autosave = 0
let g:go_imports_mode = 'goimports'
let g:go_mod_fmt_autosave = 1
let g:go_doc_keywordprg_enabled = 0
let g:go_doc_max_height = 20
let g:go_doc_url = 'https：//pkg.go.dev'
let g:go_odc_popup_window = 0
let g:go_def_mode = 'gopls'
let g:go_fillstruct_mode = 'fillstruct'
let g:go_referrers_mode = 'gopls'
let g:go_implements_mode = 'gopls'
let g:go_def_mapping_enabled = 0
let g:go_def_reuse_buffer = 0
let g:go_bin_path = ''
let g:go_search_bin_path_first = 1
let g:go_snippet_engine = ""
let g:go_get_update = 1
"let g:go_guru_scope = []
let g:go_build_tags = ''
let g:go_textobj_enabled = 1
let g:go_textobj_include_function_doc = 1
let g:go_textobj_include_variable = 1
let g:go_metalinter_autosave = 1
let g:go_metalinter_autosave_enabled = ['govet', 'errcheck', 'staticcheck', 'unused', 'gosimple', 'structcheck', 'varcheck', 'ineffassign', 'deadcode']
let g:go_metalinter_enabled = ['govet', 'errcheck', 'staticcheck', 'unused', 'gosimple', 'structcheck', 'varcheck', 'ineffassign', 'deadcode']
let g:go_metalinter_command = 'golangci-lint'
let g:go_metalinter_deadline = "5s"
let g:go_list_height = 0
let g:go_list_type = 'quickfix'
let g:go_list_type_commands = {}
let g:go_list_autoclose = 1
let g:go_asmfmt_autosave = 0
let g:go_term_mode = 'split'
let g:go_term_reuse = 1
let g:go_term_height = 30
let g:go_term_width = 30
let g:go_term_enabled = 1
let g:go_term_close_on_exit = 1
let g:go_alternate_mode = "edit"
let g:go_rename_command = 'gopls'
let g:go_gorename_prefill = 'expand("<cword>") =~# "^[A-Z]"' .
  \ '? go#util#pascalcase(expand("<cword>"))' .
  \ ': go#util#camelcase(expand("<cword>"))'
let g:go_gopls_enabled = 1
let g:go_gopls_options = ['-remote = auto']
let g:go_gopls_analyses = v:null
let g:go_gopls_complete_unimported = v:null
let g:go_gopls_deep_completion = v:null
let g:go_gopls_matcher = v:null
let g:go_gopls_staticcheck = v:null
let g:go_gopls_use_placeholders = v:null
let g:go_gopls_temp_modfile = v:null
let g:go_gopls_local = v:null
let g:go_gopls_gofumpt = v:null
let g:go_gopls_settings = v:null
let g:go_diagnostics_enabled = 0
let g:go_diagnostics_level = 0
let g:go_template_autocreate = 1
let g:go_template_file = 'hello_world.go'
let g:go_template_test_file = 'hello_world_test.go'
let g:go_template_use_pkg = 0
let g:go_decls_includes = 'func,type'
let g:go_decls_mode = "fzf"
let g:go_echo_command_info = 1
let g:go_echo_go_info = 1
let g:go_statusline_duration = 60000
let g:go_addtags_transform = 'snakecase'
let g:go_addtags_skip_unexported = 0
let g:go_debug = []

let g:go_fold_enable = ['block', 'import', 'varconst', 'package_comment']
let g:go_highlight_array_whitespace_error = 0
let g:go_highlight_chan_whitespace_error = 0
let g:go_highlight_extra_types = 1
let g:go_highlight_space_tab_error = 0
let g:go_highlight_trailing_whitespace_error = 0
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_parameters = 0
let g:go_highlight_function_calls = 0
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_build_constraints = 0
let g:go_highlight_generate_tags = 1
let g:go_highlight_string_spellcheck = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_variable_declarations = 0
let g:go_highlight_variable_assignments = 0
let g:go_highlight_diagnostic_errors = 1
let g:go_highlight_diagnostic_warnings = 1

" Open :GoDeclsDir with ctrl-g
nmap <C-g> :GoDeclsDir<cr>
imap <C-g> <esc>:<C-u>GoDeclsDir<cr>

augroup go
  autocmd!
  " :GoBuild and :GoTestCompile
  autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
  " :GoRun
  autocmd FileType go nmap <leader>r  <Plug>(go-run)
  " :GoTest
  autocmd FileType go nmap <leader>t  <Plug>(go-test)
  " :GoTestFunc
  autocmd FileType go nmap <leader>tt  <Plug>(go-test-func)
  " :GoMetaLinter
  autocmd FileType go nmap <Leader>l <Plug>(go-metalinter)
  " :GoDoc
  "autocmd FileType go nmap <Leader>d <Plug>(go-doc)
  " :GoInfo
  "autocmd FileType go nmap <Leader>i <Plug>(go-info)
  " :GoCoverageToggle
  autocmd FileType go nmap <Leader>cc <Plug>(go-coverage-toggle)
  " :GoDef but opens in a vertical split
  "autocmd FileType go nmap <Leader>v <Plug>(go-def-vertical)
  " :GoDef but opens in a horizontal split
  "autocmd FileType go nmap <Leader>s <Plug>(go-def-split)
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

" previm/previm
autocmd BufRead,BufNewFile *.md set filetype=markdown
let g:previm_open_cmd = 'open -a Google\ Chrome'

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
