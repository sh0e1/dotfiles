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
  call dein#add('Shougo/defx.nvim')
  call dein#add('autozimu/LanguageClient-neovim', {'rev': 'next', 'build': 'bash install.sh'})
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('Shougo/echodoc.vim')
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')

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

if has("autocmd")
  " sw=softtabstop, sts=shiftwidth, ts=tabstop, et=expandtab
  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType json setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType js   setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType vue  setlocal ts=2 sts=2 sw=2 expandtab
endif

" deoplete.nvim
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_delay = 0
inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ (neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>")
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" neosnippet.vim
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

" LanguageClient-neovim
let g:LanguageClient_serverCommands = {
  \ 'go': {
  \   'name': 'gopls',
  \   'command': ['gopls'],
  \   'initializationOptions': {
  \     'usePlaceholders': v:true,
  \   },
  \ },
  \ }
" let g:LanguageClient_diagnosticsDisplay = {}
let g:LanguageClient_diagnosticsSignsMax = v:null
let g:LanguageClient_changeThrottle = v:null
let g:LanguageClient_autoStart = 1
let g:LanguageClient_autoStop = 1
let g:LanguageClient_selectionUI = 'fzf'
let g:LanguageClient_selectionUI_autoOpen = 0
let g:LanguageClient_trace = 'off'
let g:LanguageClient_diagnosticsList = 'Quickfix'
let g:LanguageClient_diagnosticsEnable = 1
let g:LanguageClient_windowLogMessageLevel = 'Warning'
let g:LanguageClient_settingsPath = '.vim/settings.json'
let g:LanguageClient_loadSettings = 1
" let g:LanguageClient_loggingFile = 'null'
" let g:LanguageClient_loggingLevel = 'WARN'
" let g:LanguageClient_serverStderr = 'None'
let g:LanguageClient_rootMarkers = v:null
let g:LanguageClient_fzfOptions = v:null
let g:LanguageClient_hasSnippetSupport = 1
let g:LanguageClient_waitOutputTimeout = 100
let g:LanguageClient_hoverPreview = 'Always'
let g:LanguageClient_fzfContextMenu = 1
let g:LanguageClient_completionPreferTextEdit = 0
" let g:LanguageClient_documentHighlightDisplay = {}
let g:LanguageClient_useVirtualText = 'Diagnostics'
let g:LanguageClient_useFloatingHover = 1
let g:LanguageClient_floatingHoverHighlight = 'Normal:Pmenu'
let g:LanguageClient_usePopupHover = 1
let g:LanguageClient_virtualTextPrefix = '>> '
let g:LanguageClient_diagnosticsMaxSeverity = 'Hint'
let g:LanguageClient_diagnosticsIgnoreSources = ['go mod tidy']
let g:LanguageClient_echoProjectRoot = 0
" let g:LanguageClient_semanticHighlightMaps = {}
let g:LanguageClient_applyCompletionAdditionalTextEdits = 1
let g:LanguageClient_preferredMarkupKind = ['plaintext', 'markdown']
let g:LanguageClient_floatingWindowStyle = 'minimal'
let g:LanguageClient_hideVirtualTextsOnInsert = 1
let g:LanguageClient_setOmnifunc = v:true
" let g:LanguageClient_binaryPath = 'bin/languageclient'
let g:LanguageClient_enableExtensions = v:null
let g:LanguageClient_codeLensDisplay = {
  \ 'virtualTexthl': 'LanguageClientCodeLens',
  \ }
let g:LanguageClient_hoverMarginSize = 1
let g:LanguageClient_restartOnCrash = 1
let g:LanguageClient_maxRestartRetries = 5
let g:LanguageClient_showCompletionDocs = 0

function! s:map_language_client_functions() abort
  if has_key(g:LanguageClient_serverCommands, &filetype)
    nnoremap <silent> gi  :<C-u>call LanguageClient#textDocument_implementation()<CR>
    nnoremap <silent> gr  :<C-u>call LanguageClient#textDocument_references()<CR>
    nnoremap <silent> grn :<C-u>call LanguageClient#textDocument_rename()<CR>
    nnoremap <silent> gd  :<C-u>call LanguageClient#textDocument_definition()<CR>
    nnoremap <silent> gs  :<C-u>call LanguageClient#textDocument_definition({'gotoCmd': 'split'})<CR>
    nnoremap <silent> gv  :<C-u>call LanguageClient#textDocument_definition({'gotoCmd': 'vsplit'})<CR>
    nnoremap <silent> K   :<C-u>call LanguageClient#textDocument_hover()<CR>
  endif
endfunction

autocmd FileType * call s:map_language_client_functions()

" echodoc.vim
set cmdheight=2
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'signature'

" lightline.vim
let g:lightline = {
  \ 'colorscheme': 'wombat',
  \ }

" vim-go
let g:go_version_warning = 1
let g:go_code_completion_enabled = 0
let g:go_code_completion_icase = 0
let g:go_test_show_name = 1
let g:go_test_timeout = '10s'
let g:go_play_browser_command = ''
let g:go_play_open_browser = 1
let g:go_auto_type_info = 0
let g:go_info_mode = 'gopls'
let g:go_auto_sameids = 0
let g:go_updatetime = 800
let g:go_jump_to_error = 1
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
let g:go_snippet_engine = "neosnippet"
let g:go_get_update = 1
let g:go_guru_scope = []
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
let g:go_decls_includes = 'func、type'
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
let g:go_highlight_extra_types = 0
let g:go_highlight_space_tab_error = 0
let g:go_highlight_trailing_whitespace_error = 0
let g:go_highlight_operators = 0
let g:go_highlight_functions = 0
let g:go_highlight_function_parameters = 0
let g:go_highlight_function_calls = 0
let g:go_highlight_types = 0
let g:go_highlight_fields = 0
let g:go_highlight_build_constraints = 0
let g:go_highlight_generate_tags = 0
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
