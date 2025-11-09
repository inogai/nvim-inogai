U.on('User', 'VeryLazy', function()
  U.packadd('hydra.nvim')
  U.packadd('edgy.nvim')

  local Hydra = require('hydra')

  Hydra({
    name = 'Del Line',
    mode = 'n',
    body = 'd',
    -- stylua: ignore
    heads = {
      { 'd', 'dd', { desc = 'Line' } },
    },
  })
end)
