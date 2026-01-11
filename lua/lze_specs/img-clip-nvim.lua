return {
  'img-clip.nvim',
  cmd = {
    'PasteImage',
    'ImgClipDebug',
  },
  after = function() require('img-clip').setup({}) end,
}
