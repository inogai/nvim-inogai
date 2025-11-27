local workspace_path = vim.fn.expand('~/Documents/Obsidian/v2')

return {
  {
    'obsidian.nvim',
    events = {
      { 'BufReadPre', pattern = workspace_path .. '/**' },
      { 'BufNewFile', pattern = workspace_path .. '/**' },
    },
    after = function()
      print('Loading Obsidian.nvim...')

      U.blink_add_source('obsidian')

      require('obsidian').setup({
        completion = {
          blink = true,
        },
        legacy_commands = false,
        ui = { enable = false }, -- in flavour of render-markdown.nvim
        workspaces = {
          {
            name = 'v2',
            path = workspace_path,
          },
        },
      })
    end,
    keys = {
      { '<localleader>o', '<cmd>Obsidian open<CR>', desc = '[O]pen in Obsidian' },
    },
  },
}
