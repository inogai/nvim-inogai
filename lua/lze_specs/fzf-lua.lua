return {
  'fzf-lua',
  event = 'VimEnter',
  after = function()
    local actions = require('fzf-lua.actions')
    local F = require('fzf-lua')

    F.register_ui_select()

    F.setup({
      fzf_colors = true,
      defaults = {
        formatter = 'path.filename_first', -- formatter = 'path.dirname_first',
      },
      ---@type fzf-lua.config.Files.p
      files = {
        actions = {
          ['ctrl-i'] = { actions.toggle_ignore },
          ['ctrl-h'] = { actions.toggle_hidden },
          ['ctrl-t'] = require('trouble.sources.fzf').actions.open,
        },
      },
      grep = {
        actions = {
          ['ctrl-i'] = { actions.toggle_ignore },
          ['ctrl-h'] = { actions.toggle_hidden },
        },
      },
      lsp = {
        code_actions = {
          previewer = vim.fn.executable('delta') == 1 and 'codeaction_native' or nil,
        },
      },
    })

    -- stylua: ignore
    require('which-key').add({
      { '<leader> ',  '<cmd>FzfLua files<cr>',                                               desc = 'Find Files (Root Dir)', },
      { '<leader>,',  '<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>',            desc = 'Switch Buffer', },
      { 'gd',         function() F.lsp_definitions({ jump1 = true, jump_on_cb = true }) end, desc = '[D]efinitions', },
      { 'gr',         '<cmd>FzfLua lsp_references<cr>',                                      desc = '[R]erferences', },
      { 'gy',         '<cmd>FzfLua lsp_typedefs<cr>',                                        desc = 'T[y]pe Definition', },
      { '<C-.>',      '<cmd>FzfLua lsp_code_actions<cr>',                                    desc = 'Code Actions',            mode = 'nxis', },
      { '<leader>s"', '<cmd>FzfLua registers<cr>',                                           desc = 'Registers' },
      { '<leader>sa', '<cmd>FzfLua autocmds<cr>',                                            desc = 'Auto Commands', },
      { '<leader>sb', '<cmd>FzfLua grep_curbuf<cr>',                                         desc = 'Buffer' },
      { '<leader>sc', '<cmd>FzfLua command_history<cr>',                                     desc = 'Command History', },
      { '<leader>sC', '<cmd>FzfLua commands<cr>',                                            desc = 'Commands' },
      { '<leader>sd', '<cmd>FzfLua diagnostics_document<cr>',                                desc = 'Document Diagnostics', },
      { '<leader>sD', '<cmd>FzfLua diagnostics_workspace<cr>',                               desc = 'Workspace Diagnostics', },
      { '<leader>sg', '<cmd>FzfLua live_grep<cr>',                                           desc = 'Grep' },
      { '<leader>sh', function() F.helptags() end,                                           desc = '[H]elp', },
      { '<leader>sH', '<cmd>FzfLua highlights<cr>',                                          desc = 'Search Highlight Groups', },
      { '<leader>sk', '<cmd>FzfLua keymaps<cr>',                                             desc = 'Key Maps' },
      { '<leader>sm', '<cmd>FzfLua marks<cr>',                                               desc = 'Jump to Mark', },
      { '<leader>sR', '<cmd>FzfLua resume<cr>',                                              desc = 'Resume' },
      { '<leader>sq', '<cmd>FzfLua quickfix<cr>',                                            desc = 'Quickfix List', },
      { '<leader>ss', function() F.lsp_document_symbols() end,                               desc = 'Goto Symbol', },
      { '<leader>sS', function() F.lsp_live_workspace_symbols() end,                         desc = 'Goto Symbol (Workspace)', },

      { '<leader>gl', F.git_bcommits,                                                        desc = '[L]ogs (Buffer)' },
      { '<leader>gL', F.git_commits,                                                         desc = '[L]ogs (Workspace)' },

      { '<leader>gb', F.git_branches,                                                        desc = '[B]ranches' },
      { '<leader>gg', F.git_status,                                                          desc = '[G]it Status' },
      { '<leader>gh', F.git_hunks,                                                           desc = '[H]unks' },

      { '<leader>uC', '<cmd>FzfLua colorschemes<cr>',                                        desc = '[C]olorscheme' },
    })
  end,
}
