local cmp = require('cmp')
local luasnip = require("luasnip")

vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

-- code completion config
cmp.setup({
  mapping = {
    -- navigating dropdown
    ['<Up>'] = cmp.mapping.select_prev_item(),
    ['<Down>'] = cmp.mapping.select_next_item(),
    -- not sure what? TODO: commented out to see...
    -- ['<C-Space>'] = cmp.mapping.complete(),
    -- right key to cancel suggestion
    ['<Right>'] = cmp.mapping.abort(),
    -- enter to add selection (supposed to replace existing but doesn't? TODO)
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = truew
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
    { name = 'luasnip' }
  })
})

cmp.setup.cmdline(';', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' },
    { name = 'cmdline' }
  })
})


local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- configure completion for typescript
require("typescript").setup({
  server = {
    capabilities = capabilities
  }
})

