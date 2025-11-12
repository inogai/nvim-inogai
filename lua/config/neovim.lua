vim.cmd.colorscheme('moegi')

-- Load language configurations immediately
U.import_dir('lang')

-- Plugin configurations are now handled by lze automatically
-- The lze_specs directory is loaded by lze_config.setup()

return {
  { import = 'lze_specs' },
}
