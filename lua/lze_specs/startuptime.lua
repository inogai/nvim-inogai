return {
  -- dstein64/vim-startuptime
  'vim-startuptime',
  cmd = 'StartupTime',
  after = function()
    -- See https://github.com/dstein64/vim-startuptime/issues/20
    vim.g.startuptime_exe_path = 'nvim-inogai'
  end,
}
