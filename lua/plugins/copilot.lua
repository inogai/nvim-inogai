U.autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    U.packadd "copilot-lsp"
    U.packadd "copilot.lua"
    U.packadd "blink-copilot"

    U.blink_add_source('copilot', {
      name = 'copilot',
      module = 'blink-copilot',
      score_offset = 100,
      async = true,
    })

    require "copilot".setup {
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
      nes = {
        enabled = true,
        keymap = {
          accept_and_goto = '<leader>p',
          accept = false,
          dismiss = '<Esc>',
        },
      },
    }
  end
})
