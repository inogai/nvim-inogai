return {
  {
    'nvim-lint',
    event = 'VimEnter',
    config = function()
      require('lint').linters_by_ft = {
        markdown = { 'markdownlint-cli2' },
        typescript = { 'eslint_d' },
        javascript = { 'eslint_d' },
        typescriptreact = { 'eslint_d' },
        javascriptreact = { 'eslint_d' },
      }

      vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
        callback = function() require('lint').try_lint() end,
      })
    end,
  },
}
