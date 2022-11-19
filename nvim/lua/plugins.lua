local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  print("Installing packer close and reopen Neovim...")
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'single' })
      end
    }
  }
)

return packer.startup(function(use)
  -- Have packer manage itself
  use 'wbthomason/packer.nvim' 
  
  -- Statusline
  use 'feline-nvim/feline.nvim'
  use 'nvim-lualine/lualine.nvim'
  
  -- Colorscheme
  use { "catppuccin/nvim", as = "catppuccin" }
  
  -- Nvim tree
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {'nvim-tree/nvim-web-devicons'}, -- for file icons
  }

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- CMP
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'

  -- LSP
  use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP
  use "williamboman/mason.nvim"
  use 'williamboman/mason-lspconfig.nvim'


  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)