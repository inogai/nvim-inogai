U = require "utils"
require "config.options"

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

U.autocmd("VimEnter", {
  callback = function()
    U.packadd "which-key.nvim"
    require "config.keymaps"

    vim.schedule(function()
      vim.api.nvim_exec_autocmds("User", {
        pattern = "VeryLazy",
      })
    end)
  end
})


if vim.g.vscode then
  require("config.vscode")
else
  require("config.neovim")
end
