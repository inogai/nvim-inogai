U.set_formatter('typst', { 'prettypst' })

-- Enable tinymist LSP for Typst
vim.lsp.enable({
  'tinymist',
})

return {
  'typst-preview.nvim',
  ft = 'typst',
  after = function()
    require('typst-preview').setup({
      open_cmd = "qutebrowser ':open -w %s'",
    })
  end,
}
