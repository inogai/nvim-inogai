-- Clipboard provider for Neovim.
--
-- Only sets a backend when explicitly configured via:
--   1. vim.g.clipboard_backend  (user override)
--   2. CLIPBOARD_BACKEND environment variable
--
-- Otherwise, lets Neovim use its default (macOS pbpaste/pbcopy, etc.).

local M = {}

local backends = {}

backends.wsl = {
  name = 'WSL Clipboard',
  copy = {
    ['+'] = { 'clip.exe' },
    ['*'] = { 'clip.exe' },
  },
  paste = {
    ['+'] = {
      'powershell.exe', '-NoProfile', '-Command',
      '[Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r`n","`n").replace("`r",""))',
    },
    ['*'] = {
      'powershell.exe', '-NoProfile', '-Command',
      '[Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r`n","`n").replace("`r",""))',
    },
  },
  cache_enabled = true,
}

backends.win32yank = {
  name = 'win32yank',
  copy = {
    ['+'] = 'win32yank.exe -i --crlf',
    ['*'] = 'win32yank.exe -i --crlf',
  },
  paste = {
    ['+'] = 'win32yank.exe -o --lf',
    ['*'] = 'win32yank.exe -o --lf',
  },
  cache_enabled = false,
}

---Detect the display server / clipboard environment.
---Returns nil if no backend should be explicitly configured.
---@return string|nil
function M.detect_backend()
  local explicit = vim.g.clipboard_backend
  if explicit and explicit ~= '' then return explicit end

  local env_backend = vim.fn.environ()['CLIPBOARD_BACKEND']
  if env_backend and env_backend ~= '' then return env_backend end

  return nil
end

---Get the provider table for a given backend name.
---@param backend string
---@return table|nil
function M.get_provider(backend)
  if not backend then return nil end
  if backend == 'osc52' then return M._build_osc52() end
  return backends[backend]
end

---Apply the clipboard configuration.
function M.setup()
  local backend = M.detect_backend()
  if not backend then return end

  local provider = M.get_provider(backend)
  if provider then
    vim.g.clipboard = provider
    vim.notify(
      string.format('Clipboard: using "%s" backend', provider.name),
      vim.log.levels.INFO
    )
  else
    vim.notify(
      string.format('Clipboard: unknown backend "%s", falling back to default', backend),
      vim.log.levels.WARN
    )
  end
end

return M
