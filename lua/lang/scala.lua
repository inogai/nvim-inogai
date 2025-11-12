return {
  'nvim-metals',
  ft = 'scala',
  after = function()
    local metals_config = require('metals').bare_config()
    -- metals_config.on_attach = function(client, bufnr)
    --   -- your on_attach function
    -- end

    vim.api.nvim_create_augroup('nvim-metals', { clear = true })
  end,
}