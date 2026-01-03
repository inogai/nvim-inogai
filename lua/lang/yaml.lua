U.set_formatter('yaml', { 'prettierd' })

vim.lsp.enable('yamlls')
vim.lsp.config('yamlls', {
  before_init = function(_, client_config)
    client_config.settings.yaml.schemas = require('schemastore').yaml.schemas()
  end,
  settings = {
    yaml = {
      schemas = {},
      schemaStore = {
        -- You must disable built-in schemaStore support if you want to use
        -- this plugin and its advanced options like `ignore`.
        enable = false,
        -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
        url = '',
      },
    },
  },
})

return {
  -- 'SchemaStore.nvim',
  -- on_require = 'schemastore',
}
