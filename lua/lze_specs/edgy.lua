return {
  'edgy.nvim',
  event = 'VimEnter',
  after = function()
    local function win_is_floating(buf, win)
      return vim.api.nvim_win_get_config(win).relative == ''
    end

    local edgy = require('edgy')
    local Hydra = require('hydra')

    edgy.setup({
      bottom = {
        { ft = 'snacks_terminal', filter = win_is_floating },
        { ft = 'trouble' },
      },

      right = {
        { ft = 'iron' },
      },

      options = {
        bottom = { size = 0.3 },
        right = { size = 80 },
      },

      animate = { enabled = false },

      exit_when_last = true,
    })

    local function toggle_max(direction)
      local win = edgy.get_win()
      if not win then return end

      local winnr = win.win
      local is_height = direction == 'height'
      local cur_value = is_height and vim.api.nvim_win_get_height(winnr)
        or vim.api.nvim_win_get_width(winnr)
      local max_value = is_height and vim.o.lines or vim.o.columns
      local new_value = (max_value - cur_value < 10) and 2 or max_value

      vim.w[winnr]['edgy_' .. direction] = new_value
      require('edgy.layout').update()
    end

    local function resize_win(direction, amount)
      return function()
        local win = edgy.get_win()
        if win then win:resize(direction, amount) end
      end
    end

    vim.api.nvim_create_autocmd('BufWinEnter', {
      callback = function()
        if edgy.get_win() then
          Hydra({
            name = 'Win Resize',
            mode = { 'n', 't' },
            body = '<C-w>',
            buffer = true,
            -- stylua: ignore
            heads = {
              { '+', resize_win('height', 2),                               { desc = 'Add Height' } },
              { '-', resize_win('height', -2),                              { desc = 'Sub Height' } },
              { '>', resize_win('width', 2),                                { desc = 'Add Width' } },
              { '<', resize_win('width', -2),                               { desc = 'Sub Width' } },
              { '=', function() edgy.get_win().view.edgebar:equalize() end, { desc = 'Equal Size' } },
              { '_', function() toggle_max('height') end,                   { desc = 'Toggle Max Height' } },
              { '|', function() toggle_max('width') end,                    { desc = 'Toggle Max Width' } },
              { 'q', nil,                                                   { desc = 'Quit', exit = true } },
            },
          })
        end
      end,
    })

    -- stylua: ignore
    -- require("which-key").add {
    --   { '<C-h>', '<C-w>h',                                           desc = 'Go to left window',  mode = 'nixs' },
    --   { '<C-j>', '<C-w>j',                                           desc = 'Go to lower window', mode = 'nixs' },
    --   { '<C-k>', '<C-w>k',                                           desc = 'Go to upper window', mode = 'nixs' },
    --   { '<C-l>', '<C-w>l',                                           desc = 'Go to right window', mode = 'nixs' },
    --   { '<C-/>', function() require('snacks').terminal.toggle() end, desc = 'Terminal',           mode = 'nixst' },
    -- }
  end,
}
