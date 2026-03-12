local M = {}

local function replace_heading(line, direction, char)
  local prefix = char == '#' and ' ' or ''
  local pattern = '^' .. vim.pesc(char) .. (char == '#' and '+%s' or '+')
  if not line:match(pattern) then return line end
  if direction == 'increase' then
    return char .. prefix .. line
  else
    return line:gsub('^' .. vim.pesc(char) .. vim.pesc(prefix), '', 1)
  end
end

function M.change_heading(direction, char)
  local mode = vim.api.nvim_get_mode().mode
  if mode == 'n' then
    local line = vim.api.nvim_get_current_line()
    vim.api.nvim_set_current_line(replace_heading(line, direction, char))
  else
    local start_line = vim.api.nvim_buf_get_mark(0, '<')[1]
    local end_line = vim.api.nvim_buf_get_mark(0, '>')[1]
    local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
    for i, line in ipairs(lines) do
      lines[i] = replace_heading(line, direction, char)
    end
    vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, lines)
  end
end

function M.setup(bufnr, char)
  -- stylua: ignore
  require('which-key').add({
    { '<localleader>+', function() M.change_heading('increase', char) end, desc = 'Increase Heading', mode = { 'n', 'x' }, buffer = bufnr },
    { '<localleader>-', function() M.change_heading('decrease', char) end, desc = 'Decrease Heading', mode = { 'n', 'x' }, buffer = bufnr },
  })
end

return M
