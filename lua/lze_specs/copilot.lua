return {
  { 'copilot-lsp',   dep_of = 'copilot.lua' },
  { 'blink-copilot', dep_of = 'copilot.lua' },
  {
    'copilot.lua',
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
        nes = {
          enabled = true,
          keymap = {
            accept_and_goto = '<leader>p',
            accept = false,
            dismiss = '<Esc>',
          },
        },
      })
    end,
  },
}
