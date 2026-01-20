local WORKSPACE_ROOT = vim.fn.expand('~/Documents/Obsidian')

local function find_workspaces(root)
  local ret = {}
  local dirs = vim.fn.globpath(root, '*', false, true)

  for _, dir in ipairs(dirs) do
    if vim.fn.isdirectory(dir) == 1 then
      table.insert(ret, {
        name = vim.fn.fnamemodify(dir, ':t'),
        path = dir,
      })
    end
  end

  return ret
end

return {
  {
    'obsidian.nvim',
    events = {
      { 'BufReadPre', pattern = WORKSPACE_ROOT .. '/**' },
      { 'BufNewFile', pattern = WORKSPACE_ROOT .. '/**' },
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
        workspaces = find_workspaces(WORKSPACE_ROOT),
      })
    end,
    keys = {
      { '<localleader>o', '<cmd>Obsidian open<CR>', desc = '[O]pen in Obsidian' },
    },
  },
}
