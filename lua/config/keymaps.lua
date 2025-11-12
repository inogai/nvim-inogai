local wk = require('which-key')

-- stylua: ignore
wk.add({
  { '<D-s>', '<cmd>w<cr><esc>',                             desc = '[S]ave File',           mode = 'nixs' },
  { '<F2>',  vim.lsp.buf.rename,                            desc = 'LSP Rename',            mode = 'nixs' },
  { '<esc>', '<cmd>nohlsearch<cr><esc>',                    desc = 'Clear Search Highlight' },

  { 'zR',    function() require('ufo').openAllFolds() end,  desc = 'Open all folds' },
  { 'zM',    function() require('ufo').closeAllFolds() end, desc = 'Close all folds' },

  {
    'K',
    function()
      local win_id = require('ufo').peekFoldedLinesUnderCursor()
      if not win_id then vim.lsp.buf.hover() end
    end,
    desc = 'Hover',
  },

  { ']d', function() vim.diagnostic.jump({ count = 1, float = true }) end,  desc = 'Next [D]iagnostic' },
  { '[d', function() vim.diagnostic.jump({ count = -1, float = true }) end, desc = 'Prev [D]iagnostic' },
  {
    ']e',
    function() vim.diagnostic.jump({ count = 1, float = true, severity = vim.diagnostic.severity.ERROR }) end,
    desc = 'Next [E]rror',
  },
  {
    '[e',
    function() vim.diagnostic.jump({ count = -1, float = true, severity = vim.diagnostic.severity.ERROR }) end,
    desc = 'Prev [E]rror',
  },
  {
    ']x',
    function() require('trouble').next({ jump = true }) end,
    desc = 'Next Trouble',
  },
  {
    '[x',
    function() require('trouble').prev({ jump = true }) end,
    desc = 'Prev Trouble',
  },

  { '<leader>e',  '<cmd>Yazi<cr>' },
  { '<leader>E',  '<cmd>Yazi cwd<cr>' },
  -- goto
  { 'g',          desc = '+[G]oto' },
  { 'ga',         desc = '+[A]dd Surrounding' },
  { 'gs',         desc = '+[S]ubtract Surrounding' },
  { 'ge',         desc = '+[E]dit Surrounding' },

  { '<leader>s',  desc = '+Search' },
  { '<leader>sn', function() require('noice').cmd('pick') end, desc = '[N]oice' },
  { '<leader>sr', '<cmd>GrugFar<cr>',                          desc = '[R]eplace' },

  { '<leader>g',  desc = '+[G]it' },
  { '<leader>gl', function() Snacks.lazygit.open() end,        desc = '[L]azygit' },

  { '<leader>ua', '<cmd>Copilot toggle<cr>',                   desc = '[A]I Completions' },
  { '<leader>ui', '<cmd>Inspect<cr>',                          desc = '[I]nspect' },
})
