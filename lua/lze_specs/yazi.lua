return {
  {
    'yazi.nvim',
    event = 'VimEnter',
    before = function() vim.g.loaded_netrwPlugin = 1 end,
    after = function()
      require('yazi').setup({
        open_for_directories = false,
        keymaps = {
          show_help = '<f1>',
        },
      })
    end,
  },
}
