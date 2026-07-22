return {
  'render-markdown.nvim',
  ft = { 'markdown', 'nix', 'vimdoc', 'html' },
  after = function()
    require('render-markdown').setup({
      -- Render heading icons. Set to false to disable heading backgrounds/icons.
      heading = {
        enabled = true,
        icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
      },
      -- Use treesitter for code blocks.
      code = {
        enabled = true,
        style = 'full',
      },
      -- Keep sign column off for rendered buffers.
      sign = { enabled = false },
    })
  end,
}