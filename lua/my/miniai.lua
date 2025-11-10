---A wrapper around 'mini.ai' plugin to add custom text objects and integrate with 'which-key'

---@class my.miniai.CustomTextObjectSpec
---@field key string
---@field desc string
---@field spec function | table

local M = {}

M.specs = {}

---@param spec my.miniai.CustomTextObjectSpec
function M.add_spec(spec) table.insert(M.specs, spec) end

---@param custom_textobjects my.miniai.CustomTextObjectSpec[]
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

---@param custom_textobjects my.miniai.CustomTextObjectSpec[]
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

function M.setup()
  setup_which_key(M.specs)
  setup_mini_ai({ n_lines = 500 }, M.specs)
end

return M
