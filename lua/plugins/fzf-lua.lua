U.packadd('fzf-lua')

local actions = require('fzf-lua.actions')
local config = require('fzf-lua.config')

require('fzf-lua').setup({
  -- config.defaults.actions.files['ctrl-t'] = require('trouble.sources.fzf').open

  fzf_colors = true,
  defaults = {
    formatter = 'path.filename_first', -- formatter = 'path.dirname_first',
  },
  ---@type fzf-lua.config.Files.p
  files = {
    actions = {
      ['ctrl-i'] = { actions.toggle_ignore },
      ['ctrl-h'] = { actions.toggle_hidden },
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

require('fzf-lua').register_ui_select()
