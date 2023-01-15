local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd [[packadd packer.nvim]]
end

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'projekt0n/github-nvim-theme'
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use 'nvim-treesitter/playground'
  use 'lambdalisue/fern.vim'
  use 'nvim-lualine/lualine.nvim'
  use 'kassio/neoterm'
  use 'junegunn/fzf.vim'
  use {'neoclide/coc.nvim', branch = 'release'}
  use {'antoinemadec/coc-fzf', branch = 'release'}
  use 'Shougo/neosnippet.vim'
  use 'Shougo/neosnippet-snippets'
  use 'sh0e1/snippets'
  use 'cohama/lexima.vim'
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  use 'bfredl/nvim-miniyank'
  use 'christoomey/vim-tmux-navigator'
  use 'andymass/vim-matchup'
  use 'editorconfig/editorconfig-vim'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'airblade/vim-gitgutter'
  use 'ray-x/go.nvim'
  use {
    'phaazon/hop.nvim',
    branch = 'v2',
    config = function()
      require'hop'.setup {}
    end
  }
  use 'haya14busa/vim-edgemotion'
  -- install without yarn or npm
  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
