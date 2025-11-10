local function win_is_floating(buf, win)
  return vim.api.nvim_win_get_config(win).relative == ''
end

U.packadd('edgy.nvim')

local edgy = require('edgy')

edgy.setup({
  bottom = {
    { ft = 'snacks_terminal', filter = win_is_floating },
    { ft = 'trouble' },
  },

  options = {
    bottom = { size = 10 },
  },

  animate = { enabled = false },

  exit_when_last = true,

  keys = {
    ['q'] = function(win) win:close() end,
    ['<C-q>'] = function(win) win:hide() end,
  },
})

local function resize_win(direction, amount)
  return function()
    local win = edgy.get_win()
    if win then win:resize(direction, amount) end
  end
end

U.Hydra({
  name = 'Win Resize',
  mode = { 'n', 't' },
  body = '<C-w>',
  -- stylua: ignore
  heads = {
    { '+', resize_win('height', 2),  { desc = 'Add Height' } },
    { '-', resize_win('height', -2), { desc = 'Sub Height' } },
    { '>', resize_win('width', 2),   { desc = 'Add Width' } },
    { '<', resize_win('width', -2),  { desc = 'Sub Width' } },
  },
})
