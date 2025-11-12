return {
  {
    'obsidian',
    event = 'VimEnter',
    on_plugin = 'blink-cmp',
    config = function()
      local workspace_path = vim.fn.expand('~/Documents/Obsidian/v2')

      U.autocmd({ 'BufRead', 'BufNewFile' }, {
        pattern = workspace_path .. '/**',

        callback = function()
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
      })
    end,
  },
}
