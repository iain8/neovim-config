set termguicolors

" set leader to space
let mapleader="\<Space>"

" code folding
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set nofoldenable " Disable folding at startup.

lua << EOF
  require('plugins')

  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      -- Enable underline, use default values
      underline = true,
      -- Enable virtual text only on Warning or above, override spacing to 2
      -- virtual_text = {
      --   spacing = 2,
      --   severity_limit = "Warning",
      -- },
    }
  )

  -- time for LSP keybinds
  local opts = { noremap=true, silent=true }
  vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
  vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
  vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

  -- Use an on_attach function to only map the following keys
  -- after the language server attaches to the current buffer
  local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    -- this doesn't seem to work
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    -- TODO: should we remove this now?
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
  end

  local lsp_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150,
  }

  -- disabled because we are using typescript.nvim!
  --require('lspconfig')['tsserver'].setup{
  --  on_attach = on_attach,
  --  flags = lsp_flags,
  --}

  require('lspconfig')['rust_analyzer'].setup{
    on_attach = on_attach,
    flags = lsp_flags,
    -- Server-specific settings...
    settings = {
      ["rust-analyzer"] = {}
    }
  }

  -- Load custom tree-sitter grammar for org filetype
  require('orgmode').setup_ts_grammar()

  -- Tree-sitter configuration
  require'nvim-treesitter.configs'.setup {
    -- syntax highlighting
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = {'org'},
    },
    refactor = {
      -- highlight def and usage of thing under cursor
      highlight_definitions = {
        enable = true,
      },
      -- let's try this out
      navigation = {
        enable = true,
        keymaps = {
          list_definitions = "gnD",
          list_definitions_toc = "gO",
          goto_next_usage = "<a-*>",
          goto_previous_usage = "<a-#>",
        },
      },
    },
    indentation = true,
    ensure_installed = {'org'},
    textobjects = {
      lsp_interop = {
        enable = true,
        border = 'none',
        peek_definition_code = {
          ["<leader>df"] = "@function.outer",
          ["<leader>dF"] = "@class.outer",
        },
      },
    },
  }

  require('orgmode').setup({
    org_agenda_files = {'~/Dropbox/org/*', '~/my-orgs/**/*'},
    org_default_notes_file = '~/Dropbox/org/refile.org',
  })

  require('Comment').setup()

  local cmp = require('cmp')
  local luasnip = require("luasnip")

  cmp.setup({
    mapping = {
      ['<Up>'] = cmp.mapping.select_prev_item(),
      ['<Down>'] = cmp.mapping.select_next_item(),
      ['<C-Space>'] = cmp.mapping.complete(),
      -- space to cancel suggestion (hopefully)
      ['<Right>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      },
--      ['<Tab>'] = function(fallback)
--        if cmp.visible() then
--          cmp.select_next_item()
--        elseif luasnip.expand_or_jumpable() then
--          luasnip.expand_or_jump()
--        else
--          fallback()
--        end
--      end,
      ['<S-Tab>'] = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end,
    },
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'buffer' },
      { name = 'luasnip' }
    })
  })

  cmp.setup.cmdline(';', {
--    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
--      { name = 'path' }
--    }, {
      { name = 'cmdline' }
    })
  })

  local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

  require("typescript").setup({
    server = {
      capabilities = capabilities
    }
  })
  vim.keymap.set('n', '<leader>gd', ':TypescriptGoToSourceDefinition<CR>', {})

  require("null-ls").setup()

  require("eslint").setup({
    bin = 'eslint',
    code_actions = {
      enable = true,
      apply_on_save = {
        enable = false,
      },
      disable_rule_comment = {
        enable = true,
        location = "separate_line", -- or `same_line`
      },
    },
    diagnostics = {
      enable = true,
      report_unused_disable_directives = true,
      run_on = "type", -- or `save`
    },
  })

  local rt = require("rust-tools")

  rt.setup({
    server = {
      on_attach = function(_, bufnr)
        -- Hover actions
        vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
        -- Code action groups
        vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
      end,
    },
  })

  local telescope = require("telescope")
  local telescopeConfig = require("telescope.config")

  -- Clone the default Telescope configuration
  local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

  -- I want to search in hidden/dot files.
  table.insert(vimgrep_arguments, "--hidden")
  -- I don't want to search in the `.git` directory.
  table.insert(vimgrep_arguments, "--glob")
  table.insert(vimgrep_arguments, "!**/.git/*")

  telescope.setup({
	  defaults = {
		  -- `hidden = true` is not supported in text grep commands.
		  vimgrep_arguments = vimgrep_arguments,
	  },
	  pickers = {
		  find_files = {
			  -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
			  find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
		  },
	  },
  })

  local builtin = require('telescope.builtin')
  vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
  vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
  vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
  vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

  require('inc_rename').setup()
  -- TODO: can we autosave all the files that are changed?
  vim.keymap.set("n", "<leader>rn", function()
    return ":IncRename " .. vim.fn.expand("<cword>")
  end, { expr = true })

  require('feline').setup()

  require('lsp_lines').setup()

  vim.diagnostic.config({
    virtual_text = false,
  })

  require('bufferline').setup({})

  require('neo-tree').setup({
    filesystem = {
      filtered_items = {
        visible = true
      },
      use_libuv_file_watcher = false
    }
  })
  require('session_manager').setup({
    autoload_mode = require('session_manager.config').AutoloadMode.LastSession,
    autosave_last_session = true
  })

  require('git-conflict').setup()
  require('gitsigns').setup()
EOF

" cursor setup
set guicursor=i:block
set guicursor+=i:blinkon100
set number

" tab setup
set expandtab
set shiftwidth=2
set tabstop=2

" swap : and ; for easier commands
nnoremap ; :
nnoremap : ;

" soft word wrapping
:set wrap linebreak nolist

" red squiggles
hi LspDiagnosticsUnderlineError guifg=NONE ctermfg=NONE cterm=underline gui=underline
hi LspDiagnosticsUnderlineWarning guifg=NONE ctermfg=NONE cterm=underline gui=underline
hi LspDiagnosticsUnderlineInformation guifg=NONE ctermfg=NONE cterm=underline gui=underline
hi LspDiagnosticsUnderlineHint guifg=NONE ctermfg=NONE cterm=underline gui=underline

let loaded_netrwPlugin = 1

colorscheme catppuccin " catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha

augroup NEOTREE_AUGROUP
  autocmd!
  au VimEnter * lua vim.defer_fn(function() vim.cmd("Neotree show left") end, 10)
augroup END

