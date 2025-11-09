local M = {
  __loaded = {},
}

---@param name string
function M.packadd(name)
  if M.__loaded[name] then return end

  M.__loaded[name] = true
  vim.cmd('packadd ' .. name)

  vim.api.nvim_exec_autocmds('User', {
    pattern = 'PackLoaded_' .. name,
  })
end

---@param dirname string
function M.import_dir(dirname)
  -- When using wrapRc, we need to search in the runtime path, not stdpath
  -- The actual config is in the Nix store, accessible via runtimepath
  local search_paths = vim.api.nvim_list_runtime_paths()
  local found_paths = {}

  -- Find all paths that contain the directory
  for _, rtp in ipairs(search_paths) do
    local lua_dir = rtp .. '/lua/' .. dirname
    local files = vim.fn.globpath(lua_dir, '*.lua', true, true)
    if #files > 0 then table.insert(found_paths, { path = lua_dir, files = files }) end
  end

  -- Notify if multiple or no paths found
  if #found_paths == 0 then
    vim.notify('No files found in lua/' .. dirname, vim.log.levels.WARN)
    return
  elseif #found_paths > 1 then
    local paths = vim.tbl_map(function(p) return p.path end, found_paths)
    vim.notify(
      'Multiple paths found for lua/' .. dirname .. ':\n' .. table.concat(paths, '\n'),
      vim.log.levels.WARN
    )
  end

  -- Load modules from the first found path only
  for _, pkg in ipairs(found_paths[1].files) do
    local module_name = pkg:match('lua/' .. dirname .. '/(.*)%.lua$')
    if module_name then
      local ok, _ = pcall(require, dirname .. '.' .. module_name)

      if not ok then
        vim.notify(
          'Failed to load module: ' .. dirname .. '.' .. module_name,
          vim.log.levels.ERROR
        )
      end
    end
  end
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

---@param ft string
---@param formatters table
function M.set_formatter(ft, formatters)
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
---@param pattern string
---@param cb function
function M.on(event, pattern, cb)
  return M.autocmd(event, { pattern = pattern, callback = cb })
end

return M
