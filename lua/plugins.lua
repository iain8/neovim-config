local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')
  -- treesitter stuff
  Plug ('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
  Plug 'nvim-treesitter/nvim-treesitter-textobjects'
  Plug 'nvim-treesitter/nvim-treesitter-refactor'
  
  -- important utils
  Plug 'nvim-lua/plenary.nvim'
  
  -- search
  Plug 'nvim-telescope/telescope.nvim'
  
  -- code completion
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/cmp-path'
  Plug 'David-Kunz/cmp-npm'
  Plug 'hrsh7th/nvim-cmp'
  
  -- commenting
  Plug 'numToStr/Comment.nvim'
  
  -- snippets
  Plug 'saadparwaiz1/cmp_luasnip'
  Plug ('L3MON4D3/LuaSnip', { ['do'] = 'v1.*' })
  
  -- language stuff
  Plug 'jose-elias-alvarez/null-ls.nvim'
  Plug 'jose-elias-alvarez/typescript.nvim'
  Plug 'simrat39/rust-tools.nvim'
  Plug 'nvim-orgmode/orgmode'
  Plug 'MunifTanjim/eslint.nvim'

  -- LSP status display
  Plug 'j-hui/fidget.nvim'

  -- diagnostics
  Plug 'https://git.sr.ht/~whynothugo/lsp_lines.nvim'
  
  -- rename
  Plug 'smjonas/inc-rename.nvim'

  -- autopair brackets
  Plug 'windwp/nvim-autopairs'
  
  -- status bar
  Plug 'feline-nvim/feline.nvim'
  
  -- icons
  Plug 'kyazdani42/nvim-web-devicons'
  
  -- ???
  Plug 'MunifTanjim/nui.nvim'
  
  -- file browser
  Plug ('nvim-neo-tree/neo-tree.nvim', { branch = 'v2.x' })
  
  -- tabs
  Plug ('akinsho/bufferline.nvim', { tag = 'v2.*' })
  
  -- workspace and session manager
  Plug 'gnikdroy/projections.nvim'
  
  -- git stuff
  Plug ('akinsho/git-conflict.nvim', { tag = '*' })
  Plug 'lewis6991/gitsigns.nvim'
  
  -- theme
  Plug ('catppuccin/nvim', { ['as'] = 'catppuccin' })

  -- warnings window
  Plug 'folke/trouble.nvim'

  -- TODOs!
  Plug 'folke/todo-comments.nvim'

  -- making folds better
  Plug 'kevinhwang91/promise-async' 
  Plug 'kevinhwang91/nvim-ufo'
vim.call('plug#end')

