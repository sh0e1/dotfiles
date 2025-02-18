vim.cmd("filetype plugin indent on")
vim.cmd("syntax enable")

vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.fileencodings = { "ucs-boms", "utf-8", "euc-jp", "cp932" }
vim.opt.fileformats = { "unix", "dos", "mac" }
vim.opt.ambiwidth = "double"
vim.opt.number = true
vim.opt.errorbells = false
vim.opt.showmatch = false
vim.opt.laststatus = 2
vim.opt.title = true
vim.opt.confirm = true
vim.opt.hidden = true
vim.opt.autoread = true
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.wildmode = { "list:longest", "full" }
vim.opt.showcmd = true
vim.opt.autowrite = true
vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.helplang = "ja"
vim.opt.linespace = 2
vim.opt.cursorline = true
vim.opt.showtabline = 2
vim.opt.showmode = false
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wrapscan = true
vim.opt.incsearch = true
vim.opt.list = true
vim.opt.listchars = { tab = ">_", trail = "_", extends = ">", precedes = "<", nbsp = "%" }
vim.opt.clipboard:append("unnamedplus")
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.shiftwidth = 4
vim.opt.mouse = "a"
vim.opt.cmdheight = 2
vim.opt.completeopt:remove("preview")
vim.opt.shell = "zsh"

-- this enables us to undo files even if you exit Vim.
if vim.fn.has("persistent_undo") == 1 then
  vim.opt.undofile = true
  vim.opt.undodir = vim.fn.expand("~/.vim/undo//")
end
