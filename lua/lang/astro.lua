local js_utils = require('my.js_utils')

vim.lsp.enable({ 'astro', 'vtsls' })

U.set_formatter('astro', js_utils.get_formatter)
U.set_linter('astro', { 'eslint_d' })

return {}
