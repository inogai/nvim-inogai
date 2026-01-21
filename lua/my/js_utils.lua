local M = {}

---A heristiuc helper to get the appropriate formatter for a JS/TS buffer.
---@param bufnr number
---@return string[]
function M.get_formatter(bufnr)
  if vim.lsp.get_clients({ bufnr = bufnr, name = 'denols' }) then
    -- If denols is active, use its built-in formatter
    return {}
  end

  local cutil = require('conform.util')

  if
    cutil.root_file({ -- there are other eslint config files, add them if needed
      '.eslintrc.json',
      'eslint.config.js',
      'eslint.config.ts',
    })
  then
    return { 'eslint_d' }
  end

  if cutil.root_file({
    '.prettierrc',
    '.editorconfig',
  }) then
    return { 'prettierd' }
  end

  return {}
end

return M
