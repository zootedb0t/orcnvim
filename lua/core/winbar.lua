local M = {}

require("core.highlight").winbar_highlight()
local is_empty = require("core.utils.functions").isempty
local is_match = require("core.utils.functions").ismatch

local function filename()
  local buf_option = vim.api.nvim_buf_get_option(0, "mod")
  local fname = vim.fn.expand("%:t")
  local ftype = vim.fn.expand("%:e")

  local icon, color = require("nvim-web-devicons").get_icon_color(fname, ftype, { default = true })
  vim.api.nvim_set_hl(0, "FileIcon", { fg = color })

  if is_empty(fname) and not buf_option then
    return ""
  elseif not is_empty(fname) and buf_option then
    return table.concat({
      "%#FileIcon#",
      icon,
      " ",
      fname,
      "  ",
    })
  else
    return table.concat({
      "%#FileIcon#",
      icon,
      " ",
      fname,
    })
  end
end

local function active()
  return table.concat({
    "%#WinbarFile#",
    "%=",
    filename(),
  })
end

local function inactive()
  return ""
end

local function file_explorer()
  return "%#WinbarFile#" .. "%=" .. "File Explore" .. "%="
end

M.draw = function()
  local disable_winabar = { "alpha", "" }
  local buffer_type = vim.bo.filetype
  if is_match(disable_winabar, buffer_type) then
    return inactive()
  elseif vim.bo.filetype == "NvimTree" then
    return file_explorer()
  else
    return active()
  end
end

return M
