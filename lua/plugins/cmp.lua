local cmp = require('cmp')
local luasnip = require("luasnip")

vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

-- npm completion source
require('cmp-npm').setup({})

require('nvim-autopairs').setup({})

local lspkind = require('lspkind')

-- code completion config
cmp.setup({
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol_text'
    }),
  },
  mapping = {
    -- navigating dropdown
    ['<Up>'] = cmp.mapping.select_prev_item(),
    ['<Down>'] = cmp.mapping.select_next_item(),
    -- not sure what? TODO: commented out to see...
    ['<C-Space>'] = cmp.mapping.complete(),
    -- right key to cancel suggestion
    ['<Right>'] = cmp.mapping.abort(),
    -- enter to add selection (supposed to replace existing but doesn't? TODO)
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true
    },
  },
  -- snippets config
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'luasnip' },
    { name = 'npm', keyword_length = 3 },
  })
})

cmp.setup.cmdline(';', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' },
    { name = 'cmdline' }
  })
})


cmp.event:on(
  'confirm_done',
  require('nvim-autopairs.completion.cmp').on_confirm_done()
)

