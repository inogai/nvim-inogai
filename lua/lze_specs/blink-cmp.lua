return {
  { 'friendly-snippets', dep_of = { 'blink.cmp' } },
  {
    'blink.cmp',
    cmd = 'BlinkCmp',
    event = 'InsertEnter',
    after = function()
      local sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
        providers = {},
      }

      sources =
          vim.tbl_deep_extend('force', sources, require('blink.cmp.config').sources)

      require('blink.cmp').setup({
        keymap = {
          preset = 'none',
          ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
          ['<C-e>'] = { 'hide', 'fallback' },
          ['<Tab>'] = {
            function(cmp)
              if cmp.snippet_active() then
                return cmp.accept()
              else
                return cmp.select_and_accept()
              end
            end,
            'snippet_forward',
            'fallback',
          },
          ['<S-Tab>'] = { 'snippet_backward', 'fallback' },

          ['<Up>'] = { 'select_prev', 'fallback' },
          ['<Down>'] = { 'select_next', 'fallback' },
          ['<C-k>'] = { 'select_prev', 'fallback' },
          ['<C-j>'] = { 'select_next', 'fallback' },
          ['<C-l>'] = { 'select_and_accept', 'fallback' },

          ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
          ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

          ['<C-p>'] = {
            function(cmp)
              if vim.b[vim.api.nvim_get_current_buf()].nes_state then
                cmp.hide()
                local nes = require('copilot-lsp.nes')
                return nes.apply_pending_nes() and nes.walk_cursor_end_edit()
              end
            end,
          },
        },
        appearance = {
          nerd_font_variant = 'mono',
        },
        completion = {
          documentation = { auto_show = true },
          menu = {
            draw = {
              components = {
                kind_icon = {
                  text = function(ctx)
                    local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
                    return kind_icon
                  end,
                  -- (optional) use highlights from mini.icons
                  highlight = function(ctx)
                    local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                    return hl
                  end,
                },
                kind = {
                  highlight = function(ctx)
                    local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                    return hl
                  end,
                },
              },
            },
          },
        },
        sources = sources,
        fuzzy = { implementation = 'prefer_rust_with_warning' },
      })
    end,
  },
}
