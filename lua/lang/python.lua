vim.lsp.enable({
  'basedpyright',
  'ruff',
})

return {
  'venv-selector.nvim',
  event = 'VimEnter',
  after = function()
    require('venv-selector').setup({})

    vim.keymap.set(
      'n',
      '<localleader>v',
      '<cmd>VenvSelect<cr>',
      { desc = 'Select virtual environment' }
    )
  end,
}
