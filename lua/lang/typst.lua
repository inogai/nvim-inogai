U.set_formatter('typst', { 'prettypst' })

vim.lsp.enable({ 'tinymist' })

U.on('FileType', 'typst', function() require('my.headings').setup(0, '=') end)

return {
  'typst-preview.nvim',
  ft = 'typst',
  after = function()
    require('typst-preview').setup({ open_cmd = "qutebrowser ':open -w %s'" })
  end,
}
