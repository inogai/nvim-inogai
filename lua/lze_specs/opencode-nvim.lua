return {
  'opencode.nvim',
  after = function()
    local pane_initialized = false

    ---@type opencode.Provider
    local mux_provider = {
      start = function(self)
        if not pane_initialized then
          vim.notify('Initializing opencode pane...')

          vim.fn.system({
            'zellij',
            'action',
            'new-pane',
            '--name=opencode',
            -- '--direction=right',
            '--floating',
            '--',
            'bash',
            '-c',
            self.cmd,
          })

          vim.fn.system({
            'zellij',
            'action',
            'toggle-floating-panes',
          })
        end
      end,
    }

    ---@module 'opencode'
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      provider = mux_provider,
    }
  end,
  -- stylua: ignore
  keys = {
    { '<D-i>',      function() require('opencode').ask('@this: ', { submit = true }) end, desc = 'Ask opencode AI',         mode = { 'n', 'x' } },
    { '<D-x>',      function() require('opencode').select() end,                          desc = 'Execute opencode action', mode = { 'n', 'x' } },
    { '<leader>gc', function() require('opencode').command('commit') end,                 desc = '[C]ommit with opencode' },
    -- { '<leader>oa', function() M.prompt('@this') end,                   desc = 'Add to opencode context', mode = { 'n', 'x' } },
    -- { '<leader>oo', function() M.toggle() end,                          desc = 'Toggle opencode window',  mode = { 'n', 't' } },
    -- { '<S-C-u>', function() M.command('session.half.page.up') end,   desc = 'Opencode half page up' },
    -- { '<S-C-d>', function() M.command('session.half.page.down') end, desc = 'Opencode half page down' },
    -- You may want these if you stick with the opinionated "<C-a>" and "<C-x>" above — otherwise consider "<leader>o".
    -- { '+',     '<C-a>',                                            desc = 'Increment number',        noremap = true },
    -- { '-',     '<C-x>',                                            desc = 'Decrement number',        noremap = true },
  }
,
}
