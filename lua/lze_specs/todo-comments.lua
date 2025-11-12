return {
  {
    'todo-comments',
    event = 'VimEnter',
    config = function() require('todo-comments').setup({}) end,
  },
}
