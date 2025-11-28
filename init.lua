U = require('utils')

require('config.options')

if vim.env['NVIM_DEV_MODULE'] then require('config.dev') end

---@type lze.Config
vim.g.lze = {
  load = U.packadd,
  verbose = true,
  default_priority = 50,
  without_default_handlers = false,
}

require('lze').load({
  { import = vim.g.vscode and 'config.vscode' or 'config.neovim' },
})

U.autocmd('VimEnter', {
  callback = function() require('config.keymaps') end,
})
