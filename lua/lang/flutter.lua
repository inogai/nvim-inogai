U.set_formatter('flutter', { 'dart_format' })

return {
  'flutter-tools.nvim',
  after = function() require('flutter-tools').setup({}) end,
}
