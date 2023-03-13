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
  -- various completion sources
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/cmp-path'
  Plug 'David-Kunz/cmp-npm'
  -- the plugin itself
  Plug 'hrsh7th/nvim-cmp'
  -- some nice symbols in the suggestions list
  Plug 'onsails/lspkind-nvim'
  -- highlight fn args on complete
  Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
  
  -- commenting
  Plug 'numToStr/Comment.nvim'
  Plug 'JoosepAlviste/nvim-ts-context-commentstring'
  
  -- snippets
  Plug 'saadparwaiz1/cmp_luasnip'
  Plug ('L3MON4D3/LuaSnip', { ['do'] = 'v1.*' })
  
  -- language stuff
  Plug 'jose-elias-alvarez/null-ls.nvim'
  Plug 'jose-elias-alvarez/typescript.nvim'
  Plug 'simrat39/rust-tools.nvim'

  -- LSP status display
  Plug 'j-hui/fidget.nvim'

  -- diagnostics
  Plug 'https://git.sr.ht/~whynothugo/lsp_lines.nvim'

  -- debugging
  Plug 'mfussenegger/nvim-dap'
  Plug 'rcarriga/nvim-dap-ui'
  -- NOTE: vscode-js-debug installed separately in ~/dev/vscode-js-debug
  Plug 'mxsdev/nvim-dap-vscode-js'
  
  -- rename
  Plug 'smjonas/inc-rename.nvim'

  -- autopair brackets
  Plug 'windwp/nvim-autopairs'
  
  -- status bar
  Plug 'freddiehaddad/feline.nvim'
  
  -- icons
  Plug 'nvim-tree/nvim-web-devicons'
  
  -- ???
  Plug 'MunifTanjim/nui.nvim'
  
  -- file browser
  Plug ('nvim-neo-tree/neo-tree.nvim', { branch = 'v2.x' })
  
  -- tabs
  Plug ('akinsho/bufferline.nvim', { tag = 'v2.*' })
  
  -- session manager
  Plug 'rmagatti/auto-session'

  -- git stuff
  Plug ('akinsho/git-conflict.nvim', { tag = '*' })
  Plug 'lewis6991/gitsigns.nvim'
  Plug 'airblade/vim-gitgutter'
  
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

