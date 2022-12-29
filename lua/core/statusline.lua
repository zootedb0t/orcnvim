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
  return string.format(" %s ", modes[current_mode]):upper()
end

local function filename()
  local fname = vim.fn.expand("%:t")
  if fname == "" then
    return ""
  end
  return fname .. " "
end

local vcs = function()
  local git_info = vim.b.gitsigns_status_dict or { head = "", added = 0, changed = 0, removed = 0 }
  if not git_info or git_info.head == "" then
    return ""
  end
  local added, changed, removed
  if git_info.added == 0 then
    added = ""
  else
    added = "  " .. tostring(git_info.added)
  end

  if git_info.changed == 0 then
    changed = ""
  else
    changed = "   " .. tostring(git_info.changed)
  end

  if git_info.removed == 0 then
    removed = ""
  else
    removed = "  " .. tostring(git_info.removed)
  end

  return table.concat({
    " " .. git_info.head:upper(),
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
  if #names == 0 then
    return ""
  end
  if #names > 0 then
    return " [" .. table.concat(names, " ") .. "]"
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

  local errors = ""
  local warnings = ""
  local hints = ""
  local info = ""

  if count["errors"] ~= 0 then
    errors = "  " .. count["errors"]
  end
  if count["warnings"] ~= 0 then
    warnings = "   " .. count["warnings"]
  end
  if count["hints"] ~= 0 then
    hints = "  " .. count["hints"]
  end
  if count["info"] ~= 0 then
    info = "  " .. count["info"]
  end

  return "%#DiagnosticError#"
      .. errors
      .. "%#DiagnosticWarn#"
      .. warnings
      .. "%#DiagnosticInfo#"
      .. hints
      .. "%#DiagnosticWarn#"
      .. info
end

local function filetype()
  local fname = vim.fn.expand("%:t")
  local extension = vim.fn.expand("%:e")
  local ftype = vim.bo.filetype
  if ftype == "" then
    return ""
  else
    local icon = require("nvim-web-devicons").get_icon(fname, extension, { default = true })
    return string.format(" %s %s ", icon, ftype)
  end
end

local function lineinfo()
  if vim.bo.filetype == "alpha" then
    return ""
  end
  return " %P %l:%c "
end

Statusline = {}

function Statusline.active()
  local winwidth
  if vim.o.laststatus == 3 then
    winwidth = vim.o.columns
  else
    winwidth = vim.api.nvim_win_get_width(0)
  end
  if winwidth >= 85 then
    return table.concat({
      update_mode_colors(),
      mode(),
      "%#Normal# ",
      filename(),
      "%#Normal#",
      diagnostics(),
      "%#Normal#",
      "%=",
      lsp(),
      "%=",
      vcs(),
      filetype(),
      lineinfo(),
    })
  else
    return table.concat({
      update_mode_colors(),
      mode(),
      "%#Normal#",
      diagnostics(),
      "%=",
      -- vcs(),
      "%#Normal#",
      lineinfo(),
    })
  end
end

function Statusline.inactive()
  return " %F"
end

function Statusline.short()
  return "%#Normal#"
end

return Statusline
