-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.5',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }
  use {'nvim-telescope/telescope-ui-select.nvim' }

  use({
	  "ellisonleao/gruvbox.nvim",
	  as = 'gruvbox',
  })
  use({
      'sainnhe/sonokai',
  })

  use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
  use 'mbbill/undotree'

  use {
      'VonHeikemen/lsp-zero.nvim',
      branch = 'v3.x',
      requires = {
          --- Uncomment the two plugins below if you want to manage the language servers from neovim
          {'williamboman/mason.nvim'},
          {'williamboman/mason-lspconfig.nvim'},

          -- LSP Support
          {'neovim/nvim-lspconfig'},
          -- Autocompletion
          {'hrsh7th/nvim-cmp'},
          {'hrsh7th/cmp-nvim-lsp'},
          {'L3MON4D3/LuaSnip'},
          {'rafamadriz/friendly-snippets'},
          {'saadparwaiz1/cmp_luasnip'},
      }
  }

  use 'Wansmer/symbol-usage.nvim'

  use {
      "windwp/nvim-autopairs",
      event = "InsertEnter",
      config = function()
          require("nvim-autopairs").setup {}
      end
  }

  use {
      'kos666/goimpl.nvim',
      requires = {
          {'nvim-lua/plenary.nvim'},
          {'nvim-lua/popup.nvim'},
          {'nvim-telescope/telescope.nvim'},
          {'nvim-treesitter/nvim-treesitter'},
      },
      config = function()
          require'telescope'.load_extension'goimpl'
      end,
  }
end)
