local Plug = vim.fn['plug#']

-- TODO: add
-- something for TODOs

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

  -- diagnostics
  Plug 'https://git.sr.ht/~whynothugo/lsp_lines.nvim'
  
  -- rename
  Plug 'smjonas/inc-rename.nvim'
  
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
  
  -- session restore
  Plug 'https://github.com/Shatur/neovim-session-manager'
  
  -- git stuff
  Plug ('akinsho/git-conflict.nvim', { tag = '*' })
  Plug 'lewis6991/gitsigns.nvim'
  
  -- theme
  Plug ('catppuccin/nvim', { ['as'] = 'catppuccin' })

vim.call('plug#end')

