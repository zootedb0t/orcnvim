local M = {}

-- Import highlights
require("core.ui.highlight").winbar_highlight()
local is_empty = require("core.utils").isempty
local is_match = require("core.utils").ismatch
local devicon = require("core.utils").get_icons
local disable_winbar = require("core.utils").disable()
local icon = require("core.icons")
local space = " "

local function filename()
  local buf_mod = vim.bo.modified
  local fname = vim.fn.expand("%:t")
  local extension = vim.fn.expand("%:e")
  local fileicon_hl = devicon(fname, extension)
  vim.api.nvim_set_hl(0, "FileIconWinBar", { fg = fileicon_hl.highlight, bold = true })

  if is_empty(fname) and not buf_mod then
    return ""
  elseif not is_empty(fname) and buf_mod then
    return table.concat({
      "%#FileIconWinBar#",
      fileicon_hl.icon,
      fname,
      icon.ui.Pencil,
    }, " ")
  else
    return table.concat({
      "%#FileIconWinBar#",
      fileicon_hl.icon,
      fname,
    }, " ")
  end
end

local get_gps = function()
  local status_ok_gps, gps = pcall(require, "nvim-navic")
  gps.setup({
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
    return gps_location
  else
    return ""
  end
end

local function active()
  return table.concat({
    "%#WinBar#",
    get_gps(),
    "%=",
    filename(),
  }, " ")
end

local function inactive()
  return "%#WinBar#" .. ""
end

local function file_explorer()
  return table.concat({ "%#WinbarFile#", "%=", "File Tree", "%=" })
end

M.draw = function()
  local buffer_type = vim.bo.filetype
  if is_match(disable_winbar, buffer_type) then
    return inactive()
  elseif buffer_type == "NvimTree" then
    return file_explorer()
  else
    return active()
  end
end

return M
