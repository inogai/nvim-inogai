return {
  { 'indent-rainbowline.nvim', dep_of = { 'indent-blankline.nvim' } },
  {
    'indent-blankline.nvim',
    event = 'VimEnter',
    after = function()
      vim.api.nvim_set_hl(0, 'IblScope', { fg = require('moegi').get_palette().green })

      ---@type 'ibl.config'
      local opts = {
        indent = { char = '▏' },
        scope = { char = '▎' },
      }

      opts = require('indent-rainbowline').make_opts(opts)

      require('ibl').setup(opts)
    end,
  },
}
