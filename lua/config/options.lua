vim.g.mapleader = ' '
vim.g.maplocalleader = ';'

vim.o.showmode = false

vim.opt.laststatus = 3 -- Only show one statusline

vim.o.number = true -- Show line numbers
vim.o.signcolumn = 'yes' -- Always show the sign column
vim.o.cursorline = true -- Highlight the current line

-- Fold
-- note that status column is manage by snacks.nvim
vim.o.foldcolumn = '1'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.opt.fillchars = { foldopen = '󰅀', foldclose = '󰅂', diff = '╱' }

vim.o.undofile = true -- Save undo history

-- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.list = true
vim.opt.listchars =
  { tab = ' ', multispace = '---+', lead = ' ', trail = '·', nbsp = '␣' }

-- Sync clipboard between OS and Neovim.
-- Schedule the setting after `UiEnter` because it can increase startup-time.
vim.schedule(function() vim.opt.clipboard = 'unnamedplus' end)

-- Indentation and tabs
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

-- Split behavior
vim.opt.splitright = true
vim.opt.splitbelow = true

-- LSP Related
vim.lsp.inlay_hint.enable(true)

local icons = require('config.icons')
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = icons.diagnostic.error.glyph,
      [vim.diagnostic.severity.WARN] = icons.diagnostic.warn.glyph,
      [vim.diagnostic.severity.INFO] = icons.diagnostic.info.glyph,
      [vim.diagnostic.severity.HINT] = icons.diagnostic.hint.glyph,
    },
  },
  virtual_text = {
    severity = {
      min = vim.diagnostic.severity.WARN,
    },
  },
})
