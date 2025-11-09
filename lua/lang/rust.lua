U.packadd('rustaceanvim')

vim.g.rustaceanvim = {
  server = {
    default_settings = {
      ['rust-analyzer'] = {
        files = { excludeDirs = { '.direnv' } },
      },
    },
  },
}
