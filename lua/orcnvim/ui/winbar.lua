local M = {}

-- Import highlights, icons and functions
local is_empty = require("orcnvim.utils").isempty
local is_match = require("orcnvim.utils").ismatch
local devicon = require("orcnvim.utils").get_icons
local disable_winbar = require("orcnvim.utils").disable()
local icon = require("orcnvim.icons")
local space = " "

local function filename()
  local fname = vim.fn.expand("%:t")
  local extension = vim.fn.expand("%:e")

  if fname == "" and not vim.bo.modified then
    return ""
  end

  local fileicon = devicon(fname, extension)
  local icon_str = "%#FileIcon#" .. fileicon.icon .. " " .. fname

  if vim.bo.modified then
    icon_str = icon_str .. " " .. icon.ui.Pencil
  end

  return icon_str
end

local get_gps = function()
  local status_ok_gps, gps = pcall(require, "nvim-navic")
  if status_ok_gps then
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
      -- separator = space .. icon.ui.BoldDividerRight .. space,
      separator = space .. icon.ui.DividerRight .. space,
      click = true,
    })
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
    get_gps(),
    "%=",
    filename(),
  }, "")
end

local function inactive()
  return "%#WinBar#"
end

local function file_explorer()
  return "%#WinbarFile#%= File Tree%="
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
