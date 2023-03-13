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
-- debug config
require('plugins.dap')

-- Needed for colour scheme
vim.opt.termguicolors = true

-- Tree-sitter configuration
require('nvim-treesitter.configs').setup({
  -- commenting
  context_commenting = {
    enable = true,
  },
  -- syntax colouring
  highlight = {
    additional_vim_regex_highlighting = false,
    enable = true,
  },
  refactor = {
    -- TODO: not working highlight def and usage of thing under cursor
    -- but it goes crazy if i press "*"
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
      -- TODO:  this might be causing errors
      -- peek_definition_code = {
      --   ["<leader>df"] = "@function.outer",
      --   ["<leader>dF"] = "@class.outer",
      -- },
    },
  },
})

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

require('Comment').setup({
  hook = function()
    -- if vim.api.nvim_buf_get_option(0, "filetype") == "vue" then
      require("ts_context_commentstring.internal").update_commentstring()
    -- end
  end
})

require("null-ls").setup()

local rt = require("rust-tools")

rt.setup({
  server = {
    -- TODO: this probably overrides everything in lsp.lua...
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

vim.keymap.set("n", "<leader>tsrn", function()
return ";TypescriptRenameFile " .. vim.fn.expand("<cword>")
end, { expr = true })

require('lsp_lines').setup()

-- TODO: where are my underlines, sigh
vim.diagnostic.config({
  underline = true,
  virtual_text = false,
})

-- trying out this eslint setup
require('lspconfig').eslint.setup({})

-- debug config
require("dapui").setup()
require("dap-vscode-js").setup({
  -- path to DAP build
  debugger_path = '~/dev/vscode-js-debug',
})

-- create debug jobs for TS and JS
for _, language in ipairs({ "typescript", "javascript" }) do
  require("dap").configurations[language] = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Launch file",
      program = "${file}",
      cwd = "${workspaceFolder}",
    },
    {
      type = "pwa-node",
      request = "attach",
      name = "Attach",
      processId = require'dap.utils'.pick_process,
      cwd = "${workspaceFolder}",
    },
    {
      type = "pwa-node",
      request = "launch",
      name = "Debug Jest Tests",
      -- trace = true, -- include debugger info
      runtimeExecutable = "node",
      runtimeArgs = {
        "./node_modules/jest/bin/jest.js",
        "--runInBand",
      },
      rootPath = "${workspaceFolder}",
      cwd = "${workspaceFolder}",
      console = "integratedTerminal",
      internalConsoleOptions = "neverOpen",
    }
  }
end

require('bufferline').setup({
  options = {
    color_icons = true,
    -- show full filename in tab
    truncate_names = false,
  },
})

-- TODO: some icon is just a red square
require('neo-tree').setup({
  filesystem = {
    filtered_items = {
      visible = true
    },
    use_libuv_file_watcher = false
  }
})

-- why it stop :((
require('auto-session').setup({
  auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/"},
  post_restore_cmds = {
    function()
      require 'neo-tree.sources.manager'.show('filesystem')
    end
  },
  pre_save_cmds = {
    function()
		  require("neo-tree.sources.manager").close_all()
    end
  },
})

require('git-conflict').setup()
require('gitsigns').setup()

require('trouble').setup({})

vim.keymap.set('n', '<Leader>xx', '<cmd>TroubleToggle<cr>', { silent = true, noremap = true })

require("todo-comments").setup({})

vim.keymap.set('n', '<Leader>ft', '<cmd>TodoTelescope<cr>', { silent = true, noremap = true })

-- set up color scheme for various plugins
require('catppuccin').setup({
  integrations = {
    cmp = true,
    fidget = true,
    gitsigns = true,
    lsp_trouble = true,
    native_lsp = {
      enabled = true,
      -- TODO: still doesn't work
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

-- adding some commands here to try and make them work

-- show max line length indicator
vim.o.colorcolumn = '100'

-- soft word wrapping
vim.o.wrap = true
vim.o.linebreak = true
vim.o.breakindent = true
vim.o.list = false

-- use system clipboard (i think)
vim.opt.clipboard="unnamedplus"

-- if we get sick of those error messages
-- vim.opt.swapfile = false
