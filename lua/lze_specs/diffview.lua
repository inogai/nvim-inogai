return {
  'diffview.nvim',
  event = 'VimEnter',
  after = function()
    vim.keymap.set('n', '<leader>gg', '<cmd>DiffviewOpen<cr>', { desc = 'Diffview' })

    ---@alias my.dv.Panel 'view' | 'diff1' | 'diff2' | 'diff3' | 'diff4' | 'file_panel' | 'file_history_panel' | 'option_panel' | 'help_panel'

    local ALL_PANELS = {
      'view',
      'diff1',
      'diff2',
      'diff3',
      'diff4',
      'file_panel',
      'file_history_panel',
      'option_panel',
      'help_panel',
    }

    local PANE_MAP = {
      v = { 'view' },
      ['1'] = { 'diff1' },
      ['2'] = { 'diff2' },
      ['3'] = { 'diff3' },
      ['4'] = { 'diff4' },
      d = { 'diff1', 'diff2', 'diff3', 'diff4' },
      f = { 'file_panel' },
      h = { 'file_history_panel' },
      o = { 'option_panel' },
      ['?'] = { 'help_panel' },
    }

    ---@param short string|nil
    ---@return my.dv.Panel[]
    local function translate_panel(short)
      if not short then return ALL_PANELS end

      local reverse = short:sub(1, 1) == '!'
      if reverse then short = short:sub(2) end

      local result = {}
      for c in short:gmatch('.') do
        vim.list_extend(result, PANE_MAP[c] or {})
      end

      if reverse then
        result = vim.tbl_filter(
          function(p) return not vim.tbl_contains(result, p) end,
          ALL_PANELS
        )
      end
      return result
    end

    ---@class my.dv.KeySpec
    ---@field [1] string lhs
    ---@field [2] string|function rhs
    ---@field mode? string
    ---@field desc? string
    ---@field pane? string

    local actions = require('diffview.actions')
    local keymaps = {}

    ---@param spec my.dv.KeySpec
    local function map(spec)
      spec.mode = spec.mode or 'n'
      local panels = translate_panel(spec.pane)

      for _, panel in ipairs(panels) do
        keymaps[panel] = keymaps[panel] or {}
        table.insert(
          keymaps[panel],
          { spec.mode, spec[1], spec[2], { desc = spec.desc } }
        )
      end
    end

    -- stylua: ignore
    ---@type my.dv.KeySpec[]
    local keys = {
      { 'q',          '<cmd>DiffviewClose<cr>',  pane = '!?',             desc = '[Q]uit' },
      { '<leader>gg', '<cmd>DiffviewClose<cr>',  desc = 'Toggle Diffview' },
      { '<down>',     actions.select_next_entry, pane = 'f',              desc = 'Select Next entry' },
      { 'j',          actions.select_next_entry, pane = 'f',              desc = 'Select Next entry' },
      { '<up>',       actions.select_prev_entry, pane = 'f',              desc = 'Select Previous entry' },
      { 'k',          actions.select_prev_entry, pane = 'f',              desc = 'Select Previous entry' },
    }

    for _, key in ipairs(keys) do
      map(key)
    end

    local C = require('moegi').get_palette()

    -- Custom highlights
    vim.api.nvim_set_hl(0, 'MyDiffDeletedLines', { link = 'NonText' })
    vim.api.nvim_set_hl(0, 'MyDiffTextFrom', { bg = '#6d4443' })
    vim.api.nvim_set_hl(0, 'MyDiffChangeFrom', { bg = '#4a3433' })
    vim.api.nvim_set_hl(0, 'MyDiffTextTo', { bg = '#3a5247' })
    vim.api.nvim_set_hl(0, 'MyDiffChangeTo', { bg = '#2e3b36' })

    require('diffview').setup({
      enhanced_diff_hl = true,
      keymaps = keymaps,
      hooks = {
        ---@diagnostic disable-next-line: unused-local
        diff_buf_win_enter = function(bufnr, winid, ctx)
          if ctx.layout_name:match('^diff2') then
            local winhl = ctx.symbol == 'a'
                and {
                  'DiffAdd:MyDiffTextFrom',
                  'DiffDelete:MyDiffDeletedLines',
                  'DiffChange:MyDiffChangeFrom',
                  'DiffText:MyDiffTextFrom',
                }
              or {
                'DiffAdd:MyDiffChangeTo',
                'DiffDelete:MyDiffDeletedLines',
                'DiffChange:MyDiffChangeTo',
                'DiffText:MyDiffTextTo',
              }
            vim.opt_local.winhl = table.concat(winhl, ',')
          end
        end,
      },
    })
  end,
}
