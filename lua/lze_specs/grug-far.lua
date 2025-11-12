return {
  'grug-far.nvim',
  event = 'VimEnter',
  after = function() require('grug-far').setup({}) end,
}
