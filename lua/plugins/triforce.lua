U.on('User', 'VeryLazy', function()
  U.packadd('volt')
  U.packadd('triforce.nvim')

  require('triforce').setup({
    keymap = {
      show_profile = '<leader>tp', -- Open profile with <leader>tp
    },
  })
end)
