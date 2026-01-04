U.set_formatter('markdown', { 'prettier-inogai', 'prettierd', stop_after_first = true })

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    -- 'r' enables continuation of comments/elements on Enter
    -- 'o' enables continuation when using 'o' or 'O' to open new lines
    vim.opt_local.formatoptions:append('ro')
    vim.opt_local.comments = { 'n:>', 'n:-', 'n:*', 'n:1.' }

    -- Delete comment prefix when pressing Enter on empty line with comment
    local function delete_comment_on_enter()
      local line = vim.api.nvim_get_current_line()
      local cursor_col = vim.api.nvim_win_get_cursor(0)[2]

      -- Check if line contains only whitespace and comment prefix
      -- TODO: match other comment styles as well
      if line:match('^%s*[%->*]%s*$') and cursor_col >= #line then
        vim.api.nvim_set_current_line('')
      end
      return '<CR>'
    end

    vim.keymap.set('i', '<CR>', delete_comment_on_enter, {
      buffer = true,
      expr = true,
      desc = 'Delete comment prefix on empty line',
    })

    -- Enhanced 'o' command that cleans up comment prefixes
    vim.keymap.set('n', 'o', function()
      local line = vim.api.nvim_get_current_line()
      if line:match('^%s*[%->*]%s*$') then vim.api.nvim_set_current_line('') end
      return 'o'
    end, {
      buffer = true,
      expr = true,
      desc = 'Open line below with comment cleanup',
    })

    -- Enhanced 'O' command that cleans up comment prefixes
    vim.keymap.set('n', 'O', function()
      local line = vim.api.nvim_get_current_line()
      if line:match('^%s*[%->*]%s*$') then vim.api.nvim_set_current_line('') end
      return 'O'
    end, {
      buffer = true,
      expr = true,
      desc = 'Open line above with comment cleanup',
    })
  end,
})

return {
  'render-markdown.nvim',
  ft = 'markdown',
  after = function()
    local m = require('render-markdown')

    m.setup({
      checkbox = {
        bullet = true,
        left_pad = 0,
        right_pad = 2,
      },
    })

    U.onload('snacks.nvim', function()
      Snacks.toggle({
        name = '[M]arkdown Render',
        get = function() return require('render-markdown.state').enabled end,
        set = function(enabled)
          if enabled then
            m.enable()
          else
            m.disable()
          end
        end,
      }):map('<leader>um')
    end)
  end,
}
