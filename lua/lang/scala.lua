local metals_config = nil

U.autocmd('FileType', {
  pattern = 'scala',
  callback = function()
    U.packadd('nvim-metals')

    if metals_config == nil then
      metals_config = require('metals').bare_config()
      -- metals_config.on_attach = function(client, bufnr)
      --   -- your on_attach function
      -- end

      nvim_metals_group = vim.api.nvim_create_augroup('nvim-metals', { clear = true })
    end
  end,
})
