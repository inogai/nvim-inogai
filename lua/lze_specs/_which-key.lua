-- Which-key.nvim configuration
return {
  'which-key.nvim',
  priority = 90, -- Load early but after treesitter
  after = function() require('which-key').setup({}) end,
}
