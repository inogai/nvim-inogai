U.packadd "yazi.nvim"

vim.g.loaded_netrwPlugin = 1

require "yazi".setup {
  open_for_directories = false,
  keymaps = {
    show_help = '<f1>',
  },
}
