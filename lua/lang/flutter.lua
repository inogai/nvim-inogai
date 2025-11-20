return {
  'flutter-tools.nvim',
  after = function() require('flutter-tools').setup({}) end,
}
