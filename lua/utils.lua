local M = {
  __loaded = {},
}

---@param name string
function M.packadd(name)
  if M.__loaded[name] then return end

  M.__loaded[name] = true
  vim.cmd.packadd(name)

  vim.api.nvim_exec_autocmds('User', {
    pattern = 'PackLoaded_' .. name,
  })
end

function M.onload(name, cb)
  if M.__loaded[name] then
    cb()
  else
    M.autocmd('User', {
      pattern = 'PackLoaded_' .. name,
      once = true,
      callback = cb,
    })
  end
end

---@param name string
---@param opts? blink.cmp.SourceProviderConfig
function M.blink_add_source(name, opts)
  M.onload('blink.cmp', function()
    local blink_cmp = require('blink.cmp.config')
    ---@diagnostic disable-next-line: param-type-mismatch
    vim.list_extend(blink_cmp.sources.default, { name })

    if not opts then return end
    blink_cmp.sources.providers[name] = opts
  end)
end

local conform_loaded = false
-- Store formatters before conform setup
local conform_formatters = {}

---@param ft string | string[]
---@param formatters table
function M.set_formatter(ft, formatters)
  if type(ft) == 'table' then
    M.set_formatter(ft[1], formatters)
    return
  end

  if conform_loaded then
    vim.notify(
      'Formatter ' .. ft .. ' attempted to set after conform loaded.',
      vim.log.levels.WARN
    )
    return
  end
  conform_formatters[ft] = formatters
end

---@return table
function M.get_conform_formatters() return conform_formatters end

M.autocmd = vim.api.nvim_create_autocmd

---@param event string
---@param pattern string|nil
---@param cb function
function M.on(event, pattern, cb)
  return M.autocmd(event, { pattern = pattern, callback = cb })
end

return M
