U.set_formatter('markdown', { "prettierd" })

U.autocmd('Filetype', {
  pattern = 'markdown',
  callback = function()
    U.packadd "render-markdown.nvim"

    local m = require("render-markdown")

    m.setup {
      checkbox = {
        bullet = true,
        left_pad = 0,
        right_pad = 2,
      },
    }

    U.onload("snacks.nvim", function()
      Snacks.toggle({
        name = '[M]arkdown Render',
        get = function() return require('render-markdown.state').enabled end,
        set = function(enabled)
          if enabled then m.enable() else m.disable() end
        end,
      }):map('<leader>um')
    end
    )
  end,
})
