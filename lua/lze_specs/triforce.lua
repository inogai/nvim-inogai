return {
  {
    'triforce',
    event = 'VimEnter',
    config = function()
      require('triforce').setup({
        keymap = {
          show_profile = '<leader>tp', -- Open profile with <leader>tp
        },
      })
    end,
  },
}
