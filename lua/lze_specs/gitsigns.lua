-- Gitsigns.nvim configuration
local function visual_range()
  local first_line = vim.fn.line('v')
  local last_line = vim.fn.line('.')
  return { first_line, last_line }
end

return {
  'gitsigns.nvim',
  event = { 'BufReadPost', 'BufNewFile' },
  after = function()
    require('gitsigns').setup({
      signs = {
        add = { text = '▎' },
        change = { text = '▎' },
        delete = { text = '' },
        topdelete = { text = '' },
        changedelete = { text = '▎' },
        untracked = { text = '▎' },
      },
      signs_staged = {
        add = { text = '▎' },
        change = { text = '▎' },
        delete = { text = '' },
        topdelete = { text = '' },
        changedelete = { text = '▎' },
      },
    })
  end,
  -- stylua: ignore
  keys = {
    { ']c', function() require('gitsigns').nav_hunk('next') end,           desc = 'Next Hunk' },
    { '[c', function() require('gitsigns').nav_hunk('prev') end,           desc = 'Prev Hunk' },
    { 'gh', function() require('gitsigns').stage_hunk() end,               desc = 'Stage Hunk' },
    { 'gh', function() require('gitsigns').stage_hunk(visual_range()) end, desc = 'Stage Hunk',  mode = 'v', },
    { 'gH', function() require('gitsigns').reset_hunk() end,               desc = 'Reset Hunk' },
    { 'gH', function() require('gitsigns').reset_hunk(visual_range()) end, desc = 'Reset Hunk',  mode = 'v', },
    { 'go', function() require('gitsigns').preview_hunk_inline() end,      desc = 'Preview Hunk' },
  },
}
