return {
  'iron.nvim',
  dep_of = { 'NotebookNavigator.nvim' },
  event = 'VimEnter',
  after = function()
    local iron = require('iron.core')
    local view = require('iron.view')
    local common = require('iron.fts.common')

    -- TODO: iron should show when sending code to REPL

    iron.setup({
      config = {
        scratch_repl = true,
        repl_definition = {
          sh = {
            command = { 'zsh' },
          },
          python = {
            command = function()
              local ipython = vim.fn.exepath('ipython')
              if ipython ~= '' then
                return { ipython, '--no-autoindent' }
              else
                return { 'python' }
              end
            end,
            format = common.bracketed_paste_python,
            block_dividers = { '# %%', '#%%' },
            env = { PYTHON_BASIC_REPL = '1' }, --this is needed for python3.13 and up.
          },
        },
        repl_filetype = function(bufnr, ft) return 'iron' end,
        dap_integration = true,
        -- don't care about this, use edgy
        repl_open_cmd = view.split.vertical.rightbelow('%40'),
      },
      -- Iron doesn't set keymaps by default anymore.
      -- You can set them here or manually add keymaps to the functions in iron.core
      keymaps = {
        -- toggle_repl = '<space>rr', -- toggles the repl open and closed.
        -- If repl_open_command is a table as above, then the following keymaps are
        -- available
        -- toggle_repl_with_cmd_1 = "<space>rv",
        -- toggle_repl_with_cmd_2 = "<space>rh",
        -- restart_repl = '<space>rR', -- calls `IronRestart` to restart the repl
        -- send_motion = '<space>sc',
        -- visual_send = '<space>sc',
        -- send_file = '<space>sf',
        -- send_line = '<space>sl',
        -- send_paragraph = '<space>sp',
        -- send_until_cursor = '<space>su',
        -- send_mark = '<space>sm',
        -- send_code_block = '<space>sb',
        -- send_code_block_and_move = '<space>sn',
        -- mark_motion = '<space>mc',
        -- mark_visual = '<space>mc',
        -- remove_mark = '<space>md',
        -- cr = '<space>s<cr>',
        -- interrupt = '<space>s<space>',
        -- exit = '<space>sq',
        -- clear = '<space>cl',
      },
      -- If the highlight is on, you can change how it looks
      -- For the available options, check nvim_set_hl
      highlight = {},
      ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
    })

    -- iron also has a list of commands, see :h iron-commands for all available commands
    -- vim.keymap.set('n', '<space>rf', '<cmd>IronFocus<cr>')
    -- vim.keymap.set('n', '<space>rh', '<cmd>IronHide<cr>')
  end,
}
