-- Bind <leader>fp to Telescope projections
require('telescope').load_extension('projections')
vim.keymap.set("n", "<leader>fp", function() vim.cmd("Telescope projections") end)

-- save localoptions to session file
vim.opt.sessionoptions:append("localoptions")
-- save globals so buffers persist
vim.opt.sessionoptions:append("globals")

-- Autostore session on VimExit
local Session = require("projections.session")
vim.api.nvim_create_autocmd({ 'VimLeavePre' }, {
  callback = function() Session.store(vim.loop.cwd()) end,
})

-- session restore
vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function()
    -- skip if arg e.g. "." passed to nvim
    if vim.fn.argc() ~= 0 then return end
    local session_info = Session.info(vim.loop.cwd())
    if session_info == nil then
      Session.restore_latest()
    else
      Session.restore(vim.loop.cwd())
    end
  end,
  desc = "Restore last session automatically"
})

