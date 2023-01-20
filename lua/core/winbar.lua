local M = {}

local function filename()
  local fname = vim.fn.expand("%:t")
  local buf_option = vim.api.nvim_buf_get_option(0, "mod")
  if require("core.utils.functions").isempty(fname) and not buf_option then
    return " "
  elseif not require("core.utils.functions").isempty(fname) and buf_option then
    return table.concat({
      fname,
      "  ",
    })
  else
    return string.format("%s", fname)
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

local function file_explorer()
  return "%=" .. "File Explore" .. "%="
end

M.draw = function()
  local disable_winabar = { "alpha" }
  local buffer_type = vim.bo.filetype
  if require("core.utils.functions").ismatch(disable_winabar, buffer_type) then
    return inactive()
  elseif vim.bo.filetype == "NvimTree" then
    return file_explorer()
  else
    return active()
  end
end

return M
