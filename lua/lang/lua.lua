vim.lsp.enable('lua_ls')
vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      hint = { enable = true },
    },
  },
})

U.set_formatter('lua', { 'stylua', lsp_format = 'last' })

return {
  'lazydev.nvim',
  ft = 'lua',
  after = function()
    require('lazydev').setup({
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        { path = 'snacks.nvim' },
      },
    })
  end,
}
