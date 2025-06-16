Statusline = {}

-- Import highlights, icons and function
require("orcnvim.ui.highlight").statusline_highlight()
local icon = require("orcnvim.icons")
local is_empty = require("orcnvim.utils").isempty
local is_match = require("orcnvim.utils").ismatch
local devicon = require("orcnvim.utils").get_icons
-- Add filetypes to the list for which you don't want statusline before unpack statement
local disable_statusline = {
  "TelescopePrompt",
  "lazy",
  "NvimTree",
  unpack(require("orcnvim.utils").disable() or {}),
}

local mode_colors = {
  n = "%#StatusLineAccent#",
  no = "%#StatusLineAccent#",
  i = "%#StatusLineInsertAccent#",
  ic = "%#StatusLineInsertAccent#",
  v = "%#StatusLineVisualAccent#",
  V = "%#StatusLineVisualAccent#",
  ["\22"] = "%#StatusLineVisualAccent#", -- CTRL-V (Visual Block)
  R = "%#StatusLineReplaceAccent#",
  c = "%#StatusLineCmdLineAccent#",
  t = "%#StatusLineTerminalAccent#",
}

local function update_mode_colors()
  return mode_colors[vim.api.nvim_get_mode().mode] or ""
end

-- Statusline Mode component
local modes = {
  n = "NORMAL",
  no = "O-PENDING",
  nov = "O-PENDING",
  noV = "O-PENDING",
  ["no\22"] = "O-PENDING",
  niI = "NORMAL",
  niR = "NORMAL",
  niV = "NORMAL",
  nt = "NORMAL",
  ntT = "NORMAL",
  v = "VISUAL",
  vs = "VISUAL",
  V = "V-LINE",
  Vs = "V-LINE",
  ["\22"] = "V-BLOCK",
  ["\22s"] = "V-BLOCK",
  s = "SELECT",
  S = "S-LINE",
  ["\19"] = "S-BLOCK",
  i = "INSERT",
  ic = "INSERT",
  ix = "INSERT",
  R = "REPLACE",
  Rc = "REPLACE",
  Rx = "REPLACE",
  Rv = "V-REPLACE",
  Rvc = "V-REPLACE",
  Rvx = "V-REPLACE",
  c = "COMMAND",
  cv = "EX",
  ce = "EX",
  r = "REPLACE",
  rm = "MORE",
  ["r?"] = "CONFIRM",
  ["!"] = "SHELL",
  t = "TERMINAL",
}

local function mode()
  local current_mode = vim.api.nvim_get_mode().mode
  local mode_text = modes[current_mode] or ""
  return update_mode_colors() .. icon.ui.Neovim .. " " .. mode_text .. "%#Normal#"
end

-- Statusline Filename component
local function filename()
  return vim.fn.expand("%:t") or ""
end

-- Statusline Git component
local git_stats = {
  { group = "GitSignsAdd", icon = icon.git.LineAdded, key = "added " },
  { group = "GitSignsChange", icon = icon.git.LineModified, key = "changed" },
  { group = "GitSignsDelete", icon = icon.git.LineRemoved, key = "removed" },
}

local git = function()
  local git_info = vim.b.gitsigns_status_dict

  if is_empty(git_info) then
    return ""
  end

  local parts, idx = {}, 1
  parts[idx] = string.format("%%#DevIcon.git#%s %s", icon.git.Branch, git_info.head)

  for i = 1, #git_stats do
    local cfg = git_stats[i]
    local value = git_stats[cfg.key]
    if not is_empty(value) then
      -- Manual indexing is faster
      idx = idx + 1
      parts[idx] = string.format("%%#%s#%s %s", cfg.group, cfg.icon, value)
    end
  end

  return table.concat(parts, " ")
end

-- Statusline LSP component
local function lsp()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if vim.tbl_isempty(clients) then
    return ""
  end

  local active_clients, idx = {}, 0

  for _, client in ipairs(clients) do
    idx = idx + 1
    active_clients[idx] = client.name
  end

  return string.format("%%#Conditional#[%s %s]", icon.ui.Gear, table.concat(active_clients, " "))
end

-- Statusline diagnostic component
local severity = vim.diagnostic.severity
local severity_map = {
  [severity.ERROR] = { group = "DiagnosticError", icon = icon.diagnostics.Error },
  [severity.WARN] = { group = "DiagnosticWarn", icon = icon.diagnostics.Warning },
  [severity.HINT] = { group = "DiagnosticHint", icon = icon.diagnostics.Hint },
  [severity.INFO] = { group = "DiagnosticInfo", icon = icon.diagnostics.Information },
}
local function diagnostics()
  if not vim.diagnostic.is_enabled({ bufnr = 0 }) then
    return ""
  end

  local count = vim.diagnostic.count(0)
  if not count or vim.tbl_isempty(count) then
    return ""
  end

  local result, idx = {}, 0
  for sev, data in pairs(severity_map) do
    local n = count[sev]
    if n and n > 0 then
      idx = idx + 1
      result[idx] = string.format("%%#%s#%s %d", data.group, data.icon, n)
    end
  end

  return table.concat(result, " ")
end

local function filetype()
  local ftype = vim.bo.filetype
  if ftype == "" then
    return ""
  end

  local buf = vim.api.nvim_buf_get_name(0)
  local name, ext = vim.fn.fnamemodify(buf, ":t"), vim.fn.fnamemodify(buf, ":e")

  local icon_data = devicon(name, ext)
  local file_icon = icon_data and icon_data.icon or ""
  local hl = icon_data and icon_data.highlight or "Comment"

  return string.format("%%#%s#%s %s", hl, file_icon, ftype:upper())
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

-- Statusline Searchcount component
local function searchcount()
  if vim.v.hlsearch == 0 then
    return ""
  end

  local result = vim.fn.searchcount({ maxcount = 999, timeout = 500 })
  local current = result.current or 0
  local total = result.total or 0
  local maxcount = result.maxcount or 999
  local display_total = total > maxcount and maxcount or total

  return string.format("%%#Type#%s [%d/%d]", icon.ui.Search, current, display_total)
end

-- Statusline Plugin component
local function plugin_updates()
  local lazy_info = require("lazy.status")
  return lazy_info.has_updates() and "%#Boolean#" .. lazy_info.updates() or ""
end

-- Statusline LSP-Progress component
local progress_status = {
  client = nil,
  kind = nil,
  title = nil,
  percentage = nil,
}
local progress_augroup = vim.api.nvim_create_augroup("lsp-progress/statusline", { clear = true })
-- local autocmd_created = false

vim.api.nvim_create_autocmd("LspProgress", {
  group = progress_augroup,
  desc = "Update LSP progress in statusline",
  pattern = { "begin", "end", "report" },
  callback = function(args)
    local data = args.data
    if not data or not data.params then
      return
    end

    local client = vim.lsp.get_client_by_id(data.client_id)
    if not client then
      return
    end

    -- Update fields in-place instead of reassigning whole table
    progress_status.client = client.name
    progress_status.kind = data.params.value.kind
    progress_status.title = data.params.value.title
    progress_status.percentage = data.params.value.percentage or ""

    if progress_status.kind == "end" then
      progress_status.title = nil
      vim.defer_fn(function()
        vim.cmd.redrawstatus()
      end, 1000)
    else
      vim.cmd.redrawstatus()
    end
  end,
})

local function lsp_progress()
  if not progress_status.client or not progress_status.title then
    return ""
  end

  return string.format(
    "%%#Conditional#%s [%s]",
    progress_status.title,
    progress_status.percentage ~= "" and (progress_status.percentage .. "%%") or ""
  )
end

local function active()
  local winwidth = vim.fn.winwidth(0)

  local components = winwidth >= 90
      and {
        mode,
        filename,
        diagnostics,
        "%=",
        lsp,
        lsp_progress,
        "%=",
        git,
        filetype,
        lineinfo,
        searchcount,
        plugin_updates,
      }
    or {
      mode,
      diagnostics,
      "%=",
      lineinfo,
    }

  local parts, idx = {}, 1

  for i = 1, #components do
    local component = components[i]
    local value = type(component) == "function" and component() or component
    if not is_empty(value) then
      parts[idx] = value
      idx = idx + 1
    end
  end

  return table.concat(parts, " ")
end

local function inactive()
  return "%#Normal#"
end

function Statusline.draw()
  local buffer_type = vim.bo.filetype
  return is_match(disable_statusline, buffer_type) and inactive() or active()
end

return Statusline
