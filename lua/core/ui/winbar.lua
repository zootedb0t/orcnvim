local M = {}

require("core.ui.highlight").winbar_highlight()
local is_empty = require("core.utils.functions").isempty
local is_match = require("core.utils.functions").ismatch
local icon = require("core.icons")
local space = " "

local status_ok_navic, navic = pcall(require, "nvim-navic")
if not status_ok_navic then
  return
end

navic.setup({
  icons = {
    File = icon.ui.File .. space,
    Module = icon.kind.Module .. space,
    Namespace = icon.kind.Namespace .. space,
    Package = icon.kind.Package .. space,
    Class = icon.kind.Class .. space,
    Method = icon.kind.Method .. space,
    Property = icon.kind.Property .. space,
    Field = icon.kind.Field .. space,
    Constructor = icon.kind.Constructor .. space,
    Enum = icon.kind.Enum .. space,
    Interface = icon.kind.Interface .. space,
    Function = icon.kind.Function .. space,
    Variable = icon.kind.Variable .. space,
    Constant = icon.kind.Constant .. space,
    String = icon.kind.String .. space,
    Number = icon.kind.Number .. space,
    Boolean = icon.kind.Boolean .. space,
    Array = icon.kind.Array .. space,
    Object = icon.kind.Object .. space,
    Key = icon.kind.Key .. space,
    Null = icon.kind.Null .. space,
    EnumMember = icon.kind.EnumMember .. space,
    Struct = icon.kind.Struct .. space,
    Event = icon.kind.Event .. space,
    Operator = icon.kind.Operator .. space,
    TypeParameter = icon.kind.TypeParameter .. space,
  },
  highlight = true,
  separator = icon.ui.ChevronRight .. space,
})

local function filename()
  local buf_mod = vim.api.nvim_buf_get_option(0, "mod")
  local fname = vim.fn.expand("%:t")
  local extension = vim.fn.expand("%:e")
  local devicon = require("core.utils.functions").get_icons(fname, extension)
  vim.api.nvim_set_hl(0, "FileIconWinBar", { fg = devicon.highlight, bold = true })

  if is_empty(fname) and not buf_mod then
    return ""
  elseif not is_empty(fname) and buf_mod then
    return table.concat({
      devicon.icon,
      space,
      fname,
      space,
      icon.ui.Pencil,
      space,
    })
  else
    return table.concat({
      devicon.icon,
      space,
      fname,
      space,
    })
  end
end

local get_gps = function()
  local status_ok_gps, gps = pcall(require, "nvim-navic")
  if not status_ok_gps then
    return ""
  end

  local status_ok, gps_location = pcall(gps.get_location, {})
  if not status_ok then
    return ""
  end

  if not gps.is_available() or gps_location == "error" then
    return ""
  end
  if not is_empty(gps_location) then
    return gps_location .. space
  else
    return ""
  end
end

local function active()
  return table.concat({
    "%#WinBar#",
    get_gps(),
    "%=",
    "%#FileIconWinBar#",
    filename(),
  })
end

local function inactive()
  return ""
end

local function file_explorer()
  return table.concat({ "%#WinbarFile#", "%=", "File Tree", "%=" })
end

M.draw = function()
  local disable_winabar = { "alpha", "toggleterm", "" }
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
