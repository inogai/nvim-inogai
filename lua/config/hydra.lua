U.packadd('hydra.nvim')

U.Hydra = require('hydra')

U.Hydra({
  name = 'Del Line',
  mode = 'n',
  body = 'd',
  -- stylua: ignore
  heads = {
    { 'd', 'dd', { desc = 'Line' } },
  },
})
