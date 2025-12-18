vim.lsp.enable({ 'purescriptls' })

vim.lsp.config('purescriptls', {
  root_markers = { 'spago.yaml' },
})

U.set_formatter({
  'purescript',
}, { 'purs-tidy' })

return {}
