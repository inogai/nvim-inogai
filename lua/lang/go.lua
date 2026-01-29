-- NOTE: add gopls and golangci-lint to dev shell

vim.lsp.enable('gopls')
vim.lsp.config('gopls', {
  settings = {
    gopls = {
      ui = {
        diagnostic = {
          annotations = {
            escape = true, -- heap escape highlights/hovers
            bounds = true,
            inline = true,
            ['nil'] = true,
          },
        },
      },
    },
  },
})

U.set_linter('go', { 'golangcilint' })

return {}
