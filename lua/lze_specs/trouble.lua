return {
  'trouble.nvim',
  event = 'VimEnter',
  on_require = 'trouble.sources.fzf',
  after = function() require('trouble').setup({}) end,
  -- stylua: ignore
  keys = {
    { ']x',         function() require('trouble').next({ jump = true }) end,      desc = 'Next Trouble', },
    { '[x',         function() require('trouble').prev({ jump = true }) end,      desc = 'Prev Trouble', },
    { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>',                        desc = 'Diagnostics (Trouble)', },
    { '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',           desc = 'Buffer Diagnostics (Trouble)', },
    { '<leader>cs', '<cmd>Trouble symbols toggle focus=false<cr>',                desc = 'Symbols (Trouble)', },
    { '<leader>cl', '<cmd>Trouble lsp toggle focus=false win.position=right<cr>', desc = 'LSP Definitions / references / ... (Trouble)', },
    { '<leader>xL', '<cmd>Trouble loclist toggle<cr>',                            desc = 'Location List (Trouble)', },
    { '<leader>xQ', '<cmd>Trouble qflist toggle<cr>',                             desc = 'Quickfix List (Trouble)', },
  },
}
