U.packadd('blink-cmp-avante')
U.packadd('avante.nvim')

require('avante').setup({
  instructions_file = 'AGENTS.md',
  provider = 'copilot',
  providers = {
    copilot = {
      model = 'grok-code-fast-1', -- claude-sonnet-4.5
    },
    moonshot = {
      endpoint = 'https://api.moonshot.ai/v1',
      model = 'kimi-k2-0905-preview',
      timeout = 30000,
      extra_request_body = {
        temperature = 0.75,
        max_tokens = 32768,
      },
    },
  },
})

local api = require('avante.api')

require('which-key').add({
  { '<C-a>', api.ask, desc = 'Ask AI', mode = 'nv' },
})

U.blink_add_source('avante', {
  module = 'blink-cmp-avante',
  name = 'Avante',
  opts = {},
})
