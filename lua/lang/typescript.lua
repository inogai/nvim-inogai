local js_utils = require('my.js_utils')

vim.lsp.enable({ 'vtsls', 'denols' })

vim.lsp.config('vtsls', {
  root_markers = { 'package.json', 'tsconfig.json', 'jsconfig.json' },
})

vim.lsp.config('denols', {
  -- on_attach = on_attach,
  root_markers = { 'deno.json', 'deno.jsonc' },
})

local fts = {
  'javascript',
  'typescript',
  'javascriptreact',
  'typescriptreact',
  'javascript.jsx',
  'typescript.tsx',
}

U.set_formatter(fts, js_utils.get_formatter)
U.set_linter(fts, { 'eslint_d' })

return {}
