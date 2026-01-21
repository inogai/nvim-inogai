vim.lsp.enable({ 'svelte', 'vtsls', 'eslint' })

local svelte_plugin = {
  name = 'typescript-svelte-plugin',
  location = vim.fn.exepath('svelteserver'):match('(.*)/bin/svelteserver')
    .. '/node_modules/typescript-svelte-plugin',
  enableForWorkspaceTypeScriptVersions = true,
}

-- Append svelte plugin to tsserver global plugins
vim.g.vtsls_global_plugins =
  vim.list_extend(vim.g.vtsls_global_plugins or {}, { svelte_plugin })

vim.lsp.config('vtsls', {
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = vim.g.vtsls_global_plugins,
      },
    },
  },
})

U.set_formatter('svelte', { 'eslint_d' })

return {}
