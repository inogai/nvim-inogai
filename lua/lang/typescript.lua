vim.lsp.enable({ 'vtsls', 'eslint', 'denols', 'html', 'tailwindcss' })

vim.lsp.config('denols', {
  -- on_attach = on_attach,
  root_markers = { 'deno.json', 'deno.jsonc' },
})

vim.lsp.config('vtsls', {
  root_markers = { 'package.json', 'tsconfig.json', 'jsconfig.json' },
})

vim.lsp.config('eslint', {
  filetypes = {
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
    'astro',
  },
})

local function get_formatter(bufnr)
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
end

U.set_formatter({
  'javascript',
  'typescript',
  'typescriptreact',
  'javascriptreact',
  'astro',
}, get_formatter)

U.set_formatter('css', { 'prettierd' })

return {}
