vim.cmd.colorscheme('moegi')

U.autocmd('VimEnter', {
  callback = function()
    U.import_dir('lang')
    U.import_dir('plugins')
  end,
})
