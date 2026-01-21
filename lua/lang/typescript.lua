local js_utils = require('my.js_utils')

vim.lsp.enable({ 'vtsls', 'eslint', 'denols', 'html', 'tailwindcss' })

vim.lsp.config('denols', {
  -- on_attach = on_attach,
  root_markers = { 'deno.json', 'deno.jsonc' },
})

vim.lsp.config('vtsls', {
  root_markers = { 'package.json', 'tsconfig.json', 'jsconfig.json' },
})

vim.lsp.config('eslint', {
  filetypes = {
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
    'astro',
  },
})

U.set_formatter({
  'javascript',
  'typescript',
  'typescriptreact',
  'javascriptreact',
  'astro',
  'vue',
}, js_utils.get_formatter)

U.set_formatter('css', { 'prettierd' })

return {}
