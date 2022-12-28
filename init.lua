-- base config that affects plugin settings etc

-- set SPACE as leader key
vim.g.mapleader = " "

-- load plugins
require('plugins')

-- LSP config
require('lsp')
-- nvim-cmp config
require('cmp')
-- telescope config
require('plugins.telescope')

-- Needed for colour scheme
vim.opt.termguicolors = true

-- code folding
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
-- disable folding everything at startup
vim.opt.foldenable = false

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

-- cursor setup
vim.opt.guicursor = 'i:block'
vim.opt.guicursor:append('i:blinkon100')

-- line numbers
vim.opt.number = true

-- tab setup
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

-- soft word wrapping
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.list = false

-- swap : and ; for easier commands
vim.keymap.set('n', ';', ':')
vim.keymap.set('n', ':', ';')

-- TODO: what is?
vim.g.loaded_netrwPlugin = 1

local augroup = vim.api.nvim_create_augroup('NEOTREE_AUGROUP', { clear = true })

-- enable colour scheme
vim.cmd.colorscheme('catppuccin')

vim.cmd[[
augroup NEOTREE_AUGROUP
  autocmd!
  au VimEnter * lua vim.defer_fn(function() vim.cmd("Neotree show left") end, 10)
augroup END

" red squiggles
" hi LspDiagnosticsUnderlineError guifg=NONE ctermfg=NONE cterm=underline gui=underline
" hi LspDiagnosticsUnderlineWarning guifg=NONE ctermfg=NONE cterm=underline gui=underline
" hi LspDiagnosticsUnderlineInformation guifg=NONE ctermfg=NONE cterm=underline gui=underline
" hi LspDiagnosticsUnderlineHint guifg=NONE ctermfg=NONE cterm=underline gui=underline
]]

