vim.lsp.enable('lua_ls')
vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      hint = { enable = true },
    },
  },
})

U.autocmd('Filetype', {
  pattern = 'lua',
  callback = function()
    U.packadd('lazydev.nvim')

    require "lazydev".setup {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        { path = 'snacks.nvim' },
      },
    }
  end,
})
