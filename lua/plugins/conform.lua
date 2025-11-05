local setupAutocmds = function()
  local group = vim.api.nvim_create_augroup('InogaiAutoformat', { clear = true })
  vim.api.nvim_create_autocmd('BufWritePre', {
    group = group,
    callback = function()
      if vim.g.inogai_autoformat ~= false then require('conform').format({ async = false }) end
    end,
  })
end

local function configureAutoformat()
  vim.g.inogai_autoformat = true
  U.packadd "snacks.nvim"
  require('snacks.toggle')
      .new({
        name = 'Autoformat',
        set = function(val) vim.g.inogai_autoformat = val end,
        get = function() return vim.g.inogai_autoformat ~= false end,
      })
      :map('<leader>uf')

  setupAutocmds()
end

U.packadd "conform.nvim"

require("conform").setup {
  notify_on_error = true,
  default_format_opts = {
    timeout_ms = 2000,
    lsp_format = 'fallback',
  },

  formatters_by_ft = U.get_conform_formatters()
}
configureAutoformat()
