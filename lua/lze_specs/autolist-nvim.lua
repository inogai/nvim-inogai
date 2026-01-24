return {
  'autolist.nvim',
  ft = {
    'markdown',
    'text',
    'tex',
    'plaintex',
    'norg',
  },
  after = function()
    require('autolist').setup()

    vim.keymap.set('i', '<CR>', '<CR><Cmd>AutolistNewBullet<CR>')
    vim.keymap.set('n', 'o', 'o<cmd>AutolistNewBullet<cr>')
    vim.keymap.set('n', 'O', 'O<cmd>AutolistNewBulletBefore<cr>')
  end,
}
