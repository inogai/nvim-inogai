return {
  'guess-indent.nvim',
  event = 'VimEnter',
  after = function() require('guess-indent').setup({}) end,
}
