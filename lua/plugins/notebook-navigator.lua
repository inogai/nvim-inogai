U.packadd('NotebookNavigator.nvim')
U.packadd('iron.nvim')

local nn = require('notebook-navigator')

nn.setup({})

-- TODO: explore why iron freezes until leaving hydra
U.Hydra({
  name = 'Notebook Navigator',
  mode = 'n',
  body = '<localleader>',
  heads = {
    { 'x', function() nn.run_and_move() end, { desc = 'Run Cell and Move' } },
    { 'X', function() nn.run_cell() end,     { desc = 'Run Cell' } },
  },
})

U.Hydra({
  body = '[',
  heads = {
    { 'v', function() nn.move_cell('u') end, { desc = 'Prev Cell' } },
  },
})

U.Hydra({
  body = ']',
  heads = {
    { 'v', function() nn.move_cell('d') end, { desc = 'Next Cell' } },
  },
})
