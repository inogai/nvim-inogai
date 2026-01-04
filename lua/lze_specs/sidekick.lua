return {
  { 'blink-copilot', dep_of = 'copilot.lua' },
  {
    'copilot.lua',
    dep_of = 'sidekick.nvim',
    event = 'VimEnter',
    after = function()
      U.blink_add_source('copilot', {
        name = 'copilot',
        module = 'blink-copilot',
        score_offset = 100,
        async = true,
      })

      require('copilot').setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
        filetypes = {
          markdown = true,
          help = true,
        },
      })
    end,
  },
  {
    'sidekick.nvim',
    event = 'VimEnter',
    after = function()
      require('sidekick').setup({
        cli = {
          mux = { backend = 'zellij', enabled = true },
        },
      })
    end,
    keys = {
      {
        '<tab>',
        function()
          -- if there is a next edit, jump to it, otherwise apply it if any
          if not require('sidekick').nes_jump_or_apply() then
            return '<Tab>' -- fallback to normal tab
          end
        end,
        expr = true,
        desc = 'Goto/Apply Next Edit Suggestion',
      },
    },
  },
}
