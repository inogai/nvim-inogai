local M = {
  __loaded = {},
}

---@param name string
function M.packadd(name)
  if M.__loaded[name] then return end

  M.__loaded[name] = true
  vim.cmd("packadd " .. name)

  vim.api.nvim_exec_autocmds("User", {
    pattern = "PackLoaded_" .. name,
  })
end

---@param dirname string
function M.import_dir(dirname)
  for _, pkg in ipairs(vim.fn.globpath(vim.fn.stdpath("config") .. "/lua/" .. dirname, "*.lua", true, true)) do
    local module_name = pkg:match("lua/" .. dirname .. "/(.*)%.lua$")
    if module_name then
      require(dirname .. "." .. module_name)
    end
  end
end

function M.onload(name, cb)
  if M.__loaded[name] then
    cb()
  else
    M.autocmd("User", {
      pattern = "PackLoaded_" .. name,
      once = true,
      callback = cb,
    })
  end
end

---@param name string
---@param opts? blink.cmp.SourceProviderConfig
function M.blink_add_source(name, opts)
  M.onload("blink-cmp", function()
    local blink_cmp = require("blink.cmp.config")
    blink_cmp.sources.default = vim.list_extend(
    ---@diagnostic disable-next-line: param-type-mismatch
      blink_cmp.sources.default,
      {
        vim.tbl_extend("force", { name = name }, opts or {}),
      }
    )

    if not opts then return end
    blink_cmp.sources.providers[name] = opts
  end)
end

M.autocmd = vim.api.nvim_create_autocmd

return M
