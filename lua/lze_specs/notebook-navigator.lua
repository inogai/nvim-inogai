return {
  'NotebookNavigator.nvim',
  -- dependency = { 'iron.nvim', 'mini.nvim' }
  event = 'VimEnter',
  after = function()
    local nn = require('notebook-navigator')
    local Hydra = require('hydra')

    nn.setup({})

    -- TODO: explore why iron freezes until leaving hydra
    Hydra({
      name = 'Notebook Navigator',
      mode = 'n',
      body = '<localleader>',
      heads = {
        { 'x', function() nn.run_and_move() end, { desc = 'Run Cell and Move' } },
        { 'X', function() nn.run_cell() end, { desc = 'Run Cell' } },
      },
    })

    Hydra({
      body = '[',
      heads = {
        { 'v', function() nn.move_cell('u') end, { desc = 'Prev Cell' } },
      },
    })

    Hydra({
      body = ']',
      heads = {
        { 'v', function() nn.move_cell('d') end, { desc = 'Next Cell' } },
      },
    })

    local myai = require('my.miniai')

    myai.add_spec({ key = 'v', desc = 'notebook cell', spec = nn.miniai_spec })
    myai.setup()

    local hi = require('mini.hipatterns')

    hi.setup(vim.tbl_deep_extend('force', hi.config or {}, {
      highlighters = {
        notebook_separator = nn.minihipatterns_spec,
      },
    }))
  end,
}
