return {
  'rustaceanvim',
  event = 'VimEnter',
  before = function()
    vim.g.rustaceanvim = {
      server = {
        default_settings = {
          ['rust-analyzer'] = {
            files = { excludeDirs = { '.direnv' } },
          },
        },
      },
    }
  end,
}