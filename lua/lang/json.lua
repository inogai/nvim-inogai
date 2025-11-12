U.set_formatter('json', { 'prettierd' })

vim.lsp.enable('jsonls')
vim.lsp.config('jsonls', {
  before_init = function(_, client_config)
    client_config.settings.json = client_config.settings.json or {}
    client_config.settings.json.schemas = require('schemastore').json.schemas()
  end,
  settings = {
    json = {
      schemas = {},
      validate = { enable = true },
    },
  },
})

return {
  'SchemaStore.nvim',
  on_require = 'schemastore',
}
