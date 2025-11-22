vim.lsp.enable({ 'svelte', 'vtsls', 'eslint' })

vim.lsp.config('vtsls', {
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = {
          {
            name = 'typescript-svelte-plugin',
            location = vim.fn.exepath('svelteserver'):match('(.*)/bin/svelteserver')
                .. '/node_modules/typescript-svelte-plugin',
            enableForWorkspaceTypeScriptVersions = true,
          },
        },
      },
    },
  },
})

vim.lsp.config('eslint', {
  filetypes = {
    'svelte',
  },
})

U.set_formatter('svelte', { 'eslint_d' })

return {}
