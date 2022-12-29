-- set SPACE as leader key
vim.g.mapleader = " "

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

