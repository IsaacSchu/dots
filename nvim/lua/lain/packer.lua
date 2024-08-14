vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'


  use {
  'nvim-telescope/telescope.nvim', tag = '0.1.8',
-- or                            , branch = '0.1.x',
  requires = { {'nvim-lua/plenary.nvim'} }
}

use( 'nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})


use{
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
}

use {
    "williamboman/mason.nvim"
}

use {
  'williamboman/mason-lspconfig.nvim',
  config = function()
    require('mason-lspconfig').setup({
      ensure_installed = { 'pyright' } -- Add other LSP servers here
    })
  end
}


use {
  'neovim/nvim-lspconfig',
  config = function()
    local lspconfig = require('lspconfig')

    -- Pyright configuration
    lspconfig.pyright.setup{}
    lspconfig.clangd.setup{}
    lspconfig.bashls.setup{}
    

    -- Or configure pylsp
    -- lspconfig.pylsp.setup{}
  end
}


 end)

