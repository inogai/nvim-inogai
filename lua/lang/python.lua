vim.lsp.enable({
  'basedpyright',
  'ruff',
})

U.on('User', 'VeryLazy', function()
  U.packadd('venv-selector.nvim')
  require('venv-selector').setup({})

  vim.keymap.set(
    'n',
    '<localleader>v',
    '<cmd>VenvSelect<cr>',
    { desc = 'Select virtual environment' }
  )
end)
