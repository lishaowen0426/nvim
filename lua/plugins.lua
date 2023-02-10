
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()


vim.cmd ([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end	
]])


return require('packer').startup(function(use)
   use 'wbthomason/packer.nvim' 

   use {
	'nvim-tree/nvim-tree.lua',
	requires = {
		'nvim-tree/nvim-web-devicons'
	},
	config = function() require'config.nvim-tree' end,
   }

    use 'ayu-theme/ayu-vim'

  use {'ludovicchabant/vim-gutentags', config = require 'config.nvim-gutentags'}

     use { 'nvim-treesitter/nvim-treesitter', run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end, config = require 'config.user-treesitter' }

   use {
	'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = 'nvim-lua/plenary.nvim', }
   
   use {'neovim/nvim-lspconfig', config = function() require 'config.user-lsp' end } 

   -- Visualize lsp progress
  use {
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup()
    end
    }

  use { 'hrsh7th/nvim-cmp', config = function() require 'config.user-cmp' end }
  use 'hrsh7th/cmp-nvim-lsp' 
  use 'hrsh7th/cmp-buffer' 
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-path'
  use 'saadparwaiz1/cmp_luasnip' 
  use 'rafamadriz/friendly-snippets'
  use {'L3MON4D3/LuaSnip', config = function() require('config.user-snippets') end,}

  use 'voldikss/vim-floaterm'

  use 'simrat39/rust-tools.nvim' 

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end


end)


