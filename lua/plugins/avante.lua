U.autocmd('User', {
  pattern = 'VeryLazy',
  callback = function()
    U.packadd('blink-cmp-avante')
    U.packadd('avante.nvim')

    require('avante').setup({
      instructions_file = 'AGENTS.md',
      provider = 'copilot',
      providers = {
        copilot = {
          model = 'grok-code-fast-1', -- claude-sonnet-4.5
        },
      },
    })

    U.blink_add_source('avante', {
      module = 'blink-cmp-avante',
      name = 'Avante',
      opts = {
        -- options for blink-cmp-avante
      },
    })
  end,
})
