return {
  'nvim-treesitter',
  priority = 100,
  after = function()
    U.autocmd('FileType', {
      callback = function(args)
        local language = vim.treesitter.language.get_lang(args.match)
        if language and vim.treesitter.language.add(language) then
          vim.treesitter.start(args.buf, language)
        end
      end,
    })
  end,
}
