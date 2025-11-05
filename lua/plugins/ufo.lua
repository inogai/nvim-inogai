U.packadd "nvim-ufo"

require "ufo".setup {
  provider_selector = function(_bufnr, filetype, _buftype)
    local main = 'lsp'
    local fallback = 'indent'

    if filetype == 'markdown' then main = 'treesitter' end

    return { main, fallback }
  end,
}
