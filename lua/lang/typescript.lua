vim.lsp.enable({ 'vtsls', 'eslint' })

vim.lsp.config('eslint', {
  filetypes = {
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
    'astro',
  },
})

U.set_formatter('javascript', { 'eslint_d' })
U.set_formatter('typescript', { 'eslint_d' })
U.set_formatter('typescriptreact', { 'eslint_d' })
U.set_formatter('javascriptreact', { 'eslint_d' })
U.set_formatter('astro', { 'eslint_d' })
U.set_formatter('css', { 'eslint_d' })

return {}
