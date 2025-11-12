U = require('utils')

require('config.options')

if vim.env['NVIM_DEV_MODULE'] then require('config.dev') end

require('lze').load({
  { import = vim.g.vscode and 'config.vscode' or 'config.neovim' },
})

U.autocmd('VimEnter', {
  callback = function() require('config.keymaps') end,
})
