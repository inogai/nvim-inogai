local vue_plugin = {
  name = '@vue/typescript-plugin',
  location = vim.fn
    .exepath('vue-language-server')
    :match('(.*)/bin/vue%-language%-server')
    .. '/lib/language-tools/packages/language-server',
  languages = { 'vue' },
  configNamespace = 'typescript',
}

vim.g.vtsls_global_plugins =
  vim.list_extend(vim.g.vtsls_global_plugins or {}, { vue_plugin })

local js_utils = require('my.js_utils')

vim.g.vtsls_filetypes = vim.list_extend(vim.g.vtsls_filetypes or {
  'javascript',
  'javascriptreact',
  'javascript.jsx',
  'typescript',
  'typescriptreact',
  'typescript.tsx',
}, { 'vue' })

local vtsls_config = {
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = { vue_plugin },
      },
    },
  },
  filetypes = vim.g.vtsls_filetypes,
}

vim.lsp.config('vtsls', vtsls_config)
vim.lsp.enable({ 'vtsls', 'vue_ls' })

U.set_formatter('vue', js_utils.get_formatter)
U.set_linter('vue', { 'eslint_d' })

return {}
