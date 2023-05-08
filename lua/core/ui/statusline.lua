Statusline = {}

local is_empty = require("core.utils.functions").isempty
local is_match = require("core.utils.functions").ismatch
local icon = require("core.icons")

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
  return table.concat({
    update_mode_colors(),
    modes[current_mode],
    "%#Normal#",
  }, " ")
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
  local render_vcs = {}

  if is_empty(git_info) then
    return ""
  else
    table.insert(render_vcs, "%#StatusLineGit#" .. string.format("%s %s", icon.git.Branch, git_info.head:upper()))
    if not is_empty(git_info.added) then
      table.insert(render_vcs, "%#StatusLineGitAdd#" .. string.format("%s %s", icon.git.LineAdded, git_info.added))
    end
    if not is_empty(git_info.changed) then
      table.insert(
        render_vcs,
        "%#StatusLineGitChange#" .. string.format("%s %s", icon.git.LineModified, git_info.changed)
      )
    end
    if not is_empty(git_info.removed) then
      table.insert(
        render_vcs,
        "%#StatusLineGitRemove#" .. string.format("%s %s", icon.git.LineRemoved, git_info.removed)
      )
    end
  end
  return table.concat(render_vcs, " ") .. "%#Normal#"
end

local function lsp()
  local names = {}
  for _, server in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
    table.insert(names, server.name)
  end
  if #names > 0 then
    return "%#StatusLineLsp#" .. "[ " .. table.concat(names, " ") .. "]"
  else
    return ""
  end
end

local function diagnostics()
  local count = {}
  local render_diag = {}
  local levels = {
    errors = "Error",
    warnings = "Warn",
    info = "Info",
    hints = "Hint",
  }

  for k, level in pairs(levels) do
    count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
  end

  if count["errors"] ~= 0 then
    table.insert(
      render_diag,
      "%#DiagnosticError#" .. string.format("%s %s", icon.diagnostics.BoldError, count["errors"])
    )
  end
  if count["warnings"] ~= 0 then
    table.insert(
      render_diag,
      "%#DiagnosticWarn#" .. string.format("%s %s", icon.diagnostics.BoldWarning, count["warnings"])
    )
  end
  if count["hints"] ~= 0 then
    table.insert(render_diag, "%#DiagnosticInfo#" .. string.format("%s %s", icon.diagnostics.BoldHint, count["hints"]))
  end
  if count["info"] ~= 0 then
    table.insert(
      render_diag,
      "%#DiagnosticWarn#" .. string.format("%s %s", icon.diagnostics.BoldInformation, count["info"])
    )
  end

  return table.concat(render_diag, " ") .. "%#Normal#"
end

local function filetype()
  local fname = vim.fn.expand("%:t")
  local extension = vim.fn.expand("%:e")
  local ftype = vim.bo.filetype:upper()
  local devicon = require("core.utils.functions").get_icons(fname, extension)
  vim.api.nvim_set_hl(0, "FileIcon", { fg = devicon.highlight })
  return "%#FileIcon#" .. string.format("%s %s", devicon.icon, ftype)
end

local function lineinfo()
  return "%#StatusLineInfo#" .. "%P %l:%c"
end

-- local function scrollbar()
--   local current_line = vim.api.nvim_win_get_cursor(0)[1]
--   local total_line = vim.api.nvim_buf_line_count(0)
--   local i = math.floor((current_line - 1) / total_line * #icon.line_bar) + 1 -- i value ranges from 1 to length of line_bar
--   return string.format("%s", icon.line_bar[i])
-- end

local function searchcount()
  if vim.v.hlsearch == 0 then
    return ""
  end

  local result = vim.fn.searchcount({ maxcount = 999, timeout = 500 })
  local denominator = math.min(result.total, result.maxcount)
  return "%#StatusLineOthers#" .. string.format("󰱽 [%d/%d]", result.current, denominator)
end

local function plugin_updates()
  local update_status = require("lazy.status").has_updates()
  if update_status then
    return "%#StatusLineOthers#" .. require("lazy.status").updates()
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
  if winwidth >= 90 then
    return table.concat(
      vim.tbl_filter(function(val)
        return not is_empty(val)
      end, {
        mode(),
        filename(),
        diagnostics(),
        "%=",
        lsp(),
        "%=",
        vcs(),
        filetype(),
        lineinfo(),
        searchcount(),
        plugin_updates(),
      }),
      " "
    )
  else
    return table.concat(
      vim.tbl_filter(function(val)
        return not is_empty(val)
      end, {
        mode(),
        diagnostics(),
        "%=",
        searchcount(),
        lineinfo(),
      }),
      " "
    )
  end
end

local function inactive()
  return "%#StatuslineTransparent#"
end

function Statusline.draw()
  -- Add filetypes to the list for which you don't want statusline
  local disable_statusline = { "NvimTree", "alpha", "TelescopePrompt", "lazy", "toggleterm", "" }
  local buffer_type = vim.bo.filetype
  if is_match(disable_statusline, buffer_type) then
    return inactive()
  else
    return active()
  end
end

return Statusline
