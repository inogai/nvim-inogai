return {
  {
    'leetcode.nvim',
    cmd = { 'Leet' },
    after = function()
      require('leetcode').setup({
        lang = 'scala',
      })
    end,
  },
}
