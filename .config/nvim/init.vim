lua require('plugins')

" neoterm
let &runtimepath.=',~/.local/share/nvim/site/pack/packer/start/neoterm'

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

" nvim-treesitter
lua << EOF
require('nvim-treesitter.configs').setup {
  ensure_installed = "all",
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        ["]]"] = "@function.outer",
      },
      goto_previous_start = {
        ["[["] = "@function.outer",
      }
    },
  },
  playground = {
    enable = true,
  },
}
EOF

" highlight
lua << EOF
vim.api.nvim_set_hl(0, "@function.builtin", { link = "@function" })
vim.api.nvim_set_hl(0, "@punctuation.bracket", { link = "@text" })
vim.api.nvim_set_hl(0, "@text.diff.add", { link = "DiffAdd" })
vim.api.nvim_set_hl(0, "@text.diff.change", { link = "DiffChange" })
vim.api.nvim_set_hl(0, "@text.diff.delete", { link = "DiffDelete" })
vim.api.nvim_set_hl(0, "@text.diff.text", { link = "DiffText" })
EOF

" color scheme
lua << EOF
require("github-theme").setup({
  theme_style = "dimmed",
  keyword_style = "NONE",
  dark_float = true,
  overrides = function(c)
    return {
      Type = { fg = c.fg },
      SpellBad = {},
      SpellCap = { link = SpellBad },
      ['@type'] = { link = 'Type' },
      ['@field'] = { fg = c.bright_blue },
      ['@property'] = { fg = c.bright_blue },
      ['@operator'] = { fg = c.bright_blue },
      ['@string.escape'] = { fg = c.syntax.string },
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

tnoremap <silent> <ESC> <C-\><C-n>
nnoremap <Leader>tt :Ttoggle<CR>
nnoremap <Leader>to :Topen<CR>
nnoremap <Leader>tc :Tclose!<CR>
let g:neoterm_autoinsert = 1

" nvim-miniyank
map p <Plug>(miniyank-autoput)
map P <Plug>(miniyank-autoPut)

" lexima.vim
" https://github.com/cohama/lexima.vim/issues/65
let g:lexima_no_default_rules = 1
call lexima#set_default_rules()
call lexima#insmode#map_hook('before', '<CR>', '')

" coc.nvim
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gs :call CocActionAsync('jumpDefinition', 'split')<CR>
nmap <silent> gv :call CocActionAsync('jumpDefinition', 'vsplit')<CR>

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
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

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
" xmap if <Plug>(coc-funcobj-i)
" omap if <Plug>(coc-funcobj-i)
" xmap af <Plug>(coc-funcobj-a)
" omap af <Plug>(coc-funcobj-a)
" xmap ic <Plug>(coc-classobj-i)
" omap ic <Plug>(coc-classobj-i)
" xmap ac <Plug>(coc-classobj-a)
" omap ac <Plug>(coc-classobj-a)

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
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

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
" https://github.com/golang/tools/blob/master/gopls/doc/vim.md#cocnvim
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
let g:neosnippet#snippets_directory = '~/.local/share/nvim/site/pack/packer/start/snippets/snippets'

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
    'fugitive',
  }
}
EOF

" fzf.vim
set rtp+=/usr/local/opt/fzf

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
let g:fern#renderer#default#leaf_symbol      = '| '
let g:fern#renderer#default#root_symbol      = '~ '
let g:fern#default_exclude = '^\%(\.git\)$'

" ray-x/go.nvim
lua << EOF
require('go').setup({
  disable_defaults = true,
  goimport = 'gopls',
  fillstruct = 'gopls',
  gofmt = 'gopls',
  lsp_cfg = false,
  gopls_remote_auto = true,
  textobjects = true,
  test_runner = 'go',
  verbose_tests = true,
})
EOF

" phaazon/hop.nvim
lua << EOF
local hop = require('hop')
local directions = require('hop.hint').HintDirection
vim.keymap.set('', 'f', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
end, { remap=true })
vim.keymap.set('', 'F', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
end, { remap=true })
vim.keymap.set('', 't', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
end, { remap=true })
vim.keymap.set('', 'T', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
end, { remap=true })
vim.keymap.set('n', 's', function()
  hop.hint_char2({ multi_windows = true })
end, { remap=true })
vim.keymap.set('v', 's', function()
  hop.hint_char2()
end, { remap=true })
vim.keymap.set('', '<Leader>L', function()
  hop.hint_lines()
end, { remap=true })
vim.keymap.set('n', '<Leader>L', function()
  hop.hint_lines({ multi_windows = true })
end, { remap=true })
vim.keymap.set('', '<Leader>w', function()
  hop.hint_words()
end, { remap=true })
vim.keymap.set('n', '<Leader>w', function()
  hop.hint_words({ multi_windows = true })
end, { remap=true })
EOF

" mfussenegger/nvim-treehopper
lua << EOF
vim.keymap.set('o', 'm', ':<C-U>lua require("tsht").nodes()<CR>', { silent = true })
vim.keymap.set('x', 'm', ':lua require("tsht").nodes()<CR>', { noremap = true, silent = true })
EOF
