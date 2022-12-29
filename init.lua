-- look for config files in the right place (not sure why this doesn't happen by default
vim.opt.runtimepath:append(',~/.config/nvim')

-- base config that affects plugin settings etc
require('base')

-- load plugins
require('plugins')

-- LSP config
require('plugins.lsp')
-- nvim-cmp config
require('plugins.cmp')
-- telescope config
require('plugins.telescope')

-- Needed for colour scheme
vim.opt.termguicolors = true

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

vim.o.foldcolumn = '0'
-- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevel = 99 
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

require('ufo').setup({
  provider_selector = function(bufnr, filetype, buftype)
    return {'treesitter', 'indent'}
  end
})

-- TODO: see if orgmode is actually useful
require('orgmode').setup({
  org_agenda_files = {'~/Dropbox/org/*', '~/my-orgs/**/*'},
  org_default_notes_file = '~/Dropbox/org/refile.org',
})

require('Comment').setup()

require("null-ls").setup()

-- TODO: validate i work
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

-- TODO: why no work
require('session_manager').setup({
  autoload_mode = require('session_manager.config').AutoloadMode.LastSession,
  autosave_last_session = true
})

require('git-conflict').setup()
require('gitsigns').setup()

require('trouble').setup({})

vim.keymap.set('n', '<Leader>xx', '<cmd>TroubleToggle<cr>', { silent = true, noremap = true })

-- set up color scheme for various plugins
require('catppuccin').setup({
  integrations = {
    cmp = true,
    fidget = true,
    gitsigns = true,
    lsp_trouble = true,
    native_lsp = {
      enabled = true,
      underline = {
        errors = { 'underline' },
        hints = { 'underline' },
        warnings = { 'underline' },
        information = { 'underline' },
      },
    },
    neotree = true,
    telescope = true,
    treesitter = true,
  }
})

-- set up status bar with color scheme
local ctp_feline = require('catppuccin.groups.integrations.feline')

require("feline").setup({
  components = ctp_feline.get(),
})

-- enable colour scheme
vim.cmd.colorscheme('catppuccin-mocha')

vim.cmd[[
augroup NEOTREE_AUGROUP
  autocmd!
  au VimEnter * lua vim.defer_fn(function() vim.cmd("Neotree show left") end, 10)
augroup END

" red squiggles TODO: do they work??
" hi LspDiagnosticsUnderlineError guifg=NONE ctermfg=NONE cterm=underline gui=underline
" hi LspDiagnosticsUnderlineWarning guifg=NONE ctermfg=NONE cterm=underline gui=underline
" hi LspDiagnosticsUnderlineInformation guifg=NONE ctermfg=NONE cterm=underline gui=underline
" hi LspDiagnosticsUnderlineHint guifg=NONE ctermfg=NONE cterm=underline gui=underline
]]

