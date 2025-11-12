return {
  'hydra.nvim',
  priority = 100,
  after = function()
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
  end,
}
