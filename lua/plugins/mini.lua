U.packadd('mini.nvim')
U.packadd('nvim-treesitter-textobjects')

local ai = require('mini.ai')
local myai = require('my.miniai')

myai.add_spec({
  key = 'o',
  desc = 'code block',
  spec = ai.gen_spec.treesitter({
    a = { '@block.outer', '@conditional.outer', '@loop.outer' },
    i = { '@block.inner', '@conditional.inner', '@loop.inner' },
  }),
})
myai.add_spec({
  key = 'f',
  desc = 'function',
  spec = ai.gen_spec.treesitter({
    a = { '@function.outer' },
    i = { '@function.inner' },
  }),
})
myai.add_spec({
  key = 'c',
  desc = 'class',
  spec = ai.gen_spec.treesitter({ a = { '@class.outer' }, i = { '@class.inner' } }),
})
myai.add_spec({
  key = 'u',
  desc = 'function call',
  spec = ai.gen_spec.function_call(),
})
myai.add_spec({
  key = 'U',
  desc = 'function call (without dot)',
  spec = ai.gen_spec.function_call({ name_pattern = '[%w_]' }),
})

myai.setup()

require('mini.pairs').setup({
  skip_next = [=[[%w%%%'%[%\"%.%`%$]]=],
  skip_unbalanced = true,
  markdown = true,
})

require('mini.icons').setup({
  lsp = {
    copilot = { glyph = ' ', hl = 'MiniIconsGrey' },
    avantecmd = { glyph = ' ', hl = 'MiniIconsGreen' },
    avantemention = { glyph = '󰁥 ', hl = 'MiniIconsRed' },
  },
})

require('mini.icons').mock_nvim_web_devicons() -- NOTE: For bufferline.nvim

require('mini.surround').setup({
  mappings = {
    add = 'ga',     -- Add surrounding in Normal and Visual modes
    delete = 'gs',  -- Delete surrounding
    replace = 'ge', -- Replace surrounding

    -- find = 'sf', -- Find surrounding (to the right)
    -- find_left = 'sF', -- Find surrounding (to the left)
    -- highlight = 'sh', -- Highlight surrounding
    -- update_n_lines = 'sn', -- Update `n_lines`

    suffix_last = 'l', -- Suffix to search with "prev" method
    suffix_next = 'n', -- Suffix to search with "next" method
  },
})

require('mini.statusline').setup()
