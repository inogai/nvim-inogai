local function win_is_floating(buf, win)
  return vim.api.nvim_win_get_config(win).relative == ''
end

U.on('User', 'VeryLazy', function()
  U.packadd('edgy.nvim')

  require('edgy').setup({
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
      ['<C-w>>'] = function(win) win:resize('width', 2) end,
      ['<C-w><lt>'] = function(win) win:resize('width', -2) end,
      ['<C-w>+'] = function(win) win:resize('height', 2) end,
      ['<C-w>-'] = function(win) win:resize('height', -2) end,
    },
  })
end)
