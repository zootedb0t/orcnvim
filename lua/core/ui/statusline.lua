Statusline = {}

-- Import highlights, icons and function
require("core.ui.highlight").statusline_highlight()
local icon = require("core.icons")
local is_empty = require("core.utils").isempty
local is_match = require("core.utils").ismatch
local devicon = require("core.utils").get_icons
-- Add filetypes to the list for which you don't want statusline before unpack statement
local disable_statusline = {
  "TelescopePrompt",
  "lazy",
  "NvimTree",
  unpack(require("core.utils").disable() or {}),
}

local function update_mode_colors()
  local current_mode = vim.api.nvim_get_mode().mode
  local mode_color = ""
  if current_mode == "n" then
    mode_color = "%#StatusLineAccent#"
  elseif current_mode == "i" or current_mode == "ic" then
    mode_color = "%#StatusLineInsertAccent#"
  elseif current_mode == "v" or current_mode == "V" or current_mode == "" then
    mode_color = "%#StatusLineVisualAccent#"
  elseif current_mode == "R" then
    mode_color = "%#StatusLineReplaceAccent#"
  elseif current_mode == "c" then
    mode_color = "%#StatusLineCmdLineAccent#"
  elseif current_mode == "t" then
    mode_color = "%#StatusLineTerminalAccent#"
  end
  return mode_color
end

local modes = {
  ["n"] = "NORMAL",
  ["no"] = "O-PENDING",
  ["nov"] = "O-PENDING",
  ["noV"] = "O-PENDING",
  ["no\22"] = "O-PENDING",
  ["niI"] = "NORMAL",
  ["niR"] = "NORMAL",
  ["niV"] = "NORMAL",
  ["nt"] = "NORMAL",
  ["ntT"] = "NORMAL",
  ["v"] = "VISUAL",
  ["vs"] = "VISUAL",
  ["V"] = "V-LINE",
  ["Vs"] = "V-LINE",
  ["\22"] = "V-BLOCK",
  ["\22s"] = "V-BLOCK",
  ["s"] = "SELECT",
  ["S"] = "S-LINE",
  ["\19"] = "S-BLOCK",
  ["i"] = "INSERT",
  ["ic"] = "INSERT",
  ["ix"] = "INSERT",
  ["R"] = "REPLACE",
  ["Rc"] = "REPLACE",
  ["Rx"] = "REPLACE",
  ["Rv"] = "V-REPLACE",
  ["Rvc"] = "V-REPLACE",
  ["Rvx"] = "V-REPLACE",
  ["c"] = "COMMAND",
  ["cv"] = "EX",
  ["ce"] = "EX",
  ["r"] = "REPLACE",
  ["rm"] = "MORE",
  ["r?"] = "CONFIRM",
  ["!"] = "SHELL",
  ["t"] = "TERMINAL",
}

local function mode()
  local current_mode = vim.api.nvim_get_mode().mode
  local mode_text = modes[current_mode] or ""
  return table.concat({
    update_mode_colors(),
    icon.ui.Neovim .. " " .. mode_text,
    "%#Normal#",
  })
end

local function filename()
  local fname = vim.fn.expand("%:t")
  return not is_empty(fname) and fname or ""
end

local git = function()
  local git_info = vim.b.gitsigns_status_dict
  local git_icon = devicon("git", "")

  if not git_info or vim.tbl_isempty(git_info) then
    return ""
  end

  local render_git = {
    string.format("%%#DevIconGitLogo#%s %s", git_icon.icon, git_info.head),
  }

  local function addGitHighlight(highlightGroup, iconValue, infoType)
    if not is_empty(infoType) then
      table.insert(render_git, string.format("%%#%s#%s %s", highlightGroup, iconValue, infoType))
    end
  end

  addGitHighlight("GitSignsAdd", icon.git.LineAdded, git_info.added)
  addGitHighlight("GitSignsChange", icon.git.LineModified, git_info.changed)
  addGitHighlight("GitSignsDelete", icon.git.LineRemoved, git_info.removed)
  return table.concat(render_git, " ")
end

local function lsp()
  local names = vim.tbl_map(function(server)
    return server.name
  end, vim.lsp.get_clients({ bufnr = 0 }))

  return #names > 0 and "%#Conditional#" .. "[ " .. table.concat(names, " ") .. "]" or ""
end

local function diagnostics()
  local renderDiagnostics = {}
  local severity = vim.diagnostic.severity
  local buffer_diagnostic = vim.diagnostic.count(0)

  local function diagnosticHighlight(highlightGroup, iconValue, type)
    if not is_empty(buffer_diagnostic[type]) then
      table.insert(
        renderDiagnostics,
        string.format("%%#%s#%s %s", highlightGroup, iconValue, buffer_diagnostic[type] or "")
      )
    end
  end

  if buffer_diagnostic == nil or not vim.diagnostic.is_enabled({ bufnr = 0 }) then
    return ""
  else
    diagnosticHighlight("DiagnosticError", icon.diagnostics.Error, severity.ERROR)
    diagnosticHighlight("DiagnosticWarn", icon.diagnostics.Warning, severity.WARN)
    diagnosticHighlight("DiagnosticHint", icon.diagnostics.Hint, severity.HINT)
    diagnosticHighlight("DiagnosticInfo", icon.diagnostics.Information, severity.INFO)
    return table.concat(renderDiagnostics, " ")
  end
end

local function filetype()
  local fname = vim.fn.expand("%:t")
  local extension = vim.fn.expand("%:e")
  local ftype = vim.bo.filetype:upper()
  local file_icon = devicon(fname, extension)
  vim.api.nvim_set_hl(0, "FileIcon", { fg = file_icon.highlight })
  return string.format("%%#FileIcon#%s %s", file_icon.icon, ftype)
end

local function lineinfo()
  return "%#Define#%P %l:%c"
end

-- local function scrollbar()
--   local current_line = vim.api.nvim_win_get_cursor(0)[1]
--   local total_line = vim.api.nvim_buf_line_count(0)
--   local i = math.floor((current_line - 1) / total_line * #icon.line_bar) + 1 -- i value ranges from 1 to length of line_bar
--   return string.format("%s", icon.line_bar[i])
-- end

local function searchcount()
  local result = vim.fn.searchcount({ maxcount = 999, timeout = 500 })
  local denominator = math.min(result.total, result.maxcount)
  return vim.v.hlsearch > 0 and string.format("%%#Type#󰱽 [%d/%d]", result.current, denominator) or ""
end

local function plugin_updates()
  local lazy_info = require("lazy.status")
  return lazy_info.has_updates() and "%#Boolean#" .. lazy_info.updates() or ""
end

local function active()
  local parts
  local winwidth = vim.o.laststatus == 3 and vim.o.columns or vim.api.nvim_win_get_width(0)
  if winwidth >= 90 then
    parts = {
      mode(),
      filename(),
      diagnostics(),
      "%=",
      lsp(),
      "%=",
      git(),
      filetype(),
      lineinfo(),
      searchcount(),
      plugin_updates(),
    }
  else
    parts = {
      mode(),
      diagnostics(),
      "%=",
      searchcount(),
      lineinfo(),
    }
  end
  return table.concat(
    vim.tbl_filter(function(val)
      return not is_empty(val)
    end, parts),
    " "
  )
end

local function inactive()
  return "%#Normal#"
end

function Statusline.draw()
  local buffer_type = vim.bo.filetype
  return is_match(disable_statusline, buffer_type) and inactive() or active()
end

return Statusline
