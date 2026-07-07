-- Clipboard provider for Neovim.
--
-- Supports multiple backends:
--   - wsl:      clip.exe / powershell.exe Get-Clipboard (Windows Subsystem for Linux)
--   - wl:       wl-copy / wl-paste (Wayland)
--   - xclip:    xclip (X11)
--   - osc52:    OSC 52 escape sequence (SSH / tmux)
--
-- Backend selection (highest priority first):
--   1. vim.g.clipboard_backend  (explicit user override)
--   2. Auto-detection based on environment

local M = {}

---Detect if running under WSL by checking /proc/version for "microsoft" or "WSL".
---@return boolean
function M.is_wsl()
  local f = io.open('/proc/version', 'r')
  if not f then return false end
  local content = f:read('*a')
  f:close()
  return content:lower():find('microsoft') ~= nil or content:find('WSL') ~= nil
end

---Detect the display server / clipboard environment.
---@return string backend
function M.detect_backend()
  local explicit = vim.g.clipboard_backend
  if explicit and explicit ~= '' then return explicit end

  -- Check environment variable set by Home Manager or user
  local env_backend = vim.fn.environ()['CLIPBOARD_BACKEND']
  if env_backend and env_backend ~= '' then return env_backend end

  if M.is_wsl() then return 'wsl' end

  if vim.fn.executable('wl-copy') == 1 and vim.fn.executable('wl-paste') == 1 then
    return 'wl'
  end

  if vim.fn.executable('xclip') == 1 then return 'xclip' end

  -- Fallback: try OSC 52 (works in SSH, tmux, and most terminals)
  return 'osc52'
end

---Build the clipboard provider table for a given backend.
---@param backend string
---@return table|nil
function M.get_provider(backend)
  if backend == 'wsl' then
    -- clip.exe writes text, but it appends a trailing newline/crlf.
    -- powershell Get-Clipboard handles multi-line and strips carriage returns.
    return {
      name = 'WSL Clipboard',
      copy = {
        ['+'] = { 'clip.exe' },
        ['*'] = { 'clip.exe' },
      },
      paste = {
        ['+'] = {
          'powershell.exe',
          '-NoProfile',
          '-Command',
          '[Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r`n","`n").replace("`r",""))',
        },
        ['*'] = {
          'powershell.exe',
          '-NoProfile',
          '-Command',
          '[Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r`n","`n").replace("`r",""))',
        },
      },
      cache_enabled = true,
    }
  end

  if backend == 'wl' then
    return {
      name = 'Wayland Clipboard (wl-clipboard)',
      copy = {
        ['+'] = { 'wl-copy', '--foreground', '--type', 'text/plain' },
        ['*'] = { 'wl-copy', '--foreground', '--type', 'text/plain' },
      },
      paste = {
        ['+'] = { 'wl-paste', '--no-newline' },
        ['*'] = { 'wl-paste', '--no-newline' },
      },
      cache_enabled = true,
    }
  end

  if backend == 'xclip' then
    return {
      name = 'X11 Clipboard (xclip)',
      copy = {
        ['+'] = { 'xclip', '-selection', 'clipboard' },
        ['*'] = { 'xclip', '-selection', 'primary' },
      },
      paste = {
        ['+'] = { 'xclip', '-selection', 'clipboard', '-o' },
        ['*'] = { 'xclip', '-selection', 'primary', '-o' },
      },
      cache_enabled = true,
    }
  end

  if backend == 'osc52' then
    -- OSC 52: works over SSH, tmux, and most modern terminals.
    -- Uses the built-in vim.clipboard.osc52 provider if available (Neovim 0.10+).
    local ok, osc52 = pcall(require, 'vim.clipboard.osc52')
    if ok and osc52 then
      return {
        name = 'OSC 52 Clipboard',
        copy = {
          ['+'] = osc52.copy('+'),
          ['*'] = osc52.copy('*'),
        },
        paste = {
          ['+'] = osc52.paste('+'),
          ['*'] = osc52.paste('*'),
        },
      }
    end
    -- Fallback: write OSC 52 sequence manually
    return {
      name = 'OSC 52 Clipboard (fallback)',
      copy = {
        ['+'] = {
          function(lines)
            local encoded = vim.base64.encode(table.concat(lines, '\n'))
            vim.api.nvim_exec_autocmds('TextYankPost', {})
            io.write(string.format('\x1b]52;c;%s\x1b\\', encoded))
            io.flush()
          end,
        },
        ['*'] = {
          function(lines)
            local encoded = vim.base64.encode(table.concat(lines, '\n'))
            vim.api.nvim_exec_autocmds('TextYankPost', {})
            io.write(string.format('\x1b]52;c;%s\x1b\\', encoded))
            io.flush()
          end,
        },
      },
      paste = {
        ['+'] = {},
        ['*'] = {},
      },
    }
  end

  return nil
end

---Apply the clipboard configuration.
function M.setup()
  local backend = M.detect_backend()
  local provider = M.get_provider(backend)

  if provider then
    vim.g.clipboard = provider
    vim.notify(string.format('Clipboard: using "%s" backend', provider.name), vim.log.levels.INFO)
  else
    vim.notify(
      string.format('Clipboard: unknown backend "%s", falling back to default', backend),
      vim.log.levels.WARN
    )
  end
end

return M
