return {
  { 'persistence.nvim' },
  {
    'snacks.nvim',
    event = 'VimEnter',
    dep_of = { 'conform.nvim' },
    after = function()
      ---@param cwd string
      ---@return function
      local function pick_file(cwd)
        return function()
          vim.fn.chdir(cwd) -- TODO: only cd if success
          require('fzf-lua').files({
            cwd = cwd,
          })
        end
      end

      require('persistence').setup({})

      Snacks = require('snacks')

      ---@type snacks.dashboard.Opts
      ---@diagnostic disable-next-line: missing-fields
      local dashboard = {
        enabled = true,

        width = 60,
        row = nil,                                                                   -- dashboard position. nil for center
        col = nil,                                                                   -- dashboard position. nil for center
        pane_gap = 4,                                                                -- empty columns between vertical panes
        autokeys = '1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', -- autokey sequence

        preset = {
          pick = nil,
          keys = {
            {
              icon = ' ',
              key = 'f',
              desc = 'Find File',
              action = ':lua Snacks.dashboard.pick("files")',
            },
            {
              icon = ' ',
              key = 'n',
              desc = 'New File',
              action = ':ene | startinsert',
            },
            {
              icon = ' ',
              key = 'g',
              desc = 'Find Text',
              action = ':lua Snacks.dashboard.pick("live_grep")',
            },
            {
              icon = ' ',
              key = 'r',
              desc = 'Recent Files',
              action = ':lua Snacks.dashboard.pick("oldfiles")',
            },
            {
              icon = ' ',
              key = 'c',
              desc = 'Config',
              action = pick_file(vim.fn.stdpath('config')),
            },
            {
              icon = ' ',
              key = 's',
              desc = 'Restore Session',
              action = function() require('persistence').load() end,
            },
            { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
          },
        },

        sections = {
          {
            pane = 1,
            {
              section = 'terminal',
              cmd = 'winterm-rs',
              height = 18,
              width = 40,
              padding = 1,
            },
          },
          {
            pane = 2,
            { section = 'keys', gap = 1, padding = 1 },
          },
        },
      }

      ---@type snacks.Config
      require('snacks').setup({
        bigfile = { enabled = true },
        dashboard = dashboard,
        explorer = { enabled = true },
        indent = { enabled = false },
        input = { enabled = true },
        picker = { enabled = false },
        notifier = { enabled = true },
        quickfile = { enabled = true },
        scope = { enabled = true },
        scroll = { enabled = true },
        statuscolumn = {
          enabled = true,
          left = { 'mark', 'sign' }, -- priority of signs on the left (high to low)
          right = { 'fold', 'git' }, -- priority of signs on the right (high to low)
          folds = {
            open = true,
            git_hl = true,
          },
          refresh = 50,
        },
        terminal = { enabled = true, shell = 'nu' },
        words = { enabled = true },
      })

      Snacks.toggle.inlay_hints():map('<leader>uh')
    end,
  },
}
