U = require "utils"

require "config.options"

vim.cmd.colorscheme "moegi"

U.packadd "nvim-treesitter"
U.packadd "nvim-lspconfig"

---@diagnostic disable-next-line: missing-fields
require "nvim-treesitter.configs".setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = { 'ruby', 'css' },
  },
  indent = { enable = true, disable = { 'ruby', 'css' } },
}

vim.g.conform_formatters_by_ft = {}



U.autocmd("VimEnter", {
  callback = function()
    U.packadd "which-key.nvim"
    U.import_dir "lang"
    U.import_dir "plugins"

    require "config.keymaps"
    vim.schedule(function()
      vim.api.nvim_exec_autocmds("User", {
        pattern = "VeryLazy",
      })
    end)
  end
})
