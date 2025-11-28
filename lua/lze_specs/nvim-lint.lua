return {
  {
    'nvim-lint',
    event = 'VimEnter',
    after = function()
      local lint = require('lint')

      lint.linters_by_ft = {
        markdown = { 'markdownlint-cli2' },
      }

      vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
        callback = function() lint.try_lint() end,
      })
    end,
  },
}
