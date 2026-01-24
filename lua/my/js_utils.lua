local M = {}

---A heristiuc helper to get the appropriate formatter for a JS/TS buffer.
---@param bufnr number
---@return string[]
function M.get_formatter(bufnr)
  if
    vim.fs.root(bufnr, { -- there are other eslint config files, add them if needed
      '.eslintrc.json',
      'eslint.config.js',
      'eslint.config.ts',
    }) ~= nil
  then
    return { 'eslint_d' }
  end

  if vim.fs.root(bufnr, {
    '.prettierrc',
    '.editorconfig',
  }) ~= nil then
    return { 'prettierd' }
  end

  return {}
end

return M
