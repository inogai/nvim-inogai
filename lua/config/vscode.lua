--- VSCode Neovim Configuration
---
--- Selective enable plugins for VSCode Neovim environment

return {
  { import = 'lze_specs._treesitter' },
  { import = 'lze_specs._lspconfig' },
  { import = 'lze_specs._which-key' },
  { import = 'lze_specs.flash' },
  { import = 'lze_specs.mini' }, -- NOTE: may want to only enable certain mini.* plugins in future
}
