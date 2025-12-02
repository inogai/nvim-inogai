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

---@param ft string | string[] a filetype or list of filetypes
---@param formatters conform.FiletypeFormatter the formatter table or function
function M.set_formatter(ft, formatters)
  if type(ft) == 'string' then ft = { ft } end

  M.onload('conform.nvim', function()
    local conform = require('conform')

    for _, f in ipairs(ft) do
      conform.formatters_by_ft[f] = formatters
    end
  end)
end

M.autocmd = vim.api.nvim_create_autocmd

---@param event string
---@param pattern string|nil
---@param cb function
function M.on(event, pattern, cb)
  return M.autocmd(event, { pattern = pattern, callback = cb })
end

return M
