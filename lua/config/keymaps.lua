local wk = require('which-key')

local function F() return require('fzf-lua') end

wk.add({
  { '<D-s>',           '<cmd>w<cr><esc>',          desc = '[S]ave File',           mode = 'nixs' },
  { '<F2>',            vim.lsp.buf.rename,         desc = 'LSP Rename',            mode = 'nixs' },
  { '<esc>',           '<cmd>nohlsearch<cr><esc>', desc = 'Clear Search Highlight' },

  { '<leader><space>', '<cmd>FzfLua files<cr>',    desc = 'Find Files (Root Dir)' },
  {
    '<leader>,',
    '<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>',
    desc = 'Switch Buffer',
  },

  { '<C-h>', '<C-w>h',                                          desc = 'Go to left window',  mode = 'nixs' },
  { '<C-j>', '<C-w>j',                                          desc = 'Go to lower window', mode = 'nixs' },
  { '<C-k>', '<C-w>k',                                          desc = 'Go to upper window', mode = 'nixs' },
  { '<C-l>', '<C-w>l',                                          desc = 'Go to right window', mode = 'nixs' },
  { '<C-/>', function() require "snacks".terminal.toggle() end, desc = "Terminal",           mode = 'nixst' },

  { 'zR',    function() require('ufo').openAllFolds() end,      desc = 'Open all folds' },
  { 'zM',    function() require('ufo').closeAllFolds() end,     desc = 'Close all folds' },

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

  { '<leader>e', '<cmd>Yazi<cr>' },
  { '<leader>E', '<cmd>Yazi cwd<cr>' },
  -- goto
  { 'g',         desc = '+[G]oto' },
  { 'ga',        desc = '+[A]dd Surrounding' },
  { 'gs',        desc = '+[S]ubtract Surrounding' },
  { 'ge',        desc = '+[E]dit Surrounding' },
  { 'gd',        function() F().lsp_definitions({ jump1 = true, jump_on_cb = true }) end, desc = '[D]efinitions' },
  { 'gr',        '<cmd>FzfLua lsp_references<cr>',                                        desc = '[R]erferences' },
  {
    'gy',
    '<cmd>FzfLua lsp_typedefs<cr>',
    desc = 'T[y]pe Definition',
  },
  {
    '<C-.>',
    '<cmd>FzfLua lsp_code_actions<cr>',
    desc = 'Code Actions',
    mode = 'nxis',
  },

  { '<leader>s',  desc = '+Search' },
  { '<leader>s"', '<cmd>FzfLua registers<cr>',                 desc = 'Registers' },
  { '<leader>sa', '<cmd>FzfLua autocmds<cr>',                  desc = 'Auto Commands' },
  { '<leader>sb', '<cmd>FzfLua grep_curbuf<cr>',               desc = 'Buffer' },
  { '<leader>sc', '<cmd>FzfLua command_history<cr>',           desc = 'Command History' },
  { '<leader>sC', '<cmd>FzfLua commands<cr>',                  desc = 'Commands' },
  { '<leader>sd', '<cmd>FzfLua diagnostics_document<cr>',      desc = 'Document Diagnostics' },
  { '<leader>sD', '<cmd>FzfLua diagnostics_workspace<cr>',     desc = 'Workspace Diagnostics' },
  { '<leader>sg', '<cmd>FzfLua live_grep<cr>',                 desc = 'Grep' },
  { '<leader>sh', function() F().helptags() end,               desc = '[H]elp' },
  { '<leader>sH', '<cmd>FzfLua highlights<cr>',                desc = 'Search Highlight Groups' },
  { '<leader>sk', '<cmd>FzfLua keymaps<cr>',                   desc = 'Key Maps' },
  { '<leader>sm', '<cmd>FzfLua marks<cr>',                     desc = 'Jump to Mark' },
  { '<leader>sn', function() require('noice').cmd('pick') end, desc = '[N]oice' },
  { '<leader>sr', '<cmd>GrugFar<cr>',                          desc = "[R]eplace" },
  { '<leader>sR', '<cmd>FzfLua resume<cr>',                    desc = 'Resume' },
  { '<leader>sq', '<cmd>FzfLua quickfix<cr>',                  desc = 'Quickfix List' },
  { '<leader>ss', function() F().lsp_document_symbols() end,   desc = 'Goto Symbol' },
  {
    '<leader>sS',
    function() F().lsp_live_workspace_symbols() end,
    desc = 'Goto Symbol (Workspace)',
  },

  { '<leader>g',  desc = '+[G]it' },
  { '<leader>gl', function() Snacks.lazygit.open() end, desc = '[L]azygit' },
  { '<leader>gg', '<cmd>DiffviewOpen<cr>',              desc = 'Diffview' },

  { '<leader>ua', '<cmd>Copilot toggle<cr>',            desc = '[A]I Completions' },
  { '<leader>uC', '<cmd>FzfLua colorschemes<cr>',       desc = '[C]olorscheme' },
  { '<leader>ui', '<cmd>Inspect<cr>',                   desc = '[I]nspect' },
})
