---@class CustomTextObjectSpec
---@field key string
---@field desc string
---@field spec function | table

---@param custom_textobjects CustomTextObjectSpec[]
local function setup_which_key(custom_textobjects)
  local prefixes = { around = 'a', inside = 'i' }
  local ret = { mode = { 'x' } }

  for _, prefix in pairs(prefixes) do
    for _, to in ipairs(custom_textobjects) do
      ---@type wk.Spec
      ret[#ret + 1] = { prefix .. to.key, desc = to.desc }
    end
  end

  require('which-key').add(ret, { notify = false })
end

---@param custom_textobjects CustomTextObjectSpec[]
local function setup_mini_ai(opts, custom_textobjects)
  ---@type table<string, function|table>
  local custom_textobjects_tbl = {}

  for _, to in ipairs(custom_textobjects) do
    custom_textobjects_tbl[to.key] = to.spec
  end

  require('mini.ai').setup(vim.tbl_deep_extend('force', opts, {
    custom_textobjects = custom_textobjects_tbl,
  }))
end

U.packadd('mini.nvim')
U.packadd('nvim-treesitter-textobjects')

local ai = require('mini.ai')

---@type CustomTextObjectSpec[]
local textobjects = {
  {
    key = 'o',
    desc = 'code block',
    spec = ai.gen_spec.treesitter({
      a = { '@block.outer', '@conditional.outer', '@loop.outer' },
      i = { '@block.inner', '@conditional.inner', '@loop.inner' },
    }),
  },
  {
    key = 'f',
    desc = 'function',
    spec = ai.gen_spec.treesitter({
      a = { '@function.outer' },
      i = { '@function.inner' },
    }),
  },
  {
    key = 'c',
    desc = 'class',
    spec = ai.gen_spec.treesitter({ a = { '@class.outer' }, i = { '@class.inner' } }),
  },
  {
    key = 'u',
    desc = 'function call',
    spec = ai.gen_spec.function_call(),
  },
  {
    key = 'U',
    desc = 'function call (without dot)',
    spec = ai.gen_spec.function_call({ name_pattern = '[%w_]' }),
  },
}

setup_which_key(textobjects)
setup_mini_ai({ n_lines = 500 }, textobjects)

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
    add = 'ga', -- Add surrounding in Normal and Visual modes
    delete = 'gs', -- Delete surrounding
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
