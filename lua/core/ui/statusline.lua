Statusline = {}

local is_empty = require("core.utils.functions").isempty
local is_match = require("core.utils.functions").ismatch
local icon = require("core.icons")
local space = " "

-- Import highlights
require("core.ui.highlight").statusline_highlight()

local function update_mode_colors()
  local current_mode = vim.api.nvim_get_mode().mode
  local mode_color = "%#StatusLineAccent#"
  if current_mode == "n" then
    mode_color = "%#StatuslineAccent#"
  elseif current_mode == "i" or current_mode == "ic" then
    mode_color = "%#StatuslineInsertAccent#"
  elseif current_mode == "v" or current_mode == "V" or current_mode == "" then
    mode_color = "%#StatuslineVisualAccent#"
  elseif current_mode == "R" then
    mode_color = "%#StatuslineReplaceAccent#"
  elseif current_mode == "c" then
    mode_color = "%#StatuslineCmdLineAccent#"
  elseif current_mode == "t" then
    mode_color = "%#StatuslineTerminalAccent#"
  end
  return mode_color
end

local modes = {
  ["n"] = "NORMAL",
  ["no"] = "NORMAL",
  ["v"] = "VISUAL",
  ["V"] = "VISUAL LINE",
  [""] = "VISUAL BLOCK",
  ["s"] = "SELECT",
  ["S"] = "SELECT LINE",
  [""] = "SELECT BLOCK",
  ["i"] = "INSERT",
  ["ic"] = "INSERT",
  ["R"] = "REPLACE",
  ["Rv"] = "VISUAL REPLACE",
  ["c"] = "COMMAND",
  ["cv"] = "VIM EX",
  ["ce"] = "EX",
  ["r"] = "PROMPT",
  ["rm"] = "MOAR",
  ["r?"] = "CONFIRM",
  ["!"] = "SHELL",
  ["t"] = "TERMINAL",
}

local function mode()
  local current_mode = vim.api.nvim_get_mode().mode
  return string.format("%s", modes[current_mode]):upper()
end

local function filename()
  local fname = vim.fn.expand("%:t")
  if is_empty(fname) then
    return ""
  else
    return string.format("%s", fname)
  end
end

local vcs = function()
  local git_info = vim.b.gitsigns_status_dict
  local branch
  local added, changed, removed
  if is_empty(git_info) then
    return ""
  else
    branch = string.format("%s %s ", icon.git.Branch, git_info.head:upper())
  end

  if is_empty(git_info.added) then
    added = ""
  else
    added = string.format("%s %s ", icon.git.LineAdded, git_info.added)
  end

  if is_empty(git_info.changed) then
    changed = ""
  else
    changed = string.format("%s %s ", icon.git.LineModified, git_info.changed)
  end

  if is_empty(git_info.removed) then
    removed = ""
  else
    removed = string.format("%s %s ", icon.git.LineRemoved, git_info.removed)
  end

  return table.concat({
    branch,
    added,
    changed,
    removed,
  })
end

local function lsp()
  local names = {}
  for _, server in pairs(vim.lsp.buf_get_clients(0)) do
    table.insert(names, server.name)
  end
  if #names > 0 then
    return "[" .. table.concat(names, " ") .. "]"
  else
    return ""
  end
end

local function diagnostics()
  local count = {}
  local levels = {
    errors = "Error",
    warnings = "Warn",
    info = "Info",
    hints = "Hint",
  }

  for k, level in pairs(levels) do
    count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
  end

  local errors, warnings, hints, info

  if count["errors"] ~= 0 then
    errors = string.format("%s %s ", icon.diagnostics.BoldError, count["errors"])
  else
    errors = ""
  end
  if count["warnings"] ~= 0 then
    warnings = string.format("%s %s ", icon.diagnostics.BoldWarning, count["warnings"])
  else
    warnings = ""
  end
  if count["hints"] ~= 0 then
    hints = string.format("%s %s ", icon.diagnostics.BoldHint, count["hints"])
  else
    hints = ""
  end
  if count["info"] ~= 0 then
    info = string.format("%s %s", icon.diagnostics.BoldInformation, count["info"])
  else
    info = ""
  end

  return table.concat({
    "%#DiagnosticError#",
    errors,
    "%#DiagnosticWarn#",
    warnings,
    "%#DiagnosticInfo#",
    hints,
    "%#DiagnosticWarn#",
    info,
  })
end

local function filetype()
  local fname = vim.fn.expand("%:t")
  local extension = vim.fn.expand("%:e")
  local ftype = vim.bo.filetype
  local file_icon = require("nvim-web-devicons").get_icon(fname, extension, { default = true })
  if is_empty(file_icon) then
    return ""
  end
  return string.format("%s %s", file_icon, ftype)
end

local function lineinfo()
  return "%P %l:%c"
end

local function scrollbar()
  local current_line = vim.api.nvim_win_get_cursor(0)[1]
  local total_line = vim.api.nvim_buf_line_count(0)
  local i = math.floor((current_line - 1) / total_line * #icon.line_bar) + 1 -- i value ranges from 1 to length of line_bar
  return string.format("%s", icon.line_bar[i])
end

local function plugin_updates()
  local update_status = require("lazy.status").has_updates()
  if update_status then
    return space .. require("lazy.status").updates()
  else
    return ""
  end
end

local function active()
  local winwidth
  if vim.o.laststatus == 3 then
    winwidth = vim.o.columns
  else
    winwidth = vim.api.nvim_win_get_width(0)
  end
  if winwidth >= 85 then
    return table.concat({
      update_mode_colors(),
      space,
      mode(),
      space,
      "%#Normal# ",
      filename(),
      space,
      "%#Normal#",
      diagnostics(),
      "%#Normal#",
      "%=",
      lsp(),
      "%=",
      vcs(),
      filetype(),
      space,
      lineinfo(),
      space,
      "%#ScrollBar#",
      scrollbar(),
      space,
      plugin_updates(),
    })
  else
    return table.concat({
      update_mode_colors(),
      space,
      mode(),
      space,
      "%#Normal#",
      space,
      diagnostics(),
      "%=",
      "%#Normal#",
      lineinfo(),
    })
  end
end

local function inactive()
  return "%#StatuslineTransparent#"
end

function Statusline.draw()
  -- Add filetypes to the list for which you don't want statusline
  local disable_statusline = { "NvimTree", "alpha", "TelescopePrompt", "lazy", "" }
  local buffer_type = vim.bo.filetype
  if is_match(disable_statusline, buffer_type) then
    return inactive()
  else
    return active()
  end
end

return Statusline
