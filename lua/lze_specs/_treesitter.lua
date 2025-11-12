return {
  'nvim-treesitter',
  priority = 100, -- Load early
  after = function()
    ---@diagnostic disable-next-line: missing-fields
    require('nvim-treesitter.configs').setup({
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'ruby', 'css' },
      },
      indent = { enable = true, disable = { 'ruby', 'css' } },
    })
  end,
}
