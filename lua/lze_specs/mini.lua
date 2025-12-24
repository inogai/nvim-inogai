return {
  { 'nvim-treesitter-textobjects', dep_of = { 'mini.nvim' } },
  {
    'mini.nvim',
    dep_of = 'NotebookNavigator.nvim',
    event = 'VimEnter',
    after = function()
      local ai = require('mini.ai')
      local myai = require('my.miniai')

      myai.add_spec({
        key = 'o',
        desc = 'code block',
        spec = ai.gen_spec.treesitter({
          a = { '@block.outer', '@conditional.outer', '@loop.outer' },
          i = { '@block.inner', '@conditional.inner', '@loop.inner' },
        }),
      })
      myai.add_spec({
        key = 'f',
        desc = 'function',
        spec = ai.gen_spec.treesitter({
          a = { '@function.outer' },
          i = { '@function.inner' },
        }),
      })
      myai.add_spec({
        key = 'c',
        desc = 'class',
        spec = ai.gen_spec.treesitter({
          a = { '@class.outer' },
          i = { '@class.inner' },
        }),
      })
      myai.add_spec({
        key = 'u',
        desc = 'function call',
        spec = ai.gen_spec.function_call(),
      })
      myai.add_spec({
        key = 'U',
        desc = 'function call (without dot)',
        spec = ai.gen_spec.function_call({ name_pattern = '[%w_]' }),
      })

      myai.setup()

      require('mini.pairs').setup({
        skip_next = [=[[%w%%%'%[%\"%.%`%$]]=],
        skip_unbalanced = true,
        markdown = true,
      })

      require('mini.icons').setup({
        lsp = {
          copilot = { glyph = ' ', hl = 'MiniIconsGrey' },
          avantecmd = { glyph = ' ', hl = 'MiniIconsGreen' },
          avantemention = { glyph = '󰁥 ', hl = 'MiniIconsRed' },
        },
      })

      require('mini.icons').mock_nvim_web_devicons() -- NOTE: For bufferline.nvim

      require('mini.surround').setup({
        mappings = {
          add = 'ga', -- Add surrounding in Normal and Visual modes
          delete = 'gs', -- Delete surrounding
          replace = 'ge', -- Replace surrounding

          -- find = 'sf', -- Find surrounding (to the right)
          -- find_left = 'sF', -- Find surrounding (to the left)
          -- highlight = 'sh', -- Highlight surrounding
          -- update_n_lines = 'sn', -- Update `n_lines`

          suffix_last = 'l', -- Suffix to search with "prev" method
          suffix_next = 'n', -- Suffix to search with "next" method
        },
      })

      require('mini.statusline').setup()

      local function oklch2rgb(l, c, h)
        if l > 1 then l = l / 100 end
        h = math.rad(h)

        local a = c * math.cos(h)
        local bb = c * math.sin(h)

        local l_ = l + 0.3963377774 * a + 0.2158037573 * bb
        local m = l - 0.1055613458 * a - 0.0638541728 * bb
        local s_ = l - 0.0894841775 * a - 1.2914855480 * bb

        local function f(x)
          return x > 0.2068965517 and x ^ 3 or 108 * (x - 4 / 29) / 841
        end

        local x = 1.86206786 * l_ - 1.01119463 * m + 0.14918677 * s_
        local y = 0.38752654 * l_ + 0.62144744 * m - 0.00897398 * s_
        local z = -0.01584150 * l_ - 0.03412294 * m + 1.04996444 * s_

        x, y, z = f(x), f(y), f(z)

        local r_lin = 3.2404542 * x - 1.5371385 * y - 0.4985314 * z
        local g_lin = -0.9692660 * x + 1.8760108 * y + 0.0415560 * z
        local b_lin = 0.0556434 * x - 0.2040259 * y + 1.0572252 * z

        local function gamma(c_val)
          return c_val <= 0.0031308 and 12.92 * c_val
            or 1.055 * (c_val ^ (1 / 2.4)) - 0.055
        end

        local r = math.min(255, math.max(0, math.floor(gamma(r_lin) * 255 + 0.5)))
        local g = math.min(255, math.max(0, math.floor(gamma(g_lin) * 255 + 0.5)))
        local b = math.min(255, math.max(0, math.floor(gamma(b_lin) * 255 + 0.5)))

        return string.format('#%02x%02x%02x', r, g, b)
      end

      local hipatterns = require('mini.hipatterns')
      hipatterns.setup(vim.tbl_deep_extend('force', hipatterns.config or {}, {
        highlighters = {
          hex = hipatterns.gen_highlighter.hex_color(),

          oklch = {
            pattern = 'oklch%b()', -- oklch(<l> <c> <h>)
            group = function(_, match, data)
              local s = data.full_match:sub(7, -2)
              local l, c, h =
                s:match('([%d%.]+)[%s]* [%s]*([%d%.]+)[%s]* [%s]*([%d%.]+)')
              if not l then return '' end

              l, c, h = tonumber(l), tonumber(c), tonumber(h)
              if not l or not c or not h then return '' end

              local hex = oklch2rgb(l, c, h)
              return MiniHipatterns.compute_hex_color_group(hex, 'bg')
            end,
            extmark_opts = { priority = 2000 },
          },
        },
      }))
    end,
  },
}
