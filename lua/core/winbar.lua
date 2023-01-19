local M = {}

local function filename()
  local fname = vim.fn.expand("%:t")
  if require("core.utils.functions").isempty(fname) then
    return " "
  else
    return string.format(" %s ", fname)
  end
end

local function active()
  return table.concat({
    "%=",
    filename(),
  })
end

local function inactive()
  return " "
end

function M.winbar()
  local disable_winabar = { "NvimTree", "alpha" }
  local buffer_type = vim.bo.filetype
  if require("core.utils.functions").ismatch(disable_winabar, buffer_type) then
    return inactive()
  else
    return active()
  end
end

return M
